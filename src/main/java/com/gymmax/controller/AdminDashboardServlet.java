package com.gymmax.controller;

import com.gymmax.dao.AdminDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Map;

@WebServlet(name = "AdminDashboardServlet", urlPatterns = {"/AdminDashboard", "/adminDashboard"})
public class AdminDashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        
        // Seguridad: Si no hay sesión, al login
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Llamamos al método que acabamos de crear
        AdminDAO adminDao = new AdminDAO();
        Map<String, String> stats = adminDao.obtenerEstadisticasDashboard();
        
        // Mandamos el mapa "stats" a la vista
        request.setAttribute("stats", stats);
        
        // Redirigimos internamente a tu diseño original
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
}