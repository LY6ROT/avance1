package com.gymmax.controller;

import com.gymmax.dao.PagoDAO;
import com.gymmax.model.PagoDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminPagosServlet", urlPatterns = {"/AdminPagos"})
public class AdminPagosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PagoDAO dao = new PagoDAO();
        String busqueda = request.getParameter("busqueda");
        List<PagoDTO> lista;
        
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            lista = dao.buscarPagos(busqueda);
        } else {
            lista = dao.listarPagos();
        }
        
        request.setAttribute("listaPagos", lista);
        request.getRequestDispatcher("gestionPagos.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        PagoDAO dao = new PagoDAO();
        
        if ("anular".equals(accion)) {
            int idPago = Integer.parseInt(request.getParameter("idPago"));
            if (dao.anularPago(idPago)) {
                response.sendRedirect("AdminPagos?msg=anulado");
            } else {
                response.sendRedirect("AdminPagos?msg=error");
            }
        } else {
            doGet(request, response);
        }
    }
}