package com.gymmax.controller;

import com.gymmax.dao.ReservaDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Map;

@WebServlet(name = "MisReservasServlet", urlPatterns = {"/MisReservas"})
public class MisReservasServlet extends HttpServlet {

   @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // NUEVO: Capturar y transferir parámetros de estado de alertas
        String reservaStatus = request.getParameter("reserva");
        if (reservaStatus != null) {
            request.setAttribute("reserva", reservaStatus);
        }
        
        String cancelStatus = request.getParameter("cancel");
        if (cancelStatus != null) {
            request.setAttribute("cancel", cancelStatus);
        }

        // Consultar el historial real en la Base de Datos
        ReservaDAO reservaDao = new ReservaDAO();
        List<Map<String, String>> misReservas = reservaDao.listarMisReservas(usuario.getIdUsuario());
        
        request.setAttribute("misReservas", misReservas);
        request.getRequestDispatcher("misReservas.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        if (usuario == null) return;

        String accion = request.getParameter("accion");
        
        if ("cancelar".equals(accion)) {
            int idReserva = Integer.parseInt(request.getParameter("idReserva"));
            ReservaDAO reservaDao = new ReservaDAO();
            
            if (reservaDao.cancelarReserva(idReserva, usuario.getIdUsuario())) {
                response.sendRedirect("MisReservas?cancel=exito");
            } else {
                response.sendRedirect("MisReservas?cancel=error");
            }
        }
    }
}