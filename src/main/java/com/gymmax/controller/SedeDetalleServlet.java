package com.gymmax.controller;

import com.gymmax.dao.SedeDAO;
import com.gymmax.model.Sede;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "SedeDetalleServlet", urlPatterns = {"/SedeDetalle"})
public class SedeDetalleServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int idSede = Integer.parseInt(idParam);
                SedeDAO dao = new SedeDAO();
                Sede sede = dao.obtenerSedePorId(idSede);

                if (sede != null) {
                    request.setAttribute("sede", sede);
                    request.getRequestDispatcher("/detalleSede.jsp").forward(request, response);
                    return;

                }
            } catch (NumberFormatException e) {
                System.out.println("Error al parsear el ID: " + e.getMessage());
            }
            // Añadir al SedeDetalleServlet.java (dentro del if donde encuentra la sede)
            com.gymmax.dao.PlanDAO planDao = new com.gymmax.dao.PlanDAO();
            request.setAttribute("planes", planDao.listarPlanes());
        }

        // Si hay un error con el ID, volvemos a la lista general
        response.sendRedirect("Gimnasios");
    }
}
