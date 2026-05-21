<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // 1. Validamos que el usuario realmente haya iniciado sesión
    Usuario user = (Usuario) session.getAttribute("usuarioSession");
    if (user == null) {
        // Si no hay sesión activa, lo regresamos al login por seguridad
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | Mi Panel</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    </head>
    <body class="bg-dark text-white">

        <%@include file="/WEB-INF/fragments/header.jsp" %>

        <main class="container py-5 mt-4" style="max-width: 500px;">
            <% if ("exito".equals(request.getParameter("pago"))) { %>
            <div class="alert alert-success bg-dark border-success text-success alert-dismissible fade show shadow" role="alert">
                <i class="fa-solid fa-circle-check me-2"></i> ¡Pago procesado correctamente! Tu membresía ya está activa.
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
            <% }%>   
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">
                    Hola, <span class="text-warning"><%= user.getNombres()%></span> <i class="fa-solid fa-hand-fist text-warning"></i>
                </h2>
                <div class="position-relative">
                    <i class="fa-solid fa-bell fs-4"></i>
                    <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                </div>
            </div>

            <div class="card bg-dark border-warning mb-4 shadow-lg tarjeta-socio">
                <div class="card-body position-relative overflow-hidden">
                    <div class="borde-izquierdo bg-warning position-absolute top-0 start-0 h-100" style="width: 6px;"></div>
                    <p class="text-secondary small mb-1 ms-2">Mi membresía</p>
                    <h4 class="fw-bold mb-1 ms-2">Plan Premium</h4>
                    <p class="text-success small mb-0 ms-2"><i class="fa-regular fa-circle-check"></i> Activa hasta 30/11/2026</p>
                    <i class="fa-solid fa-award fa-3x text-warning position-absolute top-50 end-0 translate-middle-y me-3 opacity-50"></i>
                </div>
            </div>

            <div class="row g-3 mb-4 text-center">
                <div class="col-6">
                    <div class="card bg-dark border-secondary h-100">
                        <div class="card-body">
                            <h2 class="text-warning fw-bold mb-0">18</h2>
                            <p class="text-secondary small mb-0">Asistencias</p>
                        </div>
                    </div>
                </div>
                <div class="col-6">
                    <div class="card bg-dark border-secondary h-100">
                        <div class="card-body">
                            <h2 class="text-warning fw-bold mb-0">3</h2>
                            <p class="text-secondary small mb-0">Reservas</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="card bg-dark border-secondary mb-4">
                <div class="card-body">
                    <p class="text-secondary small mb-2">Próxima clase</p>
                    <h5 class="fw-bold">CrossFit <span class="text-warning">• 18:00</span></h5>
                    <p class="text-light small mb-0"><i class="fa-solid fa-location-dot text-secondary me-2"></i> Sede Miraflores</p>
                </div>
            </div>

            <h6 class="fw-bold mb-3">Acciones rápidas</h6>
            <div class="d-flex flex-column gap-3 mb-5">
                <a href="${pageContext.request.contextPath}/Gimnasios" class="btn btn-outline-secondary text-start py-3 px-4 text-white custom-btn-action">
                    <i class="fa-solid fa-location-dot text-warning me-3"></i> Ver sedes
                </a>
                <a href="${pageContext.request.contextPath}/ReservarClase" class="btn btn-outline-secondary text-start py-3 px-4 text-white custom-btn-action">
                    <i class="fa-regular fa-calendar-plus text-warning me-3"></i> Reservar clase
                </a>
                <a href="${pageContext.request.contextPath}/misReservas.jsp" class="btn btn-outline-secondary text-start py-3 px-4 text-white custom-btn-action">
                    <i class="fa-solid fa-list-check text-warning me-3"></i> Mis reservas
                </a>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>