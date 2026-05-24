<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | Reservar Clase</title>
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
                                <a class="nav-link text-warning fw-bold bg-black rounded-3" href="${pageContext.request.contextPath}/Reserva"><i class="fa-regular fa-calendar-plus me-2"></i> Reservar Clase</a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link text-white" href="${pageContext.request.contextPath}/MisReservas"><i class="fa-solid fa-list-check me-2"></i> Mis Reservas</a>
                            </li>
                        </ul>
                    </div>
                </div>

                <div class="col-lg-9">
                    <div class="p-4 rounded-4 shadow-lg h-100" style="background: #1a1a1a; border: 1px solid #333;">
                        <h3 class="fw-bold mb-4" style="font-family: 'Anton'; letter-spacing: 1px;">CATÁLOGO DE CLASES GRUPALES</h3>

                        <div class="card bg-black border-secondary mb-4 p-3 rounded-4 shadow-sm">
                            <div class="d-flex align-items-center justify-content-between flex-wrap gap-3">
                                <div>
                                    <h5 class="text-white mb-1"><i class="fa-solid fa-right-left text-warning me-2"></i> Pases a Otras Sedes</h5>
                                    <p class="text-secondary small mb-0">Tienes derecho a 3 visitas mensuales a gimnasios diferentes a tu sede principal.</p>
                                </div>
                                <div class="text-end bg-dark p-2 rounded-3 border border-secondary" style="min-width: 120px;">
                                    <c:set var="usados" value="${visitasOtraSede != null ? visitasOtraSede : 0}" />
                                    <c:set var="disponibles" value="${(3 - usados) < 0 ? 0 : (3 - usados)}" />
                                    <h3 class="fw-bold text-warning m-0">
                                        <c:out value="${disponibles}"/> <span class="fs-6 text-secondary">/ 3</span>
                                    </h3>
                                    <small class="text-secondary" style="font-size: 0.7rem;">DISPONIBLES ESTE MES</small>
                                </div>
                            </div>
                        </div>

                        <div class="table-responsive">
                            <table class="table table-dark table-hover align-middle" style="border: 1px solid #333;">
                                <thead class="table-active">
                                    <tr class="text-warning">
                                        <th>Disciplina</th>
                                        <th>Ubicación (Sede)</th>
                                        <th>Instructor</th>
                                        <th>Hora</th>
                                        <th>Selecciona tu Fecha</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty listaClases}">
                                            <c:forEach var="clase" items="${listaClases}">
                                                <tr>
                                                    <td>
                                                        <span class="fw-bold d-block"><c:out value="${clase.clase}"/></span>
                                                        <span class="badge bg-secondary" style="font-size: 0.7rem;"><c:out value="${clase.tipo}"/></span>
                                                    </td>
                                                    <td><i class="fa-solid fa-location-dot text-danger me-1"></i> <c:out value="${clase.sede}"/></td>
                                                    <td class="text-light"><c:out value="${clase.instructor}"/></td>
                                                    <td><i class="fa-regular fa-clock text-info me-1"></i> <c:out value="${clase.hora}"/></td>
                                                    <td style="width: 250px; text-align: left; white-space: nowrap;">
                                                        <form action="${pageContext.request.contextPath}/Reserva" method="POST" style="margin: 0; padding: 0; display: block;">
                                                            <input type="hidden" name="idClase" value="${clase.idClase}">
                                                            <input type="hidden" name="hora" value="${clase.hora}">

                                                            <input type="date" name="fecha" min="${minFecha}" max="${maxFecha}" required 
                                                                   style="width: 130px; display: inline-block; vertical-align: middle; padding: 4px 8px; border-radius: 4px; border: 1px solid #666; background-color: #222; color: #fff; margin-right: 5px;">

                                                            <button type="submit" 
                                                                    style="display: inline-block; vertical-align: middle; padding: 5px 12px; border-radius: 4px; border: 1px solid #FFD700; background-color: transparent; color: #FFD700; font-weight: bold; cursor: pointer; transition: 0.3s;">
                                                                Reservar
                                                            </button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="5" class="text-center text-secondary py-5">
                                                    <i class="fa-solid fa-calendar-xmark fa-3x mb-3"></i><br>
                                                    No hay clases grupales programadas en este momento.
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
        <c:if test="${param.error == 'sedepredeterminada'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({
                    icon: 'warning',
                    title: 'Sede Predeterminada',
                    text: 'No se puede reservar en la sede predeterminada que tienes.',
                    background: '#1a1a1a',
                    color: '#ffffff',
                    confirmButtonColor: '#FFA500',
                    confirmButtonText: 'Entendido',
                    iconColor: '#FFA500'
                });
            });
        </script>
    </c:if>
        <c:if test="${param.error == 'limite'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Límite Excedido',
                        text: 'Ya has utilizado tus 3 cambios de sede este mes. Solo puedes reservar clases en tu sede principal.',
                        background: '#1a1a1a',
                        color: '#ffffff',
                        confirmButtonColor: '#d33',
                        confirmButtonText: 'Entendido',
                        iconColor: '#d33'
                    });
                });
            </script>
        </c:if>
        <c:if test="${param.error == 'db'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'warning',
                        title: 'Hubo un problema',
                        text: 'No pudimos registrar tu reserva. Intenta nuevamente.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700'
                    });
                });
            </script>
        </c:if>

        <div class="fondo_pie mt-5">
            <footer class="pie container text-center">
                <p class="copyright text-secondary pt-3">© 2026 GymMax. Oliver Torre Escobar - UTP</p>
            </footer>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>