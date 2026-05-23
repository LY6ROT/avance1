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
        
        // Verificamos que el usuario esté logueado y tenga items en el carrito
        if (usuario != null && carrito != null && !carrito.isEmpty()) {
            PagoDAO pagoDAO = new PagoDAO();
            boolean exitoGlobal = true;

            // Procesar la compra de cada plan agregado al carrito
            for (ItemCarrito item : carrito) {
                boolean exitoItem = pagoDAO.procesarCompra(
                        usuario.getIdUsuario(), 
                        item.getPlan().getIdPlan(), 
                        item.getSubtotal(), 
                        item.getPlan().getDuracionDias()
                );
                if (!exitoItem) {
                    exitoGlobal = false;
                }
            }

            if (exitoGlobal) {
                // Si todo salió bien, vaciamos el carrito y mandamos al dashboard
                session.removeAttribute("carrito");
                response.sendRedirect("dashboardSocio.jsp?pago=exito");
            } else {
                response.sendRedirect("pago.jsp?error=1");
            }
        } else {
            response.sendRedirect("Login.jsp");
        }
    }
}