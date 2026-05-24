package com.gymmax.controller;

import com.gymmax.config.ConexionDB;
import com.gymmax.dao.UsuarioDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "DashboardSocioServlet", urlPatterns = {"/DashboardSocio"})
public class DashboardSocioServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }
        
        String pagoStatus = request.getParameter("pago");
        if (pagoStatus != null) request.setAttribute("pago", pagoStatus);
        
        UsuarioDAO dao = new UsuarioDAO();
        Map<String, String> infoMembresia = dao.obtenerMembresiaActiva(usuario.getIdUsuario());
        request.setAttribute("infoMembresia", infoMembresia);
        
        // Cargamos la lista completa de sedes para el modal de cambio voluntario
        List<Map<String, String>> todasSedes = new ArrayList<>();
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement("SELECT id_sede, nombre FROM SEDE");
             ResultSet rs = ps.executeQuery()) {
            while(rs.next()){
                Map<String, String> s = new HashMap<>();
                s.put("id", String.valueOf(rs.getInt("id_sede")));
                s.put("nombre", rs.getString("nombre"));
                todasSedes.add(s);
            }
        } catch (Exception e) {
            System.out.println("Error al listar sedes: " + e.getMessage());
        }
        request.setAttribute("listaTodasSedes", todasSedes);
        
        // Validación del flujo forzoso (primera compra)
        if (infoMembresia != null && "Ninguna seleccionada".equals(infoMembresia.get("sede"))) {
            request.setAttribute("listaSedesForzosa", todasSedes);
        }
        
        request.getRequestDispatcher("dashboardSocio.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        if (usuario == null) return;

        int idSedeElegida = Integer.parseInt(request.getParameter("idSede"));
        
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement("UPDATE SOCIO SET id_sede_principal = ? WHERE id_usuario = ?")) {
            ps.setInt(1, idSedeElegida);
            ps.setInt(2, usuario.getIdUsuario());
            ps.executeUpdate();
            
            session.setAttribute("alertaSedeActualizada", "¡Tu Sede Principal ha sido cambiada exitosamente!");
        } catch (Exception e) {
            System.out.println("Error al actualizar sede: " + e.getMessage());
        }

        response.sendRedirect("DashboardSocio");
    }
}