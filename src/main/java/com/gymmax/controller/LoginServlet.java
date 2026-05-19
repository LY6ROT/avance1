package com.gymmax.controller;

import com.gymmax.model.Usuario;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet(name = "LoginServlet", urlPatterns = {"/LoginController"})
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Recoger datos enviados desde el formulario (atributo 'name')
        String correo = request.getParameter("email");
        String pass = request.getParameter("password");

        // 2. Validación (Simulada para el proyecto)
        // En un caso real, aquí consultarías a la base de datos
        if ("oliver@utp.edu.pe".equals(correo) && "123456".equals(pass)) {
            
            // 3. Si es correcto, creamos el objeto Usuario (MODELO)
            Usuario user = new Usuario();
            user.setNombre("Oliver Torre Escobar");
            user.setEmail(correo);

            // 4. Creamos la SESIÓN (Persistencia en el servidor)
            HttpSession session = request.getSession();
            session.setAttribute("usuarioSession", user);

            // 5. Redirigimos al Inicio
            response.sendRedirect("index.jsp");
            
        } else {
            // 6. Si falla, mandamos un mensaje de error de vuelta al Login.jsp
            request.setAttribute("error", "Credenciales incorrectas. Intenta de nuevo.");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}