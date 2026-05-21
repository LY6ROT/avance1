package com.gymmax.controller;

import com.gymmax.dao.ClaseDAO;
import com.gymmax.dao.ReservaDAO;
import com.gymmax.dao.SedeDAO;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "ReservaServlet", urlPatterns = {"/ReservarClase"})
public class ReservaServlet extends HttpServlet {

    // 1. CARGA LA PANTALLA DE RESERVAS CON DATOS DINÁMICOS
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioSession");
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        SedeDAO sedeDao = new SedeDAO();
        ClaseDAO claseDao = new ClaseDAO();
        ReservaDAO reservaDao = new ReservaDAO();

        request.setAttribute("sedes", sedeDao.listarSedes());
        request.setAttribute("clases", claseDao.listarClases());
        request.setAttribute("cambiosUsados", reservaDao.contarCambiosSede(user.getIdUsuario()));

        request.getRequestDispatcher("/reservarClase.jsp").forward(request, response);
    }

    // 2. PROCESA EL BOTÓN DE "RESERVAR"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario user = (Usuario) session.getAttribute("usuarioSession");
        
        if (user == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        int idClase = Integer.parseInt(request.getParameter("idClase"));
        int idSedeClase = Integer.parseInt(request.getParameter("idSedeClase"));
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");
        
        ReservaDAO reservaDao = new ReservaDAO();
        
        if (idSedeClase != 1) { // Sede 1 es la principal
            if (!reservaDao.puedeReservarEnOtraSede(user.getIdUsuario())) {
                response.sendRedirect("ReservarClase?error=limite_sedes");
                return;
            }
        }
        
        boolean exito = reservaDao.registrarReserva(user.getIdUsuario(), idClase, fecha, hora);
        
        if (exito) {
            response.sendRedirect("misReservas.jsp?reserva=exito");
        } else {
            response.sendRedirect("ReservarClase?error=bd");
        }
    }
}