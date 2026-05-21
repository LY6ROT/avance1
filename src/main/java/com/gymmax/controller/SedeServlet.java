package com.gymmax.controller;

import com.gymmax.dao.SedeDAO;
import com.gymmax.model.Sede;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "SedeServlet", urlPatterns = {"/Gimnasios"})
public class SedeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        SedeDAO dao = new SedeDAO();
        List<Sede> listaSedes;
        
        // Capturar lo que el usuario escribe en el cuadro de búsqueda
        String txtBuscar = request.getParameter("txtBuscar");
        
        if (txtBuscar != null && !txtBuscar.trim().isEmpty()) {
            // Si el buscador tiene texto, filtramos los datos de la BD
            listaSedes = dao.buscarSedes(txtBuscar.trim());
            request.setAttribute("busqueda", txtBuscar); // Devolvemos el texto para mostrarlo en la vista
        } else {
            // Si está vacío, listamos todos los gimnasios normalmente
            listaSedes = dao.listarSedes();
        }
        
        request.setAttribute("sedes", listaSedes);
        request.getRequestDispatcher("/gimnasios.jsp").forward(request, response);
    }
}