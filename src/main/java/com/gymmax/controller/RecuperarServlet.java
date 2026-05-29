package com.gymmax.controller;

import com.gymmax.dao.UsuarioDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "RecuperarServlet", urlPatterns = {"/Recuperar"})
public class RecuperarServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String correo = request.getParameter("correo");
        UsuarioDAO dao = new UsuarioDAO();
        
        if (dao.existeCorreo(correo)) {
            // Generamos una contraseña aleatoria de 8 caracteres
            String nuevaPassword = UUID.randomUUID().toString().substring(0, 8);
            
            if (dao.actualizarPasswordPorCorreo(correo, nuevaPassword)) {
                
                // SIMULACIÓN DE ENVÍO DE CORREO (SE IMPRIME EN NETBEANS)
                System.out.println("==================================================");
                System.out.println("✉️ SIMULADOR DE CORREO - RECUPERACIÓN DE CLAVE");
                System.out.println("Para: " + correo);
                System.out.println("Tu nueva contraseña temporal es: " + nuevaPassword);
                System.out.println("==================================================");
                
                // Redirigimos al login con mensaje de éxito
                response.sendRedirect("Login.jsp?msg=recuperado");
            } else {
                response.sendRedirect("recuperar.jsp?msg=error_bd");
            }
        } else {
            // El correo no existe en el sistema
            response.sendRedirect("recuperar.jsp?msg=no_existe");
        }
    }
}