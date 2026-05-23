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
        
        // 1. Recibir los datos del formulario
        String nombres = request.getParameter("nombres");
        String apellidos = request.getParameter("apellidos");
        String dni = request.getParameter("dni");
        String correo = request.getParameter("correo");
        String telefono = request.getParameter("telefono");
        String password = request.getParameter("password");
        
        // Nuevos campos
        String fechaNac = request.getParameter("fecha_nac");
        String genero = request.getParameter("genero");
        String direccion = request.getParameter("direccion");
        
        // 2. Guardar en el objeto Usuario
        Usuario nuevoUsuario = new Usuario();
        nuevoUsuario.setNombres(nombres);
        nuevoUsuario.setApellidos(apellidos);
        nuevoUsuario.setCorreo(correo);
        nuevoUsuario.setPassword(password);
        
        // 3. Enviar a Base de Datos
        UsuarioDAO dao = new UsuarioDAO();
        // Actualizamos la llamada al método para incluir los nuevos campos
        boolean fueRegistrado = dao.registrarSocio(nuevoUsuario, dni, telefono, fechaNac, genero, direccion);
        
        // 4. Redireccionar según el resultado
        if (fueRegistrado) {
            response.sendRedirect("Login.jsp?registro=exito");
        } else {
            response.sendRedirect("registro.jsp?error=1");
        }
    }
}