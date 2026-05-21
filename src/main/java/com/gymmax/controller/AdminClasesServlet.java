package com.gymmax.controller;

import com.gymmax.dao.ClaseDAO;
import com.gymmax.dao.SedeDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "AdminClasesServlet", urlPatterns = {"/GestionClases"})
public class AdminClasesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Validamos seguridad (Solo ADMIN)
        HttpSession session = request.getSession();
        Usuario userAdminCheck = (Usuario) session.getAttribute("usuarioSession");
        if (userAdminCheck == null || !"ADMIN".equals(userAdminCheck.getRol())) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // 2. Traemos las clases y las sedes (para saber el nombre de la sede y no solo su ID)
        ClaseDAO claseDao = new ClaseDAO();
        SedeDAO sedeDao = new SedeDAO();
        
        request.setAttribute("listaClases", claseDao.listarClases());
        request.setAttribute("listaSedes", sedeDao.listarSedes());
        
        // 3. Enviamos a la vista
        request.getRequestDispatcher("/gestionClases.jsp").forward(request, response);
    }
}