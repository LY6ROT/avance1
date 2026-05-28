package com.gymmax.controller;

import com.gymmax.dao.PlanDAO;
import com.gymmax.model.Plan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminMembresiasServlet", urlPatterns = {"/AdminMembresias"})
public class AdminMembresiasServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        PlanDAO dao = new PlanDAO();
        String busqueda = request.getParameter("busqueda");
        List<Plan> lista;
        
        if (busqueda != null && !busqueda.trim().isEmpty()) {
            lista = dao.buscarPlanes(busqueda);
        } else {
            lista = dao.listarPlanes();
        }
        
        request.setAttribute("listaPlanes", lista);
        request.getRequestDispatcher("gestionMembresias.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        PlanDAO dao = new PlanDAO();
        
        if ("eliminar".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("idPlan"));
            if (dao.eliminarPlan(idPlan)) {
                response.sendRedirect("AdminMembresias?msg=eliminado");
            } else {
                response.sendRedirect("AdminMembresias?msg=error_fk");
            }
            
        } else if ("nuevo".equals(accion)) {
            String nombre = request.getParameter("nombre");
            String tipo = request.getParameter("tipo");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int duracion = Integer.parseInt(request.getParameter("duracion"));
            
            if (dao.registrarPlan(nombre, tipo, precio, duracion)) {
                response.sendRedirect("AdminMembresias?msg=creado");
            } else {
                response.sendRedirect("AdminMembresias?msg=error_crear");
            }
            
        } else if ("editar".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("idPlan"));
            String nombre = request.getParameter("nombre");
            String tipo = request.getParameter("tipo");
            double precio = Double.parseDouble(request.getParameter("precio"));
            int duracion = Integer.parseInt(request.getParameter("duracion"));
            // Recibimos el estado del checkbox (si no viene, es false)
            boolean activo = request.getParameter("activo") != null;
            
            if (dao.actualizarPlan(idPlan, nombre, tipo, precio, duracion, activo)) {
                response.sendRedirect("AdminMembresias?msg=editado");
            } else {
                response.sendRedirect("AdminMembresias?msg=error_editar");
            }
            
        } else {
            doGet(request, response);
        }
    }
}