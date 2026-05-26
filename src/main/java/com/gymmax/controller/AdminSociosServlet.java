package com.gymmax.controller;

import com.gymmax.dao.AdminDAO;
import com.gymmax.model.SocioDTO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Soportamos ambas variantes de URL para evitar errores de mayúsculas/minúsculas
@WebServlet(name = "AdminSociosServlet", urlPatterns = {"/AdminSocios", "/adminSocios"})
public class AdminSociosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Conectamos con el DAO del Administrador que tiene el método de cruce de tablas
        AdminDAO dao = new AdminDAO();
        List<SocioDTO> lista = dao.listarTodosLosSocios();
        
        // Enviamos la lista a la vista con el nombre exacto que usa tu JSTL c:forEach
        request.setAttribute("listaSocios", lista);
        
        // Despachamos el control hacia tu diseño original
        request.getRequestDispatcher("gestionSocios.jsp").forward(request, response);
    }

  @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        AdminDAO dao = new AdminDAO();
        
        if ("eliminar".equals(accion)) {
            int idSocio = Integer.parseInt(request.getParameter("idSocio"));
            if (dao.eliminarSocio(idSocio)) {
                response.sendRedirect("AdminSocios?msg=eliminado");
            } else {
                response.sendRedirect("AdminSocios?msg=error_fk");
            }
            
        } else if ("editar".equals(accion)) {
            // Capturamos los campos enviados desde el formulario del modal
            int idUsuario = Integer.parseInt(request.getParameter("idUsuario"));
            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String dni = request.getParameter("dni");
            String correo = request.getParameter("correo");
            
            if (dao.actualizarSocio(idUsuario, nombres, apellidos, dni, correo)) {
                response.sendRedirect("AdminSocios?msg=editado");
            } else {
                response.sendRedirect("AdminSocios?msg=error_edit");
            }
            
        } else {
            doGet(request, response);
        }
    }
}