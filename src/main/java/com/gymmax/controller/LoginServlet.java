package com.gymmax.controller;

import com.gymmax.dao.UsuarioDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Recibir parámetros del formulario
        String correo = request.getParameter("correo");
        String pass = request.getParameter("password");

        // 2. Comunicarse con el DAO
        UsuarioDAO dao = new UsuarioDAO();
        Usuario usuario = dao.validarLogin(correo, pass);

        // 3. Evaluar respuesta e iniciar sesión
        if (usuario != null) {
            HttpSession session = request.getSession();
            // Cambia "usuarioLogueado" por "usuarioSession" si es necesario
            session.setAttribute("usuarioSession", usuario);

            // Redirección por Rol
            if ("ADMIN".equals(usuario.getRol())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                response.sendRedirect("dashboardSocio.jsp");
            }
        } else {
            // Credenciales incorrectas
            response.sendRedirect("Login.jsp?error=1");
        }
    }
}
