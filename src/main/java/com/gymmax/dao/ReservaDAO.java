package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ReservaDAO {

// =========================================================
    // 1. CONTAR CUÁNTAS VECES HA IDO A OTRA SEDE ESTE MES (FINAL)
    // =========================================================
    public int contarVisitasOtraSede(int idUsuario) {
        int cantidad = 0;
        // Cuenta SOLO las reservas confirmadas del mes actual
        String sql = "SELECT COUNT(*) AS total_visitas " +
                     "FROM RESERVA r " +
                     "INNER JOIN CLASE c ON r.id_clase = c.id_clase " +
                     "INNER JOIN SOCIO s ON r.id_socio = s.id_socio " +
                     "WHERE s.id_usuario = ? " +
                     "AND c.id_sede != s.id_sede_principal " +
                     "AND r.estado = 'CONF' " +
                     "AND SUBSTRING(CAST(r.fecha AS CHAR), 1, 7) = SUBSTRING(CAST(CURDATE() AS CHAR), 1, 7)";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cantidad = rs.getInt("total_visitas");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error contando visitas a otra sede: " + e.getMessage());
        }
        return cantidad;
    }
    
    // =========================================================
    // 2. PROCESAR RESERVA APLICANDO LA REGLA DE SEDE PREDETERMINADA
    // =========================================================
    public String registrarReservaSegura(int idUsuario, int idClase, String fecha, String hora) {
        Connection con = null;
        PreparedStatement psClase = null, psSocio = null, psReserva = null;
        ResultSet rsClase = null, rsSocio = null;
        String resultado = "ERROR";

        try {
            con = ConexionDB.getConexion();
            con.setAutoCommit(false);

            // A. Obtener a qué Sede pertenece la clase que quiere reservar
            int idSedeClase = 0;
            String sqlClase = "SELECT id_sede FROM CLASE WHERE id_clase = ?";
            psClase = con.prepareStatement(sqlClase);
            psClase.setInt(1, idClase);
            rsClase = psClase.executeQuery();
            if (rsClase.next()) {
                idSedeClase = rsClase.getInt("id_sede");
            }

            // B. Obtener los datos del Socio (su ID y su Sede Principal)
            int idSocio = 0;
            int idSedePrincipal = 0;
            String sqlSocio = "SELECT id_socio, id_sede_principal FROM SOCIO WHERE id_usuario = ?";
            psSocio = con.prepareStatement(sqlSocio);
            psSocio.setInt(1, idUsuario);
            rsSocio = psSocio.executeQuery();
            if (rsSocio.next()) {
                idSocio = rsSocio.getInt("id_socio");
                idSedePrincipal = rsSocio.getInt("id_sede_principal");
            }

            // REGLA DE NEGOCIO 1: Si es su sede predeterminada, se bloquea la reserva por catálogo
            if (idSedeClase == idSedePrincipal) {
                return "SEDE_PREDETERMINADA";
            }

            // REGLA DE NEGOCIO 2: Si va a otra sede, validar el límite máximo de 3 pases
            int visitasForaneas = contarVisitasOtraSede(idUsuario);
            if (visitasForaneas >= 3) {
                return "LIMITE_EXCEDIDO";
            }

            // Si pasa ambos candados, se registra la reserva foránea con éxito
            String sqlReserva = "INSERT INTO RESERVA (id_socio, id_clase, fecha, hora, estado) VALUES (?, ?, ?, ?, 'CONF')";
            psReserva = con.prepareStatement(sqlReserva);
            psReserva.setInt(1, idSocio);
            psReserva.setInt(2, idClase);
            psReserva.setString(3, fecha);
            psReserva.setString(4, hora);

            if (psReserva.executeUpdate() > 0) {
                con.commit();
                resultado = "EXITO_FORANEA";
            } else {
                con.rollback();
            }

        } catch (SQLException e) {
            System.out.println("Error procesando la reserva: " + e.getMessage());
            try { if (con != null) con.rollback(); } catch (SQLException ex) {}
        } finally {
            try {
                if (rsClase != null) rsClase.close();
                if (rsSocio != null) rsSocio.close();
                if (psClase != null) psClase.close();
                if (psSocio != null) psSocio.close();
                if (psReserva != null) psReserva.close();
                if (con != null) { con.setAutoCommit(true); con.close(); }
            } catch (SQLException e) {}
        }
        return resultado;
    }
    
    // =========================================================
    // 3. LISTAR LAS CLASES DISPONIBLES EN TODAS LAS SEDES
    // =========================================================
    public List<Map<String, String>> listarClasesDisponibles() {
        List<Map<String, String>> lista = new ArrayList<>();
        // Traemos las clases unidas a la tabla sedes para mostrar dónde es
        String sql = "SELECT c.id_clase, c.nombre AS clase, c.tipo, c.instructor, c.hora_inicio, " +
                     "s.nombre AS sede, s.id_sede " +
                     "FROM CLASE c INNER JOIN SEDE s ON c.id_sede = s.id_sede";
                     
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Map<String, String> clase = new HashMap<>();
                clase.put("idClase", String.valueOf(rs.getInt("id_clase")));
                clase.put("clase", rs.getString("clase"));
                clase.put("tipo", rs.getString("tipo"));
                clase.put("instructor", rs.getString("instructor"));
                clase.put("hora", rs.getString("hora_inicio"));
                clase.put("sede", rs.getString("sede"));
                clase.put("idSede", String.valueOf(rs.getInt("id_sede")));
                lista.add(clase);
            }
        } catch (SQLException e) {
            System.out.println("Error al listar clases: " + e.getMessage());
        }
        return lista;
    }
    // =========================================================
    // 4. LISTAR EL HISTORIAL DE RESERVAS DEL SOCIO
    // =========================================================
    public List<Map<String, String>> listarMisReservas(int idUsuario) {
        List<Map<String, String>> lista = new ArrayList<>();
        String sql = "SELECT r.id_reserva, c.nombre AS clase, se.nombre AS sede, r.fecha, r.hora, r.estado " +
                     "FROM RESERVA r " +
                     "INNER JOIN CLASE c ON r.id_clase = c.id_clase " +
                     "INNER JOIN SEDE se ON c.id_sede = se.id_sede " +
                     "INNER JOIN SOCIO s ON r.id_socio = s.id_socio " +
                     "WHERE s.id_usuario = ? " +
                     "ORDER BY r.fecha DESC, r.hora DESC";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, String> res = new HashMap<>();
                    res.put("idReserva", String.valueOf(rs.getInt("id_reserva")));
                    res.put("clase", rs.getString("clase"));
                    res.put("sede", rs.getString("sede"));
                    res.put("fecha", rs.getString("fecha"));
                    res.put("hora", rs.getString("hora"));
                    res.put("estado", rs.getString("estado"));
                    lista.add(res);
                }
            }
        } catch (SQLException e) {
            System.out.println("Error al listar reservas: " + e.getMessage());
        }
        return lista;
    }

// =========================================================
    // 5. CANCELAR UNA RESERVA (A PRUEBA DE SAFE UPDATES Y LONGITUD)
    // =========================================================
    public boolean cancelarReserva(int idReserva, int idUsuario) {
        boolean exito = false;
        // Cambiamos 'CANC' a 'CAN' para evitar el error de "Data truncated"
        String sql = "UPDATE RESERVA SET estado = 'CAN' " +
                     "WHERE id_reserva = ? AND estado = 'CONF' " +
                     "AND id_socio = (SELECT id_socio FROM SOCIO WHERE id_usuario = ?)";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idReserva);
            ps.setInt(2, idUsuario);
            
            if (ps.executeUpdate() > 0) {
                exito = true;
            } else {
                System.out.println("-> DEBUG: No se canceló nada. Revisa que el idReserva exista y el estado sea 'CONF'.");
            }
        } catch (SQLException e) {
            System.out.println("Error al cancelar reserva: " + e.getMessage());
        }
        return exito;
    }
}