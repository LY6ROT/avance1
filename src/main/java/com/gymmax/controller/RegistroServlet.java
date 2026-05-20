package com.gymmax.controller;

import com.gymmax.dao.UsuarioDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "RegistroServlet", urlPatterns = {"/RegistroServlet"})
public class RegistroServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recibir los datos tipeados por el usuario en registro.jsp
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String password = request.getParameter("password");
        
        // 2. Encapsulamos la información en nuestro Objeto Modelo
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombres(nombres);
        nuevoUsuario.setApellidos(apellidos);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setPassword(password);
        
        // 3. Enviamos el modelo y los datos extra al DAO
        UsuarioDAO dao = new UsuarioDAO();
        boolean fueRegistrado = dao.registrarSocio(nuevoUsuario, dni, telefono);
        
        // 4. Verificamos y redireccionamos
        if (fueRegistrado) {
            // Redirige al login para que inicie sesión con su nueva cuenta
            response.sendRedirect("Login.jsp");
        } else {
            // Si el correo o el DNI ya existen en BD, o hay otro error
            response.sendRedirect("registro.jsp?error=1");
        }
    }
}