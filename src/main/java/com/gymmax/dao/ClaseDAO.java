package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Clase;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class ClaseDAO {

    public List<Clase> listarClases() {
        List<Clase> lista = new ArrayList<>();
        String sql = "SELECT id_clase, id_sede, nombre, tipo, instructor, hora_inicio, cupo_maximo FROM CLASE";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Clase c = new Clase();
                c.setIdClase(rs.getInt("id_clase"));
                c.setIdSede(rs.getInt("id_sede"));
                c.setNombre(rs.getString("nombre"));
                c.setTipo(rs.getString("tipo"));
                c.setInstructor(rs.getString("instructor"));
                c.setHoraInicio(rs.getTime("hora_inicio"));
                c.setCupoMaximo(rs.getInt("cupo_maximo"));
                lista.add(c);
            }
        } catch (Exception e) {
            System.out.println("Error al listar clases: " + e.getMessage());
        }
        return lista;
    }
}