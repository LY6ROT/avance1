package com.gymmax.controller;

import com.gymmax.dao.AdminDAO;
import com.gymmax.model.SocioDTO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminSociosServlet", urlPatterns = {"/GestionSocios"})
public class AdminSociosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioSession");
        
        // Validación de seguridad: Solo el ADMIN puede entrar aquí
        if (user == null || !"ADMIN".equals(user.getRol())) {
            response.sendRedirect("Login.jsp");
            return;
        }

        AdminDAO dao = new AdminDAO();
        List<SocioDTO> listaSocios = dao.listarTodosLosSocios();
        
        request.setAttribute("listaSocios", listaSocios);
        request.getRequestDispatcher("/gestionSocios.jsp").forward(request, response);
    }
}