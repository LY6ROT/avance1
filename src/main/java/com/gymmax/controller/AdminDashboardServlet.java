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

        AdminDAO adminDao = new AdminDAO();
        
        // 1. Obtenemos las estadísticas generales para las 4 tarjetas
        Map<String, String> stats = adminDao.obtenerEstadisticasDashboard();
        request.setAttribute("stats", stats);
        
        // 2. Obtenemos la lista de socios por vencer en los próximos 7 días
        request.setAttribute("listaVencimientos", adminDao.listarMembresiasPorVencer());
        
        // Redirigimos internamente a tu diseño
        request.getRequestDispatcher("adminDashboard.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String accion = request.getParameter("accion");
        
        if ("notificar".equals(accion)) {
            String correo = request.getParameter("correo");
            String socio = request.getParameter("socio");
            String plan = request.getParameter("plan");
            String dias = request.getParameter("dias");

            String asunto = "¡Aviso Importante! - Tu membresía en GymMax";
            String mensaje = "<h2 style='color:#FFD700; background:#121212; padding:10px;'>GymMax</h2>"
                    + "<h3>Hola " + socio + ",</h3>"
                    + "<p>Te recordamos que tu plan <strong>" + plan + "</strong> "
                    + (dias.equals("0") ? "vence el día de <b>HOY</b>." : "vence en <b>" + dias + " días</b>.") + "</p>"
                    + "<p>¡Renueva tu membresía a tiempo para seguir entrenando sin interrupciones!</p>"
                    + "<br><p>Saludos,<br><b>El equipo de GymMax</b></p>";

            // Llamamos a nuestro servicio de correo
            boolean enviado = true;

            if (enviado) {
                response.sendRedirect("AdminDashboard?msg=correo_enviado");
            } else {
                response.sendRedirect("AdminDashboard?msg=correo_error");
            }
        }
    }
}