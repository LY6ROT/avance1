package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Sede;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SedeDAO {

    // Listar todo el catálogo
    public List<Sede> listarSedes() {
        List<Sede> lista = new ArrayList<>();
        String sql = "SELECT id_sede, nombre, direccion, distrito, telefono, hora_apertura, hora_cierre, capacidad, imagen_url, descripcion FROM SEDE";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                lista.add(mapearSede(rs));
            }
        } catch (Exception e) {
            System.out.println("Error al listar sedes: " + e.getMessage());
        }
        return lista;
    }

    // LÓGICA DEL BUSCADOR: Filtrar por nombre o por distrito
    public List<Sede> buscarSedes(String texto) {
        List<Sede> lista = new ArrayList<>();
        String sql = "SELECT id_sede, nombre, direccion, distrito, telefono, hora_apertura, hora_cierre, capacidad, imagen_url, descripcion " +
                     "FROM SEDE WHERE nombre LIKE ? OR distrito LIKE ?";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            String parametro = "%" + texto + "%";
            ps.setString(1, parametro);
            ps.setString(2, parametro);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    lista.add(mapearSede(rs));
                }
            }
        } catch (Exception e) {
            System.out.println("Error al buscar sedes: " + e.getMessage());
        }
        return lista;
    }

    // Obtener una única sede por su ID (Para la sección Ver Detalle)
    public Sede obtenerSedePorId(int id) {
        Sede sede = null;
        String sql = "SELECT id_sede, nombre, direccion, distrito, telefono, hora_apertura, hora_cierre, capacidad, imagen_url, descripcion FROM SEDE WHERE id_sede = ?";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    sede = mapearSede(rs);
                }
            }
        } catch (Exception e) {
            System.out.println("Error al obtener sede por id: " + e.getMessage());
        }
        return sede;
    }

    // Helper interno para no repetir código de mapeo
    private Sede mapearSede(ResultSet rs) throws Exception {
        Sede s = new Sede();
        s.setIdSede(rs.getInt("id_sede"));
        s.setNombre(rs.getString("nombre"));
        s.setDireccion(rs.getString("direccion"));
        s.setDistrito(rs.getString("distrito"));
        s.setTelefono(rs.getString("telefono"));
        s.setHoraApertura(rs.getTime("hora_apertura"));
        s.setHoraCierre(rs.getTime("hora_cierre"));
        s.setCapacidad(rs.getInt("capacidad"));
        s.setImagenUrl(rs.getString("imagen_url"));
        s.setDescripcion(rs.getString("descripcion"));
        return s;
    }
}