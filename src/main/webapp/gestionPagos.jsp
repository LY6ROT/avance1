<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.PagoDTO"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Usuario userAdminCheck = (Usuario) session.getAttribute("usuarioSession");
    if (userAdminCheck == null || !"ADMIN".equals(userAdminCheck.getRol())) {
        response.sendRedirect("Login.jsp");
        return;
    }
    List<PagoDTO> listaPagos = (List<PagoDTO>) request.getAttribute("listaPagos");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Historial de Pagos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;500;600&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        .panel-blanco { background-color: #ffffff !important; color: #212529 !important; }
        .panel-blanco th, .panel-blanco td { background-color: #ffffff !important; color: #212529 !important; }
        .panel-blanco thead th { background-color: #f8f9fa !important; border-bottom: 2px solid #dee2e6 !important; }
        .panel-blanco tbody tr { border-bottom: 1px solid #dee2e6 !important; }
        .panel-blanco tbody tr:hover td { background-color: #f8f9fa !important; }
        .input-buscar-blanco { background-color: #ffffff !important; color: #212529 !important; border: 1px solid #ced4da !important; }
    </style>
</head>
<body>

    <aside class="admin-sidebar">
        <div class="admin-logo text-white">Gym<span style="color: #FFD700;">Max</span></div>
        <div class="admin-subtitle">Administrador</div>

        <ul class="admin-nav">
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminDashboard"><i class="fa-solid fa-chart-line me-2"></i> Panel de Control</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSocios"><i class="fa-solid fa-users me-2"></i> Socios</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSedes"><i class="fa-solid fa-location-dot me-2"></i> Sedes</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminMembresias"><i class="fa-solid fa-award me-2"></i> Membresías</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminClases"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a></li>
            <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/AdminPagos"><i class="fa-solid fa-money-bill-wave me-2"></i> Pagos</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/reportes.jsp"><i class="fa-solid fa-file-invoice me-2"></i> Reportes</a></li>
        </ul>

        <div class="admin-logout mt-auto">
            <ul class="admin-nav">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white"><i class="fa-solid fa-house me-2"></i> Volver al Menú</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutController" class="text-danger"><i class="fa-solid fa-arrow-right-from-bracket me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </aside>

    <main class="admin-content" style="background-color: #f4f6f9 !important; min-height: 100vh;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0" style="color: #212529 !important;">Historial de Pagos</h2>
            <div class="text-secondary"><i class="fa-solid fa-user-tie me-2"></i> Administrador</div>
        </div>

        <div class="panel-blanco p-4 shadow-sm" style="border-radius: 12px; border: 1px solid #e0e0e0;">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <h5 class="fw-bold m-0" style="color: #212529 !important;">
                    <i class="fa-solid fa-file-invoice-dollar me-2 text-dark"></i>Transacciones Recientes
                </h5>

                <div class="d-flex align-items-center gap-2">
                    <form action="${pageContext.request.contextPath}/AdminPagos" method="GET" class="input-group input-group-sm" style="width: 300px;">
                        <input type="text" name="busqueda" class="form-control input-buscar-blanco shadow-none px-3" placeholder="Buscar socio o Nro Operación..." value="${param.busqueda}">
                        <button class="btn btn-dark" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                        <c:if test="${not empty param.busqueda}">
                            <a href="${pageContext.request.contextPath}/AdminPagos" class="btn btn-outline-danger border-start-0" title="Limpiar"><i class="fa-solid fa-xmark"></i></a>
                        </c:if>
                    </form>
                </div>
            </div>

            <div class="table-responsive rounded" style="border: 1px solid #dee2e6;">
                <table class="table align-middle mb-0 panel-blanco">
                    <thead>
                        <tr>
                            <th class="ps-4 fw-bold">ID</th>
                            <th class="fw-bold">Fecha</th>
                            <th class="fw-bold">Socio</th>
                            <th class="fw-bold">Plan</th>
                            <th class="fw-bold">Monto</th>
                            <th class="fw-bold">Método</th>
                            <th class="fw-bold">Estado</th>
                            <th class="text-center pe-4 fw-bold">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="small">
                        <% if (listaPagos != null && !listaPagos.isEmpty()) {
                            for (PagoDTO p : listaPagos) {
                        %>
                            <tr>
                                <td class="fw-bold ps-4 text-secondary">T-<%= String.format("%05d", p.getIdPago()) %></td>
                                <td class="text-dark"><%= p.getFechaPago() %></td>
                                <td class="fw-bold text-dark"><%= p.getNombreSocio() %></td>
                                <td class="text-dark"><span class="badge bg-light text-dark border"><%= p.getNombrePlan() %></span></td>
                                <td class="fw-bold <%= "ANUL".equals(p.getEstado()) ? "text-danger text-decoration-line-through" : "text-success" %>">
                                    S/ <%= String.format("%.2f", p.getMonto()) %>
                                </td>
                                <td class="text-dark"><%= p.getMetodo() %> <br><small class="text-muted"><%= p.getNroOperacion() %></small></td>
                                <td>
                                    <% if("OK".equals(p.getEstado())) { %>
                                        <span class="badge" style="background-color: #d1e7dd !important; color: #0f5132 !important; border: 1px solid #badbcc !important;">Pagado</span>
                                    <% } else if("PEND".equals(p.getEstado())) { %>
                                        <span class="badge" style="background-color: #fff3cd !important; color: #664d03 !important; border: 1px solid #ffecb5 !important;">Pendiente</span>
                                    <% } else { %>
                                        <span class="badge" style="background-color: #f8d7da !important; color: #842029 !important; border: 1px solid #f5c2c7 !important;">Anulado</span>
                                    <% } %>
                                </td>
                                <td class="text-center pe-4">
                                    <% if(!"ANUL".equals(p.getEstado())) { %>
                                        <form action="${pageContext.request.contextPath}/AdminPagos" method="POST" class="d-inline" onsubmit="return confirm('¿Estás seguro de anular este pago? Esto no se puede deshacer.');">
                                            <input type="hidden" name="accion" value="anular">
                                            <input type="hidden" name="idPago" value="<%= p.getIdPago() %>">
                                            <button type="submit" class="btn btn-sm btn-outline-danger" title="Anular Pago"><i class="fa-solid fa-ban"></i> Anular</button>
                                        </form>
                                    <% } else { %>
                                        <button class="btn btn-sm btn-secondary disabled" title="Ya anulado"><i class="fa-solid fa-ban"></i> Anulado</button>
                                    <% } %>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr><td colspan="8" class="text-center py-4 text-dark">No hay pagos registrados.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <c:if test="${param.msg == 'anulado'}"><script>Swal.fire({ icon: 'success', title: 'Pago Anulado', text: 'La transacción fue anulada correctamente.' });</script></c:if>
    <c:if test="${param.msg == 'error'}"><script>Swal.fire({ icon: 'error', title: 'Error', text: 'No se pudo anular el pago.' });</script></c:if>
</body>
</html>