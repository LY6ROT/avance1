package com.gymmax.controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "PagoServlet", urlPatterns = {"/ProcesarPago"})
public class PagoServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // 1. Aquí iría la lógica DAO para guardar la Membresía y el Pago en MySQL.
        
        // 2. Vaciamos el carrito porque la compra ya se realizó
        session.removeAttribute("carrito");
        
        // 3. Redirigimos al Dashboard del socio enviando una señal de éxito en la URL
        response.sendRedirect("dashboardSocio.jsp?pago=exito");
    }
}