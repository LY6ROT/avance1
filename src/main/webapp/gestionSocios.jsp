<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Gestión de Socios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;500;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
</head>
<body>

    <aside class="admin-sidebar">
        <div class="admin-logo text-white">Gym<span style="color: #FFD700;">Max</span></div>
        <div class="admin-subtitle">Administrador</div>
        
        <ul class="admin-nav">
            <li><a href="adminDashboard.jsp"><i class="fa-solid fa-gauge-high"></i> Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/AdminSocios" class="active"><i class="fa-solid fa-users"></i> Socios</a></li>
            <li><a href="#"><i class="fa-solid fa-location-dot"></i> Sedes</a></li>
            <li><a href="#"><i class="fa-solid fa-award"></i> Membresías</a></li>
            <li><a href="reservarClase.jsp"><i class="fa-regular fa-calendar-days"></i> Clases</a></li>
            <li><a href="#"><i class="fa-solid fa-money-bill-wave"></i> Pagos</a></li>
            <li><a href="reportes.jsp"><i class="fa-solid fa-chart-line"></i> Reportes</a></li>
        </ul>

        <div class="admin-logout mt-auto">
            <ul class="admin-nav">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white"><i class="fa-solid fa-house"></i> Volver al Menú</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutController" class="text-danger"><i class="fa-solid fa-arrow-right-from-bracket"></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </aside>

    <main class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Gestión de Socios</h2>
            <div class="text-secondary">
                <i class="fa-solid fa-user-tie me-2"></i> Administrador
            </div>
        </div>

        <div class="admin-table-container">
            <div class="d-flex justify-content-between align-items-center mb-3">
                <h6 class="fw-bold m-0 text-warning">Socios Registrados en el Sistema</h6>
            </div>
            
            <div class="table-responsive">
                <table class="table table-dark table-hover align-middle mb-0">
                    <thead>
                        <tr class="text-secondary" style="border-bottom: 2px solid #333;">
                            <th scope="col">ID Socio</th>
                            <th scope="col">Nombre Completo</th>
                            <th scope="col">DNI</th>
                            <th scope="col">Correo Electrónico</th>
                            <th scope="col">Fecha Registro</th>
                            <th scope="col" class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${not empty listaSocios}">
                                <c:forEach var="socio" items="${listaSocios}">
                                    <tr>
                                        <td class="fw-bold text-warning">#<c:out value="${socio.idSocio}"/></td>
                                        <td><c:out value="${socio.nombreCompleto}"/></td>
                                        <td><c:out value="${socio.dni}"/></td>
                                        <td class="text-info"><c:out value="${socio.correo}"/></td>
                                        <td><c:out value="${socio.fechaRegistro}"/></td>
                                        <td class="text-center">
                                            <button class="btn btn-sm btn-outline-warning me-1"><i class="fa-solid fa-pen-to-square"></i></button>
                                            <button class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:when>
                            <c:otherwise>
                                <tr>
                                    <td colspan="6" class="text-center text-secondary py-4">
                                        <i class="fa-solid fa-users-slash fa-2x mb-2"></i><br> No se encontraron socios registrados en la base de datos.
                                    </td>
                                end Check
                                </tr>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>