package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Plan;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PlanDAO {

    // =========================================================
    // LISTAR TODOS LOS PLANES
    // =========================================================
    public List<Plan> listarPlanes() {
        List<Plan> lista = new ArrayList<>();
        String sql = "SELECT id_plan, nombre, tipo, precio, duracion_dias, activo FROM PLAN";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Plan p = new Plan();
                p.setIdPlan(rs.getInt("id_plan"));
                p.setNombre(rs.getString("nombre"));
                p.setTipo(rs.getString("tipo"));
                p.setPrecio(rs.getDouble("precio"));
                p.setDuracionDias(rs.getInt("duracion_dias"));
                p.setActivo(rs.getBoolean("activo"));
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println("Error al listar planes: " + e.getMessage());
        }
        return lista;
    }

    // =========================================================
    // BUSCADOR DE PLANES
    // =========================================================
    public List<Plan> buscarPlanes(String texto) {
        List<Plan> lista = new ArrayList<>();
        String sql = "SELECT id_plan, nombre, tipo, precio, duracion_dias, activo FROM PLAN WHERE nombre LIKE ? OR tipo LIKE ?";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            String param = "%" + texto + "%";
            ps.setString(1, param);
            ps.setString(2, param);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Plan p = new Plan();
                    p.setIdPlan(rs.getInt("id_plan"));
                    p.setNombre(rs.getString("nombre"));
                    p.setTipo(rs.getString("tipo"));
                    p.setPrecio(rs.getDouble("precio"));
                    p.setDuracionDias(rs.getInt("duracion_dias"));
                    p.setActivo(rs.getBoolean("activo"));
                    lista.add(p);
                }
            }
        } catch (Exception e) {
            System.out.println("Error al buscar planes: " + e.getMessage());
        }
        return lista;
    }

    // =========================================================
    // REGISTRAR NUEVO PLAN
    // =========================================================
    public boolean registrarPlan(String nombre, String tipo, double precio, int duracionDias) {
        boolean exito = false;
        String sql = "INSERT INTO PLAN (nombre, tipo, precio, duracion_dias, activo) VALUES (?, ?, ?, ?, 1)";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombre);
            ps.setString(2, tipo);
            ps.setDouble(3, precio);
            ps.setInt(4, duracionDias);

            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al registrar plan: " + e.getMessage());
        }
        return exito;
    }

    // =========================================================
    // ACTUALIZAR PLAN EXISTENTE
    // =========================================================
    public boolean actualizarPlan(int idPlan, String nombre, String tipo, double precio, int duracionDias, boolean activo) {
        boolean exito = false;
        String sql = "UPDATE PLAN SET nombre=?, tipo=?, precio=?, duracion_dias=?, activo=? WHERE id_plan=?";

        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, nombre);
            ps.setString(2, tipo);
            ps.setDouble(3, precio);
            ps.setInt(4, duracionDias);
            ps.setBoolean(5, activo);
            ps.setInt(6, idPlan);

            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al actualizar plan: " + e.getMessage());
        }
        return exito;
    }

    // =========================================================
    // ELIMINAR PLAN
    // =========================================================
    public boolean eliminarPlan(int idPlan) {
        boolean exito = false;
        String sql = "DELETE FROM PLAN WHERE id_plan = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idPlan);
            if (ps.executeUpdate() > 0) {
                exito = true;
            }
        } catch (Exception e) {
            System.out.println("Error al eliminar plan (Posible FK con Membresías): " + e.getMessage());
        }
        return exito;
    }
    // =========================================================
    // OBTENER PLAN POR ID (REQUERIDO POR EL CARRITO DE COMPRAS)
    // =========================================================
    public Plan obtenerPlanPorId(int idPlan) {
        Plan p = null;
        String sql = "SELECT id_plan, nombre, tipo, precio, duracion_dias, activo FROM PLAN WHERE id_plan = ?";
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, idPlan);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Plan();
                    p.setIdPlan(rs.getInt("id_plan"));
                    p.setNombre(rs.getString("nombre"));
                    p.setTipo(rs.getString("tipo"));
                    p.setPrecio(rs.getDouble("precio"));
                    p.setDuracionDias(rs.getInt("duracion_dias"));
                    p.setActivo(rs.getBoolean("activo"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error al obtener plan por id: " + e.getMessage());
        }
        return p;
    }
}