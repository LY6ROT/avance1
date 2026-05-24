package com.gymmax.controller;

import com.gymmax.dao.PlanDAO;
import com.gymmax.model.ItemCarrito;
import com.gymmax.model.Plan;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "CarritoServlet", urlPatterns = {"/Carrito"})
public class CarritoServlet extends HttpServlet {
    
    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        
        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        if ("agregar".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("idPlan"));
            boolean existe = false;
            
            // 1. Verificar si el plan ya está en el carrito para sumar la cantidad
            for (ItemCarrito item : carrito) {
                if (item.getPlan().getIdPlan() == idPlan) {
                    item.setCantidad(item.getCantidad() + 1);
                    // Actualizamos el subtotal para que no se quede en el precio inicial
                    item.setSubtotal(item.getPlan().getPrecio() * item.getCantidad());
                    existe = true;
                    break;
                }
            }
            
            // 2. Si no existe, lo buscamos en la base de datos y lo agregamos
            if (!existe) {
                PlanDAO pdao = new PlanDAO();
                Plan p = pdao.obtenerPlanPorId(idPlan);
                if (p != null) {
                    // Aquí usamos el constructor que creaste
                    ItemCarrito nuevoItem = new ItemCarrito(p, 1);
                    carrito.add(nuevoItem);
                }
            }
            session.setAttribute("carrito", carrito);
            
            // 3. Enviamos las variables a la sesión para las alertas y animaciones
            session.setAttribute("alertaCarrito", "¡Plan añadido al carrito!");
            session.setAttribute("abrirCarrito", true); // <--- Esto ordenará abrir el panel
            
        } else if ("eliminar".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("idPlan"));
            carrito.removeIf(item -> item.getPlan().getIdPlan() == idPlan);
            session.setAttribute("carrito", carrito);
            session.setAttribute("abrirCarrito", true); // Mantiene el carrito abierto para ver que se borró
        }

        String referer = request.getHeader("Referer");
        if (referer != null) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("gimnasios.jsp");
        }
    }
}