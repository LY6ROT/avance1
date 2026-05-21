package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReservaDAO {

    // 1. Validar la regla de negocio: Máximo 3 cambios de sede al mes
    public boolean puedeReservarEnOtraSede(int idUsuario) {
        int cambiosEsteMes = 0;
        // Cuenta las reservas del mes actual en sedes diferentes a la sede 1 (Sede Principal)
        String sql = "SELECT COUNT(*) AS total_cambios FROM RESERVA r " +
                     "JOIN CLASE c ON r.id_clase = c.id_clase " +
                     "JOIN SOCIO s ON r.id_socio = s.id_socio " +
                     "WHERE s.id_usuario = ? AND c.id_sede != 1 " +
                     "AND MONTH(r.fecha) = MONTH(CURRENT_DATE()) AND YEAR(r.fecha) = YEAR(CURRENT_DATE())";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cambiosEsteMes = rs.getInt("total_cambios");
                }
            }
        } catch (Exception e) {
            System.out.println("Error al validar sede: " + e.getMessage());
        }
        
        // Retorna TRUE si tiene menos de 3 cambios, FALSE si ya llegó al límite
        return cambiosEsteMes < 3;
    }

    // 2. Registrar la reserva
    public boolean registrarReserva(int idUsuario, int idClase, String fecha, String hora) {
        boolean exito = false;
        // Primero verificamos si la clase es en otra sede y validamos la regla
        // Por defecto validamos
        
        
        // Logica para obtener el id_socio basado en el id_usuario de la sesión
        String sqlSocio = "SELECT id_socio FROM SOCIO WHERE id_usuario = ?";
        String sqlReserva = "INSERT INTO RESERVA (id_socio, id_clase, fecha, hora, estado) VALUES (?, ?, ?, ?, 'CONF')";

        try (Connection con = ConexionDB.getConexion()) {
            
            int idSocio = -1;
            // Obtener el ID del socio
            try (PreparedStatement ps1 = con.prepareStatement(sqlSocio)) {
                ps1.setInt(1, idUsuario);
                try (ResultSet rs1 = ps1.executeQuery()) {
                    if (rs1.next()) {
                        idSocio = rs1.getInt("id_socio");
                    }
                }
            }
            
            if (idSocio != -1) {
                // Insertar la reserva
                try (PreparedStatement ps2 = con.prepareStatement(sqlReserva)) {
                    ps2.setInt(1, idSocio);
                    ps2.setInt(2, idClase);
                    ps2.setString(3, fecha);
                    ps2.setString(4, hora);
                    
                    if (ps2.executeUpdate() > 0) {
                        exito = true;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error al registrar reserva: " + e.getMessage());
        }
        return exito;
    }
    // Método para obtener el número exacto de cambios de sede este mes
    public int contarCambiosSede(int idUsuario) {
        int cambiosEsteMes = 0;
        String sql = "SELECT COUNT(*) AS total_cambios FROM RESERVA r " +
                     "JOIN CLASE c ON r.id_clase = c.id_clase " +
                     "JOIN SOCIO s ON r.id_socio = s.id_socio " +
                     "WHERE s.id_usuario = ? AND c.id_sede != 1 " +
                     "AND MONTH(r.fecha) = MONTH(CURRENT_DATE()) AND YEAR(r.fecha) = YEAR(CURRENT_DATE())";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, idUsuario);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    cambiosEsteMes = rs.getInt("total_cambios");
                }
            }
        } catch (Exception e) {
            System.out.println("Error al contar cambios: " + e.getMessage());
        }
        return cambiosEsteMes;
    }
}