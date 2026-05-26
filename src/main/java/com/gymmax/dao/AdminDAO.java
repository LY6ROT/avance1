package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.SocioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

 // =========================================================
    // LISTAR TODOS LOS SOCIOS PARA LA TABLA DE GESTIÓN (SIN DNI)
    // =========================================================
    public java.util.List<SocioDTO> listarTodosLosSocios() {
        java.util.List<SocioDTO> lista = new java.util.ArrayList<>();
        
        // Quitamos u.dni de la consulta SQL
        String sql = "SELECT s.id_socio, u.id_usuario, u.nombres, u.apellidos, u.correo " +
                     "FROM SOCIO s INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario";
                     
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
             
            while (rs.next()) {
                SocioDTO socio = new SocioDTO();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setIdUsuario(rs.getInt("id_usuario"));
                socio.setNombres(rs.getString("nombres"));
                socio.setApellidos(rs.getString("apellidos"));
                
                // Unimos nombre y apellido para la vista
                socio.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
                
                socio.setCorreo(rs.getString("correo"));
                
                // Como no hay DNI en la BD, mandamos un texto por defecto
                socio.setDni("No registrado");
                socio.setFechaRegistro("Activo"); 
                
                lista.add(socio);
            }
        } catch (Exception e) {
            System.out.println("Error al listar socios: " + e.getMessage());
        }
        return lista;
    }
    // =========================================================
    // MÉTODO PARA LLENAR LAS 4 TARJETAS DEL DASHBOARD DEL ADMIN
    // =========================================================

    public java.util.Map<String, String> obtenerEstadisticasDashboard() {
        java.util.Map<String, String> stats = new java.util.HashMap<>();
        stats.put("sociosActivos", "0");
        stats.put("ingresosMes", "0.00");
        stats.put("membresiasVencer", "0");
        stats.put("reservasHoy", "0");

        // 1. Socios totales
        String sqlSocios = "SELECT COUNT(*) AS total FROM SOCIO";

        // 2. Ingresos del mes (Ahora busca el estado oficial 'OK')
        String sqlIngresos = "SELECT COALESCE(SUM(monto), 0) AS total FROM PAGO WHERE MONTH(fecha_pago) = MONTH(CURDATE()) AND YEAR(fecha_pago) = YEAR(CURDATE()) AND estado = 'OK'";

        // 3. Membresías por vencer (en los próximos 7 días)
        String sqlVencer = "SELECT COUNT(*) AS total FROM MEMBRESIA WHERE estado = 'ACT' AND fecha_fin BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)";

        // 4. Reservas de hoy
        String sqlReservas = "SELECT COUNT(*) AS total FROM RESERVA WHERE fecha = CURDATE() AND estado = 'CONF'";

        try (Connection con = ConexionDB.getConexion()) {
            try (PreparedStatement ps = con.prepareStatement(sqlSocios); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("sociosActivos", String.valueOf(rs.getInt("total")));
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlIngresos); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("ingresosMes", String.format("%.2f", rs.getDouble("total")));
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlVencer); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("membresiasVencer", String.valueOf(rs.getInt("total")));
                }
            }
            try (PreparedStatement ps = con.prepareStatement(sqlReservas); ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    stats.put("reservasHoy", String.valueOf(rs.getInt("total")));
                }
            }
        } catch (Exception e) {
            System.out.println("Error obteniendo métricas Admin: " + e.getMessage());
        }
        return stats;
    }
    // =========================================================
    // ELIMINAR SOCIO (Con protección de llaves foráneas)
    // =========================================================
    public boolean eliminarSocio(int idSocio) {
        boolean exito = false;
        String sql = "DELETE FROM SOCIO WHERE id_socio = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idSocio);
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
            
        } catch (Exception e) {
            // Si el socio tiene reservas o pagos, MySQL lanzará una excepción y no lo borrará (lo cual es bueno para auditoría)
            System.out.println("Error al eliminar socio (Posible conflicto de llaves): " + e.getMessage());
        }
        return exito;
    }
   // =========================================================
    // ACTUALIZAR DATOS DE SOCIO (SIN DNI)
    // =========================================================
    public boolean actualizarSocio(int idUsuario, String nombres, String apellidos, String dni, String correo) {
        boolean exito = false;
        // Quitamos la actualización del DNI en el SQL
        String sql = "UPDATE USUARIO SET nombres = ?, apellidos = ?, correo = ? WHERE id_usuario = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombres);
            ps.setString(2, apellidos);
            ps.setString(3, correo);
            ps.setInt(4, idUsuario); // El ID ahora es el parámetro 4
            
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al actualizar datos del socio: " + e.getMessage());
        }
        return exito;
    }
}
