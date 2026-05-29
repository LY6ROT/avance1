<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <title>GymMax | Mis Reservas</title>
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
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/DashboardSocio"><i class="fa-solid fa-id-card me-2"></i> Mi Suscripción</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/Reserva"><i class="fa-regular fa-calendar-plus me-2"></i> Reservar Clase</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/MisReservas"><i class="fa-solid fa-list-check me-2"></i> Mis Reservas</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/MisPagos"><i class="fa-solid fa-file-invoice-dollar me-2"></i> Mis Pagos</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="p-4 rounded-4 shadow-lg h-100" style="background: #1a1a1a; border: 1px solid #333;">
                        <h3 class="fw-bold mb-4" style="font-family: 'Anton'; letter-spacing: 1px;">MI HISTORIAL DE RESERVAS</h3>

                        <div class="table-responsive">
                            <table class="table table-dark table-hover align-middle" style="border: 1px solid #333;">
                                <thead class="table-active">
                                    <tr class="text-warning">
                                        <th>Fecha y Hora</th>
                                        <th>Clase</th>
                                        <th>Sede</th>
                                        <th>Estado</th>
                                        <th class="text-center">Acción</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty misReservas}">
                                            <c:forEach var="res" items="${misReservas}">
                                                <tr>
                                                    <td>
                                                        <span class="fw-bold d-block"><i class="fa-regular fa-calendar text-info me-1"></i> <c:out value="${res.fecha}"/></span>
                                                        <span class="text-secondary small"><i class="fa-regular fa-clock me-1"></i> <c:out value="${res.hora}"/></span>
                                                    </td>
                                                    <td class="fw-bold"><c:out value="${res.clase}"/></td>
                                                    <td><i class="fa-solid fa-location-dot text-danger me-1"></i> <c:out value="${res.sede}"/></td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${res.estado == 'CONF'}">
                                                                <span class="badge bg-success text-dark fw-bold">CONFIRMADA</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-danger text-white">CANCELADA</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td class="text-center">
                                                        <c:if test="${res.estado == 'CONF'}">
                                                            <form action="${pageContext.request.contextPath}/MisReservas" method="POST" class="m-0">
                                                                <input type="hidden" name="accion" value="cancelar">
                                                                <input type="hidden" name="idReserva" value="${res.idReserva}">
                                                                <button type="submit" class="btn btn-sm btn-outline-danger border-0" title="Cancelar Reserva">
                                                                    <i class="fa-solid fa-ban"></i> Cancelar
                                                                </button>
                                                            </form>
                                                        </c:if>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center text-secondary py-5">
                                                    <i class="fa-solid fa-folder-open fa-3x mb-3"></i><br>
                                                    Aún no tienes historial de reservas.
                                                </td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <c:if test="${cancel == 'exito' || param.cancel == 'exito'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'success', title: 'Reserva Cancelada',
                        text: 'Tu reserva fue cancelada exitosamente. Se te ha devuelto el pase.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700', iconColor: '#FFD700'
                    });
                });
            </script>
        </c:if>

        <c:if test="${cancel == 'error' || param.cancel == 'error'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'error', title: 'No se pudo cancelar',
                        text: 'Hubo un problema procesando tu cancelación o la reserva ya no está activa.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#d33', iconColor: '#d33'
                    });
                });
            </script>
        </c:if>

        <c:if test="${reserva == 'exito_principal' || param.reserva == 'exito_principal'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'success', title: '¡Reserva Confirmada!',
                        text: 'Esta clase se dictará en tu SEDE PRINCIPAL. Acceso ilimitado y gratuito.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700', iconColor: '#FFD700'
                    });
                });
            </script>
        </c:if>

        <c:if test="${reserva == 'exito_foranea' || param.reserva == 'exito_foranea'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'success', title: '¡Pase de Visita Confirmado!',
                        text: 'Has utilizado 1 de tus 3 pases mensuales para visitar otra sede.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700', iconColor: '#FFD700'
                    });
                });
            </script>
        </c:if>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>