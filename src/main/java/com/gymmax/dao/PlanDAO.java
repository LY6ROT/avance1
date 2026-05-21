package com.gymmax.dao;

import com.gymmax.config.ConexionDB;
import com.gymmax.model.Plan;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PlanDAO {
    
    public List<Plan> listarPlanes() {
        List<Plan> lista = new ArrayList<>();
        String sql = "SELECT id_plan, nombre, tipo, precio, duracion_dias FROM PLAN WHERE activo = 1";
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
                lista.add(p);
            }
        } catch (Exception e) {
            System.out.println("Error listarPlanes: " + e.getMessage());
        }
        return lista;
    }

    public Plan obtenerPlanPorId(int id) {
        Plan p = null;
        String sql = "SELECT id_plan, nombre, tipo, precio, duracion_dias FROM PLAN WHERE id_plan = ?";
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    p = new Plan();
                    p.setIdPlan(rs.getInt("id_plan"));
                    p.setNombre(rs.getString("nombre"));
                    p.setTipo(rs.getString("tipo"));
                    p.setPrecio(rs.getDouble("precio"));
                    p.setDuracionDias(rs.getInt("duracion_dias"));
                }
            }
        } catch (Exception e) {
            System.out.println("Error obtenerPlanPorId: " + e.getMessage());
        }
        return p;
    }
}