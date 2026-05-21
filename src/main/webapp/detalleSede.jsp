<%@page import="com.gymmax.model.Plan"%>
<%@page import="com.gymmax.model.Plan"%>
<%@page import="com.gymmax.model.Sede"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Sede s = (Sede) request.getAttribute("sede");
    if (s == null) {
        response.sendRedirect("Gimnasios");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | <%= s.getNombre()%></title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    </head>
    <body class="bg-dark text-white">

        <%@include file="/WEB-INF/fragments/header.jsp" %>

        <main class="container py-5 mt-5">
            <div class="mb-4">
                <a href="${pageContext.request.contextPath}/Gimnasios" class="text-warning text-decoration-none fw-bold">
                    <i class="fa-solid fa-arrow-left me-2"></i> Volver a sedes
                </a>
            </div>

            <div class="row g-5">
                <div class="col-md-6">
                    <div class="rounded-4 overflow-hidden border border-secondary shadow-lg" style="max-height: 400px; height: 100%;">
                        <img src="<%= s.getImagenUrl()%>" alt="<%= s.getNombre()%>" style="width: 100%; height: 100%; object-fit: cover;">
                    </div>
                </div>
            </div>

            <hr class="border-secondary my-5">
            <div class="text-center mb-5">
                <h2 style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">ELIGE TU <span class="text-warning">MEMBRESÍA</span></h2>
                <p class="text-secondary">Planes disponibles para empezar a entrenar hoy mismo.</p>
            </div>

            <div class="row g-4 justify-content-center">
                <%
                    List<Plan> planes = (List<Plan>) request.getAttribute("planes");
                    if (planes != null) {
                        for (Plan p : planes) {
                %>
                <div class="col-md-4">
                    <div class="card bg-black border-warning text-center h-100 shadow-lg" style="border-radius: 15px; transition: transform 0.3s;">
                        <div class="card-body p-5 d-flex flex-column">
                            <h4 class="fw-bold text-white mb-3 text-uppercase"><%= p.getNombre()%></h4>
                            <h2 class="text-warning fw-bold mb-4" style="font-family: 'Anton', sans-serif;">S/ <%= String.format("%.2f", p.getPrecio())%></h2>

                            <ul class="list-unstyled text-secondary small mb-4 flex-grow-1 text-start">
                                <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Acceso a sede seleccionada</li>
                                <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Vigencia de <%= p.getDuracionDias()%> días</li>
                                <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Uso de máquinas y pesas</li>
                                    <% if (p.getTipo().equals("PREM") || p.getTipo().equals("ANUAL")) { %>
                                <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Acceso a todas las sedes</li>
                                <li class="mb-2"><i class="fa-solid fa-check text-success me-2"></i> Clases grupales incluidas</li>
                                    <% } %>
                            </ul>

                            <% if (session.getAttribute("usuarioSession") != null) {%>
                            <a href="${pageContext.request.contextPath}/Carrito?accion=agregar&idPlan=<%= p.getIdPlan()%>" class="btn btn-outline-warning fw-bold w-100 py-2" style="border-radius: 8px;">
                                Añadir al Carrito <i class="fa-solid fa-cart-plus ms-2"></i>
                            </a>
                            <% } else { %>
                            <a href="${pageContext.request.contextPath}/Login.jsp" class="btn btn-secondary fw-bold w-100 py-2" style="border-radius: 8px;">
                                Inicia sesión para comprar
                            </a>
                            <% } %>
                        </div>
                    </div>
                </div>
                <%
                        }
                    }
                %>
            </div>



            <div class="col-md-6 d-flex flex-column justify-content-center">
                <div class="d-flex align-items-center gap-3 mb-3">
                    <h1 class="text-warning mb-0" style="font-family: 'Anton', sans-serif; font-size: 3rem; letter-spacing: 1px;"><%= s.getNombre()%></h1>
                    <span class="badge bg-warning text-dark px-3 py-2 fw-bold rounded-pill"><%= s.getDistrito()%></span>
                </div>

                <h5 class="text-secondary fw-bold mb-4">Ubicación y Detalles del Centro</h5>
                <p class="text-light mb-4" style="line-height: 1.8; font-size: 1.05rem;"><%= s.getDescripcion()%></p>

                <div class="bg-black p-4 rounded-3 border border-secondary mb-4">
                    <div class="mb-3"><i class="fa-solid fa-map-pin text-warning me-3 fs-5"></i> <strong>Dirección:</strong> <%= s.getDireccion()%></div>
                    <div class="mb-3"><i class="fa-solid fa-clock text-warning me-3 fs-5"></i> <strong>Horario de Atención:</strong> <%= s.getHoraApertura().toString().substring(0, 5)%> AM a <%= s.getHoraCierre().toString().substring(0, 5)%> PM</div>
                    <div class="mb-3"><i class="fa-solid fa-users text-warning me-3 fs-5"></i> <strong>Aforo Máximo:</strong> <%= s.getCapacidad()%> personas simultáneas</div>
                    <% if (s.getTelefono() != null && !s.getTelefono().isEmpty()) {%>
                    <div><i class="fa-solid fa-phone text-warning me-3 fs-5"></i> <strong>Teléfono de contacto:</strong> <%= s.getTelefono()%></div>
                    <% }%>
                </div>

                <div>
                    <a href="${pageContext.request.contextPath}/Login.jsp" class="btn btn-warning text-dark fw-bold px-5 py-3 fs-5 shadow" style="border-radius: 10px;">
                        <i class="fa-solid fa-dumbbell me-2"></i> REGISTRAR ASISTENCIA / RESERVA
                    </a>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>