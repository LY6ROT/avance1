<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | Mi Dashboard</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;500;600;700&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
    </head>
    <body class="bg-dark text-white">

        <%@include file="/WEB-INF/fragments/header.jsp" %>

        <div class="container py-5 mt-5">
            <div class="row g-4 mt-3">

                <div class="col-lg-3">
                    <div class="p-4 rounded-4 shadow-lg text-center" style="background: #1a1a1a; border: 1px solid #333;">
                        <div class="bg-warning rounded-circle d-inline-flex align-items-center justify-content-center mb-3" style="width: 80px; height: 80px;">
                            <i class="fa-solid fa-user-astronaut fa-2x text-dark"></i>
                        </div>
                        <h5 class="fw-bold text-warning mb-1"><c:out value="${sessionScope.usuarioSession.nombres}"/></h5>
                        <p class="text-secondary small mb-4">Socio Activado</p>
                        <hr class="border-secondary">
                        <ul class="nav flex-column text-start gap-2 mt-3">
                            <li class="nav-item">
                                <a class="nav-link text-warning fw-bold bg-black rounded-3" href="#"><i class="fa-solid fa-id-card me-2"></i> Mi Suscripción</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/Reserva"><i class="fa-regular fa-calendar-plus me-2"></i> Reservar Clase</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/MisReservas"><i class="fa-solid fa-list-check me-2"></i> Mis Reservas</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="p-4 rounded-4 shadow-lg h-100" style="background: #1a1a1a; border: 1px solid #333;">
                        <h3 class="fw-bold mb-4" style="font-family: 'Anton'; letter-spacing: 1px;">ESTADO DE MI MEMBRESÍA</h3>

                        <c:choose>
                            <c:when test="${not empty infoMembresia}">
                                <div class="card border-0 rounded-4 overflow-hidden position-relative p-4 text-dark shadow-lg" 
                                     style="background: linear-gradient(135deg, #FFD700 0%, #FFA500 100%);">
                                    <div class="position-absolute end-0 top-0 p-4 opacity-25">
                                        <i class="fa-solid fa-crown fa-5x"></i>
                                    </div>
                                    <div class="row align-items-center">
                                        <div class="col-md-8">
                                            <span class="badge bg-dark text-warning fw-bold mb-2">MEMBRESÍA ACTIVA</span>
                                            <h2 class="fw-extrabold mb-3" style="font-family: 'Anton'; font-size: 2.5rem;"><c:out value="${infoMembresia.plan}"/></h2>
                                            <p class="m-0 mb-1"><strong>Sede Principal:</strong> <c:out value="${infoMembresia.sede}"/></p>
                                            <p class="m-0 mb-1"><strong>Fecha de Inicio:</strong> <c:out value="${infoMembresia.inicio}"/></p>
                                            <p class="m-0"><strong>Fecha de Vencimiento:</strong> <c:out value="${infoMembresia.fin}"/></p>

                                            <button class="btn btn-sm btn-dark text-white fw-bold mt-3 px-3 rounded-pill" data-bs-toggle="modal" data-bs-target="#modalCambiarSede">
                                                <i class="fa-solid fa-house-laptop text-warning me-1"></i> Cambiar Sede Principal
                                            </button>
                                        </div>
                                        <div class="col-md-4 text-md-end mt-3 mt-md-0">
                                            <div class="bg-dark text-white rounded-4 p-3 d-inline-block text-center shadow-sm">
                                                <i class="fa-solid fa-qrcode fa-3x mb-2 text-warning"></i>
                                                <p class="m-0 small fw-bold">Pase de Ingreso</p>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </c:when>

                            <c:otherwise>
                                <div class="text-center py-5 border border-dashed rounded-4 border-secondary bg-black bg-opacity-20">
                                    <i class="fa-solid fa-circle-exclamation text-secondary fa-3x mb-3"></i>
                                    <h4 class="text-white fw-bold">No tienes ninguna membresía activa</h4>
                                    <p class="text-secondary small mx-auto mb-4" style="max-width: 450px;">
                                        Para comenzar a reservar tus clases grupales y registrar tus asistencias diarias en nuestros establecimientos, necesitas adquirir uno de nuestros planes corporativos.
                                    </p>
                                    <a href="${pageContext.request.contextPath}/Gimnasios" class="btn btn-warning fw-bold px-4 py-2 text-dark rounded-pill shadow">
                                        <i class="fa-solid fa-dumbbell me-2"></i> EXPLORAR GIMNASIOS Y PLANES
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>

                    </div>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
        <c:if test="${pago == 'exito' || param.pago == 'exito'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'success',
                        title: '¡PAGO COMPLETADO!',
                        text: 'Tu transacción se registró correctamente. ¡Tu membresía ya está activa!',
                        background: '#1a1a1a',
                        color: '#ffffff',
                        confirmButtonColor: '#FFD700',
                        confirmButtonText: '<span style="color: #000; font-weight: bold;">Genial, vamos a entrenar</span>',
                        iconColor: '#FFD700'
                    });
                });
            </script>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <c:if test="${not empty listaSedesForzosa}">
            <div class="modal fade show" id="modalSede" tabindex="-1" style="display: block; background: rgba(0,0,0,0.8);" data-bs-backdrop="static" data-bs-keyboard="false">
                <div class="modal-dialog modal-dialog-centered">
                    <div class="modal-content bg-dark border-warning">
                        <div class="modal-header border-0">
                            <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-location-dot me-2"></i> Configura tu Sede Principal</h5>
                        </div>
                        <form action="${pageContext.request.contextPath}/DashboardSocio" method="POST">
                            <div class="modal-body text-white">
                                <p>¡Felicidades por tu suscripción! Para finalizar la activación de tu membresía, elige el gimnasio que visitarás con más frecuencia. <strong>Las reservas en esta sede serán siempre gratuitas e ilimitadas.</strong></p>
                                <select name="idSede" class="form-select bg-black text-white border-secondary" required>
                                    <option value="" disabled selected>-- Elige tu gimnasio base --</option>
                                    <c:forEach var="sede" items="${listaSedesForzosa}">
                                        <option value="${sede.id}">${sede.nombre}</option>
                                    </c:forEach>
                                </select>
                            </div>
                            <div class="modal-footer border-0">
                                <button type="submit" class="btn btn-warning fw-bold w-100">Guardar mi Sede</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </c:if>
        
        
        <div class="modal fade" id="modalCambiarSede" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content bg-dark border-secondary">
                <div class="modal-header border-0">
                    <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-repeat me-2"></i> Cambiar mi Gimnasio Base</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-shadow="none" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/DashboardSocio" method="POST">
                    <div class="modal-body text-white">
                        <p class="small text-secondary">Al cambiar tu sede principal, las clases de la nueva sede seleccionada pasarán a ser libres e ilimitadas.</p>
                        <label class="mb-2 text-warning small fw-bold">Selecciona tu nueva sede principal:</label>
                        <select name="idSede" class="form-select bg-black text-white border-secondary" required>
                            <c:forEach var="sede" items="${listaTodasSedes}">
                                <option value="${sede.id}"><c:out value="${sede.nombre}"/></option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="modal-footer border-0">
                        <button type="button" class="btn btn-sm btn-outline-light rounded-pill px-3" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-sm btn-warning fw-bold rounded-pill px-4">Actualizar Sede</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <c:if test="${not empty sessionScope.alertaSedeActualizada}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({
                    icon: 'success',
                    title: '¡Sede Actualizada!',
                    text: '<%= session.getAttribute("alertaSedeActualizada") %>',
                    background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700', iconColor: '#FFD700'
                });
            });
        </script>
        <% session.removeAttribute("alertaSedeActualizada"); %>
    </c:if>
    </body>
</html>