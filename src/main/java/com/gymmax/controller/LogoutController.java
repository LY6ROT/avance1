package com.gymmax.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LogoutController", urlPatterns = {"/LogoutController"})
public class LogoutController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Obtenemos la sesión actual sin crear una nueva
        HttpSession session = request.getSession(false);
        
        // Si la sesión existe, la invalidamos (destruimos)
        if (session != null) {
            session.invalidate();
        }
        
        // Redirigimos al usuario a la página principal
        response.sendRedirect("index.jsp");
    }
}