<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page import="com.gymmax.model.ItemCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioSession");
    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
    
    // Si no está logueado o el carrito está vacío, no debería estar aquí
    if(user == null || carrito == null || carrito.isEmpty()) {
        response.sendRedirect("Gimnasios");
        return;
    }

    double totalPagar = 0.0;
    for(ItemCarrito item : carrito) { totalPagar += item.getSubtotal(); }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>GymMax | Pago Seguro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <style>
        body { font-family: 'Poppins', sans-serif; background-color: #121212; color: white; }
        .pago-card { background-color: #1a1a1a; border-radius: 15px; border: 1px solid #333; }
        .form-control-dark { background-color: #222; border: 1px solid #444; color: white; }
        .form-control-dark:focus { background-color: #333; border-color: #FFD700; box-shadow: none; color: white; }
    </style>
</head>
<body>
    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-5">
        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="text-center mb-4">
                    <h2 style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">FINALIZAR <span class="text-warning">COMPRA</span></h2>
                    <p class="text-secondary">Estás a un paso de completar tu membresía.</p>
                </div>

                <div class="row g-4">
                    <div class="col-md-5 order-md-2">
                        <div class="pago-card p-4 shadow-lg">
                            <h5 class="fw-bold text-warning mb-4"><i class="fa-solid fa-receipt me-2"></i> Resumen de Compra</h5>
                            <ul class="list-group list-group-flush bg-transparent mb-3">
                                <% for(ItemCarrito item : carrito) { %>
                                    <li class="list-group-item bg-transparent text-white px-0 d-flex justify-content-between lh-sm border-secondary">
                                        <div>
                                            <h6 class="my-0"><%= item.getPlan().getNombre() %></h6>
                                            <small class="text-secondary">Cant: <%= item.getCantidad() %></small>
                                        </div>
                                        <span class="text-light">S/ <%= String.format("%.2f", item.getSubtotal()) %></span>
                                    </li>
                                <% } %>
                                <li class="list-group-item bg-transparent text-white px-0 d-flex justify-content-between border-secondary pt-3">
                                    <span class="fs-5 fw-bold">Total (PEN)</span>
                                    <strong class="text-warning fs-5">S/ <%= String.format("%.2f", totalPagar) %></strong>
                                </li>
                            </ul>
                        </div>
                    </div>

                    <div class="col-md-7 order-md-1">
                        <div class="pago-card p-4 shadow-lg">
                            <h5 class="fw-bold mb-4"><i class="fa-regular fa-credit-card text-warning me-2"></i> Información de Pago</h5>
                            <form action="${pageContext.request.contextPath}/ProcesarPago" method="POST" class="needs-validation">
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Nombre en la tarjeta</label>
                                    <input type="text" class="form-control form-control-dark" placeholder="EJ: JUAN PEREZ" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small text-secondary">Número de Tarjeta</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control form-control-dark border-end-0" placeholder="0000 0000 0000 0000" required>
                                        <span class="input-group-text bg-dark border-start-0 border-secondary text-white"><i class="fa-brands fa-cc-visa"></i></span>
                                    </div>
                                </div>
                                <div class="row g-3 mb-4">
                                    <div class="col-6">
                                        <label class="form-label small text-secondary">Vencimiento</label>
                                        <input type="text" class="form-control form-control-dark" placeholder="MM/AA" required>
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label small text-secondary">CVV</label>
                                        <input type="password" class="form-control form-control-dark" placeholder="123" required>
                                    </div>
                                </div>
                                <button class="btn btn-warning w-100 py-3 fw-bold text-dark fs-5" style="border-radius: 8px;" type="submit">
                                    <i class="fa-solid fa-lock me-2"></i> PAGAR S/ <%= String.format("%.2f", totalPagar) %>
                                </button>
                                <p class="text-center text-secondary small mt-3 mb-0"><i class="fa-solid fa-shield-halved text-success me-1"></i> Transacción 100% segura y encriptada.</p>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>