<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page import="com.gymmax.model.ItemCarrito"%>
<%
    Usuario userNav = (Usuario) session.getAttribute("usuarioSession");
    List<ItemCarrito> carritoNav = (List<ItemCarrito>) session.getAttribute("carrito");
    int totalItemsNav = 0;
    double totalPagarNav = 0.0;
    if (carritoNav != null) {
        totalItemsNav = carritoNav.size();
        for (ItemCarrito item : carritoNav) {
            totalPagarNav += item.getSubtotal();
        }
    }
%>

<nav class="navbar navbar-expand-lg fixed-top" style="background-color: rgba(0, 0, 0, 0.95); border-bottom: 2px solid #FFD700; padding: 10px 0;">
    <div class="container">
        <a class="navbar-brand d-flex align-items-center" href="${pageContext.request.contextPath}/index.jsp">
            <h2 style="font-family: 'Anton', sans-serif; color: white; margin: 0;">Gym<span class="text-warning">Max</span></h2>
        </a>

        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#menuNavegacion" style="background-color: #FFD700;">
            <i class="fa-solid fa-bars text-dark"></i>
        </button>

        <div class="collapse navbar-collapse justify-content-end" id="menuNavegacion">
            <ul class="navbar-nav align-items-center gap-2 gap-lg-4">
                <li class="nav-item"><a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/index.jsp">Inicio</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/Gimnasios">Gimnasios</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/Nosotros.jsp">Nosotros</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold text-uppercase" href="${pageContext.request.contextPath}/Contactenos.jsp">Contáctenos</a></li>

                <li class="nav-item d-flex align-items-center gap-2">
                    <button class="btn btn-sm btn-outline-warning position-relative me-2" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasCarrito">
                        <i class="fa-solid fa-cart-shopping"></i>
                        <span class="position-absolute top-0 start-100 translate-middle badge rounded-pill bg-danger" style="font-size: 0.65rem;"><%= totalItemsNav%></span>
                    </button>

                    <% if (userNav == null) { %>
                    <a href="${pageContext.request.contextPath}/Login.jsp" class="btn fw-bold px-4 btn-sm" style="background-color: #FFD700; color: #000; border-radius: 8px;">LOGIN</a>
                    <% } else {%>
                    <span style="color: #FFD700; font-weight: bold; margin-right: 10px; font-size: 0.95rem;">
                        <i class="fa-solid fa-user me-1"></i> <%= userNav.getNombres()%>
                    </span>

                    <% if ("ADMIN".equals(userNav.getRol())) { %>
                    <a href="${pageContext.request.contextPath}/adminDashboard.jsp" class="btn btn-sm btn-outline-light fw-bold">Panel Admin</a>
                    <% } else { %>
                    <a href="${pageContext.request.contextPath}/DashboardSocio" class="btn btn-sm btn-outline-light fw-bold">Mi Dashboard</a>
                    <% } %>

                    <a href="${pageContext.request.contextPath}/LogoutController" class="btn btn-sm btn-outline-danger fw-bold rounded-pill border-2 ms-2">Salir</a>
                    <% } %>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="offcanvas offcanvas-end bg-dark text-white" tabindex="-1" id="offcanvasCarrito" style="border-left: 2px solid #FFD700;">
    <div class="offcanvas-header border-bottom border-secondary">
        <h5 class="offcanvas-title fw-bold" style="font-family: 'Anton', sans-serif;"><i class="fa-solid fa-cart-shopping text-warning me-2"></i> TU CARRITO</h5>
        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas"></button>
    </div>
    <div class="offcanvas-body d-flex flex-column">
        <% if (carritoNav == null || carritoNav.isEmpty()) { %>
        <div class="text-center mt-5">
            <i class="fa-solid fa-basket-shopping fa-3x text-secondary mb-3"></i>
            <p class="text-secondary">Tu carrito está vacío.</p>
        </div>
        <% } else { %>
        <div class="flex-grow-1 overflow-auto">
            <% for (ItemCarrito item : carritoNav) {%>
            <div class="card bg-black border-secondary mb-3">
                <div class="card-body p-3">
                    <div class="d-flex justify-content-between align-items-start">
                        <div>
                            <h6 class="fw-bold text-warning mb-1"><%= item.getPlan().getNombre()%></h6>
                            <small class="text-light">Duración: <%= item.getPlan().getDuracionDias()%> días</small>
                        </div>
                        <a href="${pageContext.request.contextPath}/Carrito?accion=eliminar&idPlan=<%= item.getPlan().getIdPlan()%>" class="text-danger"><i class="fa-solid fa-trash"></i></a>
                    </div>
                    <div class="mt-2 d-flex justify-content-between align-items-center">
                        <span class="badge bg-secondary">Cant: <%= item.getCantidad()%></span>
                        <span class="fw-bold text-white">S/ <%= String.format("%.2f", item.getSubtotal())%></span>
                    </div>
                </div>
            </div>
            <% }%>
        </div>
        <div class="border-top border-secondary pt-3 mt-3">
            <div class="d-flex justify-content-between fs-5 fw-bold mb-3">
                <span>Total a pagar:</span>
                <span class="text-warning">S/ <%= String.format("%.2f", totalPagarNav)%></span>
            </div>

            <% if (userNav != null) { %>
            <a href="${pageContext.request.contextPath}/pago.jsp" class="btn btn-warning w-100 fw-bold text-dark py-2">FINALIZAR COMPRA <i class="fa-regular fa-credit-card ms-2"></i></a>
                <% } else { %>
            <a href="${pageContext.request.contextPath}/Login.jsp" class="btn btn-outline-warning w-100 fw-bold py-2">INICIA SESIÓN PARA COMPRAR <i class="fa-solid fa-right-to-bracket ms-2"></i></a>
                <% } %>
        </div>
        <% } %>
    </div>
   <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

<%
    // Leemos las variables desde el Servlet
    String alertaCarrito = (String) session.getAttribute("alertaCarrito");
    Boolean abrirCarrito = (Boolean) session.getAttribute("abrirCarrito");
    
    // 1. Mostrar la notificación pequeña si se agregó un plan
    if (alertaCarrito != null) {
%>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        const Toast = Swal.mixin({
            toast: true,
            position: 'top-end',
            showConfirmButton: false,
            timer: 3000,
            timerProgressBar: true,
            background: '#1a1a1a', 
            color: '#FFD700',      
            iconColor: '#FFD700'
        });

        Toast.fire({
            icon: 'success',
            title: '<%= alertaCarrito %>'
        });
    });
</script>
<%
        session.removeAttribute("alertaCarrito");
    }
    
    // 2. Desplegar el Carrito (Offcanvas de Bootstrap) automáticamente
    if (abrirCarrito != null && abrirCarrito) {
%>
<script>
    document.addEventListener("DOMContentLoaded", function() {
        // Buscamos el panel del carrito por su ID
        var myOffcanvas = document.getElementById('offcanvasCarrito');
        if (myOffcanvas) {
            // Usamos la API de Bootstrap para forzar su apertura
            var bsOffcanvas = new bootstrap.Offcanvas(myOffcanvas);
            bsOffcanvas.show();
        }
    });
</script>
<%
        session.removeAttribute("abrirCarrito"); // Lo borramos para que no se abra solo al navegar
    }
%>
</div>