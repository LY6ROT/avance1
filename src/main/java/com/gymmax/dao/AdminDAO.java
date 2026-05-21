package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.SocioDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AdminDAO {

   public List<SocioDTO> listarTodosLosSocios() {
        List<SocioDTO> lista = new ArrayList<>();
        // Corrección: Usamos UPPER() para evitar conflictos de mayúsculas/minúsculas en el rol
        String sql = "SELECT s.id_socio, u.nombres, u.apellidos, s.dni, u.correo, s.fecha_reg " +
                     "FROM SOCIO s INNER JOIN USUARIO u ON s.id_usuario = u.id_usuario " +
                     "WHERE UPPER(u.rol) = 'SOCIO' ORDER BY s.id_socio DESC";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                SocioDTO socio = new SocioDTO();
                socio.setIdSocio(rs.getInt("id_socio"));
                socio.setNombreCompleto(rs.getString("nombres") + " " + rs.getString("apellidos"));
                socio.setDni(rs.getString("dni"));
                socio.setCorreo(rs.getString("correo"));
                socio.setFechaRegistro(rs.getString("fecha_reg"));
                lista.add(socio);
            }
        } catch (Exception e) {
            System.out.println("Error al listar socios en AdminDAO: " + e.getMessage());
        }
        return lista;
    }
}