package com.gymmax.controller;

import com.gymmax.dao.UsuarioDAO;
import com.gymmax.model.SocioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminSociosServlet", urlPatterns = {"/AdminSocios"})
public class AdminSociosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Obtener la lista desde la Base de Datos mediante el DAO
        UsuarioDAO dao = new UsuarioDAO();
        List<SocioDTO> lista = dao.listarSocios();
        
        // 2. Almacenar la lista en el request para que la vista pueda leerla
        request.setAttribute("listaSocios", lista);
        
        // 3. Redireccionar internamente al archivo JSP
        request.getRequestDispatcher("gestionSocios.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}