package com.gymmax.controller;

import com.gymmax.dao.ClaseDAO;
import com.gymmax.dao.SedeDAO;
import com.gymmax.model.Clase;
import com.gymmax.model.Sede;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

// Blindamos la URL para evitar errores 404 por mayúsculas/minúsculas
@WebServlet(name = "AdminClasesServlet", urlPatterns = {"/AdminClases", "/adminClases", "/GestionClases"})
public class AdminClasesServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // 1. Instanciamos los DAOs
        ClaseDAO claseDao = new ClaseDAO();
        SedeDAO sedeDao = new SedeDAO();
        
       // 2. Obtenemos las listas usando los métodos exactos de tus DAOs
        List<Clase> listaClases = claseDao.listarClases(); 
        List<Sede> listaSedes = sedeDao.listarSedes();
        
        // 3. Enviamos las listas a la vista respetando los nombres que pusiste en gestionClases.jsp
        request.setAttribute("listaClases", listaClases);
        request.setAttribute("listaSedes", listaSedes);
        
        // 4. Redirigimos
        request.getRequestDispatcher("gestionClases.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        ClaseDAO dao = new ClaseDAO();
        
        try {
            if ("nueva".equals(accion) || "editar".equals(accion)) {
                Clase c = new Clase();
                c.setNombre(request.getParameter("nombre"));
                c.setTipo(request.getParameter("tipo"));
                c.setInstructor(request.getParameter("instructor"));
                c.setIdSede(Integer.parseInt(request.getParameter("idSede")));
                c.setCupoMaximo(Integer.parseInt(request.getParameter("cupoMaximo")));
                
                // Convertimos el String del input "time" a java.sql.Time
                String horaStr = request.getParameter("horaInicio");
                if (horaStr.length() == 5) horaStr += ":00"; // Asegurar formato HH:mm:ss
                c.setHoraInicio(java.sql.Time.valueOf(horaStr));

                if ("nueva".equals(accion)) {
                    dao.insertarClase(c);
                    response.sendRedirect("AdminClases?msg=creada");
                } else {
                    c.setIdClase(Integer.parseInt(request.getParameter("idClase")));
                    dao.actualizarClase(c);
                    response.sendRedirect("AdminClases?msg=editada");
                }

            } else if ("eliminar".equals(accion)) {
                int id = Integer.parseInt(request.getParameter("idClase"));
                if (dao.eliminarClase(id)) {
                    response.sendRedirect("AdminClases?msg=eliminada");
                } else {
                    response.sendRedirect("AdminClases?msg=error_fk");
                }
            }
        } catch (Exception e) {
            response.sendRedirect("AdminClases?msg=error");
        }
    }
}