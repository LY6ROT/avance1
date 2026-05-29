package com.gymmax.controller;

import com.gymmax.dao.PagoDAO;
import com.gymmax.model.ItemCarrito;
import com.gymmax.model.Usuario;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "PagoServlet", urlPatterns = {"/ProcesarPago"})
public class PagoServlet extends HttpServlet {

    @Override
    @SuppressWarnings("unchecked")
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        Usuario usuario = (Usuario) session.getAttribute("usuarioSession");
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        
        if (usuario != null && carrito != null && !carrito.isEmpty()) {
            
            // Capturamos el método de pago elegido (TARJETA, YAPE, PLIN)
            String metodoElegido = request.getParameter("metodoPago"); 
            if (metodoElegido == null) metodoElegido = "WEB"; // Fallback por seguridad
            
            PagoDAO pagoDAO = new PagoDAO();
            boolean exitoGlobal = true;

            for (ItemCarrito item : carrito) {
                // NOTA: Asegúrate de que el procesarCompra de tu DAO reciba 5 parámetros. 
                // Si recibe 4, quita el 'metodoElegido' de aquí.
                boolean exitoItem = pagoDAO.procesarCompra(
                        usuario.getIdUsuario(), 
                        item.getPlan().getIdPlan(), 
                        item.getSubtotal(), 
                        item.getPlan().getDuracionDias(),
                        metodoElegido // <-- Se envía el método a la BD
                );
                if (!exitoItem) {
                    exitoGlobal = false;
                }
            }

            if (exitoGlobal) {
                session.removeAttribute("carrito");
                response.sendRedirect("DashboardSocio?pago=exito");
            } else {
                response.sendRedirect("pago.jsp?error=1");
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
}