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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accion = request.getParameter("accion");
        HttpSession session = request.getSession();
        
        List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
        if (carrito == null) {
            carrito = new ArrayList<>();
        }

        if ("agregar".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("idPlan"));
            Plan plan = new PlanDAO().obtenerPlanPorId(idPlan);
            
            // Verificar si ya está en el carrito para no duplicar
            boolean existe = false;
            for (ItemCarrito item : carrito) {
                if (item.getPlan().getIdPlan() == idPlan) {
                    item.setCantidad(item.getCantidad() + 1);
                    item.setSubtotal(item.getCantidad() * item.getPlan().getPrecio());
                    existe = true;
                    break;
                }
            }
            if (!existe && plan != null) {
                carrito.add(new ItemCarrito(plan, 1));
            }
            session.setAttribute("carrito", carrito);
            
            // Regresar a la página de donde vino
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "Gimnasios");
            
        } else if ("eliminar".equals(accion)) {
            int idPlan = Integer.parseInt(request.getParameter("idPlan"));
            carrito.removeIf(item -> item.getPlan().getIdPlan() == idPlan);
            session.setAttribute("carrito", carrito);
            
            String referer = request.getHeader("Referer");
            response.sendRedirect(referer != null ? referer : "Gimnasios");
        }
    }
}