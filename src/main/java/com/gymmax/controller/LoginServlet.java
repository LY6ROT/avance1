package com.gymmax.controller;

import com.gymmax.dao.UsuarioDAO;
import com.gymmax.model.Usuario;
import com.gymmax.model.ItemCarrito; // <-- IMPORTACIÓN AGREGADA
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List; // <-- IMPORTACIÓN AGREGADA

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginServlet"})
public class LoginServlet extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked") // Agregado para que no salga el warning amarillo
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
            session.setAttribute("usuarioSession", usuario);

            // Redirección por Rol
            if ("ADMIN".equals(usuario.getRol())) {
                response.sendRedirect("adminDashboard.jsp");
            } else {
                // Validación inteligente de carrito activo
                List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
                if (carrito != null && !carrito.isEmpty()) {
                    response.sendRedirect("pago.jsp"); // Redirige a pagar de inmediato si ya tiene productos
                } else {
                    response.sendRedirect("DashboardSocio");
                }
            }
        } else {
            // Credenciales incorrectas
            response.sendRedirect("Login.jsp?error=1");
        }
    }
}