package com.gymmax.controller;

import com.gymmax.dao.PagoDAO;
import com.gymmax.model.PagoDTO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "MisPagosServlet", urlPatterns = {"/MisPagos"})
public class MisPagosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        
        // Si no hay sesión, al login
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        PagoDAO dao = new PagoDAO();
        List<PagoDTO> misPagos = dao.listarPagosPorUsuario(usuario.getIdUsuario());
        
        request.setAttribute("misPagos", misPagos);
        request.getRequestDispatcher("misPagos.jsp").forward(request, response);
    }
}