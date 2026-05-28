package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Sede;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class SedeDAO {

    // =========================================================
    // LISTAR TODO EL CATÁLOGO
    // =========================================================
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

    // =========================================================
    // LÓGICA DEL BUSCADOR
    // =========================================================
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

    // =========================================================
    // OBTENER SEDE POR ID
    // =========================================================
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

    // =========================================================
    // REGISTRAR NUEVA SEDE (ADMIN)
    // =========================================================
    public boolean registrarSede(String nombre, String direccion, String distrito, String telefono, 
                                 String horaApertura, String horaCierre, int capacidad, 
                                 String imagenUrl, String descripcion) {
        boolean exito = false;
        String sql = "INSERT INTO SEDE (nombre, direccion, distrito, telefono, hora_apertura, hora_cierre, capacidad, imagen_url, descripcion) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombre);
            ps.setString(2, direccion);
            ps.setString(3, distrito);
            ps.setString(4, telefono);
            // Convertimos la hora HH:mm que manda el formulario HTML a formato SQL HH:mm:ss
            ps.setString(5, horaApertura.length() == 5 ? horaApertura + ":00" : horaApertura);
            ps.setString(6, horaCierre.length() == 5 ? horaCierre + ":00" : horaCierre);
            ps.setInt(7, capacidad);
            ps.setString(8, imagenUrl);
            ps.setString(9, descripcion);

            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al registrar sede: " + e.getMessage());
        }
        return exito;
    }

    // =========================================================
    // ACTUALIZAR SEDE (ADMIN)
    // =========================================================
    public boolean actualizarSede(int idSede, String nombre, String direccion, String distrito, String telefono, 
                                  String horaApertura, String horaCierre, int capacidad, 
                                  String imagenUrl, String descripcion) {
        boolean exito = false;
        String sql = "UPDATE SEDE SET nombre=?, direccion=?, distrito=?, telefono=?, hora_apertura=?, " +
                     "hora_cierre=?, capacidad=?, imagen_url=?, descripcion=? WHERE id_sede=?";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombre);
            ps.setString(2, direccion);
            ps.setString(3, distrito);
            ps.setString(4, telefono);
            ps.setString(5, horaApertura.length() == 5 ? horaApertura + ":00" : horaApertura);
            ps.setString(6, horaCierre.length() == 5 ? horaCierre + ":00" : horaCierre);
            ps.setInt(7, capacidad);
            ps.setString(8, imagenUrl);
            ps.setString(9, descripcion);
            ps.setInt(10, idSede);

            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al actualizar sede: " + e.getMessage());
        }
        return exito;
    }

    // =========================================================
    // ELIMINAR SEDE (ADMIN)
    // =========================================================
    public boolean eliminarSede(int idSede) {
        boolean exito = false;
        String sql = "DELETE FROM SEDE WHERE id_sede = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idSede);
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            // Saltará si la sede tiene socios, clases o asistencias vinculadas (Llave foránea)
            System.out.println("Error al eliminar sede (Posible FK): " + e.getMessage());
        }
        return exito;
    }

    // =========================================================
    // HELPER PARA MAPEAR (INTERNO)
    // =========================================================
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