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

@WebServlet(name = "ReservaServlet", urlPatterns = {"/Reserva"})
public class ReservaServlet extends HttpServlet {

    // El método GET sirve para Cargar la página con los datos de las clases y los comodines usados
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        ReservaDAO reservaDao = new ReservaDAO();
        com.gymmax.dao.UsuarioDAO usuarioDao = new com.gymmax.dao.UsuarioDAO(); // NUEVO

        // NUEVO: Extraemos la fecha de inicio y fin de la membresía activa
        java.util.Map<String, String> membresia = usuarioDao.obtenerMembresiaActiva(usuario.getIdUsuario());
        if(membresia != null) {
            request.setAttribute("minFecha", membresia.get("inicio"));
            request.setAttribute("maxFecha", membresia.get("fin"));
        }

        int visitasOtraSede = reservaDao.contarVisitasOtraSede(usuario.getIdUsuario());
        request.setAttribute("visitasOtraSede", visitasOtraSede);
        
        List<Map<String, String>> listaClases = reservaDao.listarClasesDisponibles();
        request.setAttribute("listaClases", listaClases);
        
        request.getRequestDispatcher("reservarClase.jsp").forward(request, response);
    }

    // El método POST sirve para Procesar el formulario cuando el socio le da a "Reservar"
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        
        if (usuario == null) {
            response.sendRedirect("Login.jsp");
            return;
        }

        // Recibimos los datos del formulario de reserva
        int idClase = Integer.parseInt(request.getParameter("idClase"));
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora"); 

        ReservaDAO reservaDao = new ReservaDAO();
        
        // Ejecutamos la regla de negocio que creamos en el DAO
        String resultado = reservaDao.registrarReservaSegura(usuario.getIdUsuario(), idClase, fecha, hora);

        // Evaluamos la respuesta para mostrar alertas exactas
        if ("SEDE_PREDETERMINADA".equals(resultado)) {
            response.sendRedirect("Reserva?error=sedepredeterminada");
        } else if ("LIMITE_EXCEDIDO".equals(resultado)) {
            response.sendRedirect("Reserva?error=limite");
        } else if ("EXITO_FORANEA".equals(resultado)) {
            // CORRECCIÓN: Apuntamos al Servlet Controlador, no al archivo físico .jsp
            response.sendRedirect("MisReservas?reserva=exito_foranea");
        } else {
            response.sendRedirect("Reserva?error=db");
        }
    }
}