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
    // 1. INSERTAR NUEVA CLASE
    public boolean insertarClase(Clase c) {
        String sql = "INSERT INTO CLASE (id_sede, nombre, tipo, instructor, hora_inicio, cupo_maximo) VALUES (?,?,?,?,?,?)";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, c.getIdSede());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getTipo());
            ps.setString(4, c.getInstructor());
            ps.setTime(5, c.getHoraInicio());
            ps.setInt(6, c.getCupoMaximo());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al insertar clase: " + e.getMessage());
            return false;
        }
    }

    // 2. ACTUALIZAR CLASE EXISTENTE
    public boolean actualizarClase(Clase c) {
        String sql = "UPDATE CLASE SET id_sede=?, nombre=?, tipo=?, instructor=?, hora_inicio=?, cupo_maximo=? WHERE id_clase=?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, c.getIdSede());
            ps.setString(2, c.getNombre());
            ps.setString(3, c.getTipo());
            ps.setString(4, c.getInstructor());
            ps.setTime(5, c.getHoraInicio());
            ps.setInt(6, c.getCupoMaximo());
            ps.setInt(7, c.getIdClase());
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al actualizar clase: " + e.getMessage());
            return false;
        }
    }

    // 3. ELIMINAR CLASE
    public boolean eliminarClase(int id) {
        String sql = "DELETE FROM CLASE WHERE id_clase = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            System.out.println("Error al eliminar clase: " + e.getMessage());
            return false;
        }
    }
}