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

@WebServlet(name = "AdminSedesServlet", urlPatterns = {"/AdminSedes"})
public class AdminSedesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        SedeDAO dao = new SedeDAO();
        String busqueda = request.getParameter("busqueda");
        List<Sede> lista;
        
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            lista = dao.buscarSedes(busqueda);
        } else {
            lista = dao.listarSedes();
        }
        
        request.setAttribute("listaSedes", lista);
        request.getRequestDispatcher("gestionSedes.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        SedeDAO dao = new SedeDAO();
        
        if ("eliminar".equals(accion)) {
            int idSede = Integer.parseInt(request.getParameter("idSede"));
            if (dao.eliminarSede(idSede)) {
                response.sendRedirect("AdminSedes?msg=eliminada");
            } else {
                response.sendRedirect("AdminSedes?msg=error_fk");
            }
            
        } else if ("nueva".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String distrito = request.getParameter("distrito");
            String telefono = request.getParameter("telefono");
            String horaApertura = request.getParameter("horaApertura");
            String horaCierre = request.getParameter("horaCierre");
            int capacidad = Integer.parseInt(request.getParameter("capacidad"));
            String imagenUrl = request.getParameter("imagenUrl");
            String descripcion = request.getParameter("descripcion");
            
            // --- NUEVO: RECOGER LOS BENEFICIOS DEL FORMULARIO ---
            String[] arrBeneficios = request.getParameterValues("beneficios");
            String beneficiosUnidos = "";
            if (arrBeneficios != null) {
                beneficiosUnidos = String.join(",", arrBeneficios);
            }
            
            // Pasamos 'beneficiosUnidos' al final del método
            if (dao.registrarSede(nombre, direccion, distrito, telefono, horaApertura, horaCierre, capacidad, imagenUrl, descripcion, beneficiosUnidos)) {
                response.sendRedirect("AdminSedes?msg=creada");
            } else {
                response.sendRedirect("AdminSedes?msg=error_crear");
            }
            
        } else if ("editar".equals(accion)) {
            int idSede = Integer.parseInt(request.getParameter("idSede"));
            String nombre = request.getParameter("nombre");
            String direccion = request.getParameter("direccion");
            String distrito = request.getParameter("distrito");
            String telefono = request.getParameter("telefono");
            String horaApertura = request.getParameter("horaApertura");
            String horaCierre = request.getParameter("horaCierre");
            int capacidad = Integer.parseInt(request.getParameter("capacidad"));
            String imagenUrl = request.getParameter("imagenUrl");
            String descripcion = request.getParameter("descripcion");
            
            // --- NUEVO: RECOGER LOS BENEFICIOS DEL FORMULARIO ---
            String[] arrBeneficios = request.getParameterValues("beneficios");
            String beneficiosUnidos = "";
            if (arrBeneficios != null) {
                beneficiosUnidos = String.join(",", arrBeneficios);
            }
            
            // Pasamos 'beneficiosUnidos' al final del método
            if (dao.actualizarSede(idSede, nombre, direccion, distrito, telefono, horaApertura, horaCierre, capacidad, imagenUrl, descripcion, beneficiosUnidos)) {
                response.sendRedirect("AdminSedes?msg=editada");
            } else {
                response.sendRedirect("AdminSedes?msg=error_editar");
            }
            
        } else {
            doGet(request, response);
        }
    }
}