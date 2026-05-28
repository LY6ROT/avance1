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

// Soportamos ambas variantes de URL
@WebServlet(name = "AdminSociosServlet", urlPatterns = {"/AdminSocios", "/adminSocios"})
public class AdminSociosServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        AdminDAO dao = new AdminDAO();

        String busqueda = request.getParameter("busqueda");

        List<SocioDTO> lista;

        // Si hay texto en el buscador → filtramos
        if (busqueda != null && !busqueda.trim().isEmpty()) {

            lista = dao.buscarSocios(busqueda);

        } else {

            // Si no hay búsqueda → mostramos todos
            lista = dao.listarTodosLosSocios();
        }

        request.setAttribute("listaSocios", lista);

        request.getRequestDispatcher("gestionSocios.jsp")
                .forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String accion = request.getParameter("accion");

        AdminDAO dao = new AdminDAO();

        // =========================================
        // ELIMINAR SOCIO
        // =========================================
        if ("eliminar".equals(accion)) {

            int idSocio = Integer.parseInt(request.getParameter("idSocio"));

            if (dao.eliminarSocio(idSocio)) {

                response.sendRedirect("AdminSocios?msg=eliminado");

            } else {

                response.sendRedirect("AdminSocios?msg=error_fk");
            }

        // =========================================
        // EDITAR SOCIO
        // =========================================
        } else if ("editar".equals(accion)) {

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

        // =========================================
        // REGISTRAR NUEVO SOCIO
        // =========================================
        } else if ("nuevo".equals(accion)) {

            String nombres = request.getParameter("nombres");
            String apellidos = request.getParameter("apellidos");
            String correo = request.getParameter("correo");
            String dni = request.getParameter("dni");
            String password = request.getParameter("password");

            if (dao.registrarSocio(nombres, apellidos, correo, dni, password)) {

                response.sendRedirect("AdminSocios?msg=registrado");

            } else {

                response.sendRedirect("AdminSocios?msg=error_registro");
            }

        } else {

            doGet(request, response);
        }
    }
}