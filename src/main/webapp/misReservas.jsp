<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioSession");
    if (user == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Mis Reservas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-4" style="max-width: 600px;">
        
        <div class="d-flex align-items-center mb-4">
            <a href="dashboardSocio.jsp" class="text-white text-decoration-none me-3 fs-5"><i class="fa-solid fa-arrow-left"></i></a>
            <h4 class="mb-0 fw-bold text-warning" style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">MIS RESERVAS</h4>
        </div>

        <ul class="nav nav-pills mb-4 border-bottom border-secondary pb-3" id="pills-tab" role="tablist">
            <li class="nav-item" role="presentation">
                <button class="nav-link active bg-warning text-dark fw-bold rounded-pill px-4 me-2" id="proximas-tab" data-bs-toggle="pill" data-bs-target="#proximas" type="button">Próximas</button>
            </li>
            <li class="nav-item" role="presentation">
                <button class="nav-link text-white fw-bold rounded-pill px-4" id="pasadas-tab" data-bs-toggle="pill" data-bs-target="#pasadas" type="button">Historial</button>
            </li>
        </ul>

        <div class="tab-content" id="pills-tabContent">
            
            <div class="tab-pane fade show active" id="proximas" role="tabpanel">
                <div class="d-flex flex-column gap-3">
                    
                    <div class="card bg-black border-secondary shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <span class="badge bg-success mb-2">Confirmada</span>
                                    <h5 class="fw-bold mb-1">CrossFit Intensivo</h5>
                                </div>
                                <div class="text-end text-warning text-center rounded p-2" style="background-color: rgba(255, 215, 0, 0.1);">
                                    <h5 class="fw-bold mb-0">24</h5>
                                    <small>MAY</small>
                                </div>
                            </div>
                            <div class="text-secondary small mb-3">
                                <p class="mb-1"><i class="fa-solid fa-clock me-2"></i> 18:00 - 19:00</p>
                                <p class="mb-1"><i class="fa-solid fa-location-dot me-2"></i> Sede Miraflores</p>
                                <p class="mb-0"><i class="fa-solid fa-user-tie me-2"></i> Instructor: Carlos M.</p>
                            </div>
                            <button class="btn btn-outline-danger btn-sm fw-bold w-100">Cancelar Reserva</button>
                        </div>
                    </div>

                    <div class="card bg-black border-secondary shadow-sm">
                        <div class="card-body">
                            <div class="d-flex justify-content-between align-items-start mb-2">
                                <div>
                                    <span class="badge bg-success mb-2">Confirmada</span>
                                    <h5 class="fw-bold mb-1">Spinning</h5>
                                </div>
                                <div class="text-end text-warning text-center rounded p-2" style="background-color: rgba(255, 215, 0, 0.1);">
                                    <h5 class="fw-bold mb-0">26</h5>
                                    <small>MAY</small>
                                </div>
                            </div>
                            <div class="text-secondary small mb-3">
                                <p class="mb-1"><i class="fa-solid fa-clock me-2"></i> 20:00 - 21:00</p>
                                <p class="mb-1"><i class="fa-solid fa-location-dot me-2"></i> Sede San Isidro (Cambio de sede)</p>
                            </div>
                            <button class="btn btn-outline-danger btn-sm fw-bold w-100">Cancelar Reserva</button>
                        </div>
                    </div>

                </div>
            </div>

            <div class="tab-pane fade" id="pasadas" role="tabpanel">
                <div class="text-center py-5">
                    <i class="fa-solid fa-calendar-check fa-3x text-secondary mb-3"></i>
                    <p class="text-secondary">Aún no tienes clases completadas en tu historial.</p>
                </div>
            </div>

        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>