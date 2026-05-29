<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | Dashboard</title>

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>

        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    </head>
    <body>

        <aside class="admin-sidebar">
            <div class="admin-logo text-white">Gym<span style="color: #FFD700;">Max</span></div>
            <div class="admin-subtitle">Administrador</div>

            <ul class="admin-nav">
                <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/AdminDashboard"><i class="fa-solid fa-chart-line me-2"></i> Panel de Control</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSocios"><i class="fa-solid fa-users me-2"></i> Socios</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSedes"><i class="fa-solid fa-location-dot me-2"></i> Sedes</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminMembresias"><i class="fa-solid fa-award me-2"></i> Membresías</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminClases"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminPagos"><i class="fa-solid fa-money-bill-wave me-2"></i> Pagos</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/reportes.jsp"><i class="fa-solid fa-file-invoice me-2"></i> Reportes</a></li>
            </ul>

            <div class="admin-logout mt-auto">
                <ul class="admin-nav">
                    <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white"><i class="fa-solid fa-house me-2"></i> Volver al Menú</a></li>
                    <li><a href="${pageContext.request.contextPath}/LogoutController" class="text-danger"><i class="fa-solid fa-arrow-right-from-bracket me-2"></i> Cerrar Sesión</a></li>
                </ul>
            </div>
        </aside>

        <main class="admin-content">
            <div class="d-flex justify-content-between align-items-center mb-4">
                <h2 class="fw-bold mb-0">Dashboard</h2>
                <div class="text-secondary">
                    <i class="fa-solid fa-user-tie me-2"></i> Admin • Panel Principal
                </div>
            </div>

            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="kpi-card">
                        <div class="kpi-title">Socios activos</div>
                        <div class="kpi-value text-warning"><c:out value="${stats.sociosActivos}"/></div>
                        <div class="kpi-tendency"><i class="fa-solid fa-arrow-up"></i> +12% este mes</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="kpi-card">
                        <div class="kpi-title">Ingresos del mes</div>
                        <div class="kpi-value">S/ <c:out value="${stats.ingresosMes}"/></div>
                        <div class="kpi-tendency"><i class="fa-solid fa-arrow-up"></i> +8%</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="kpi-card">
                        <div class="kpi-title">Membresías por vencer</div>
                        <div class="kpi-value text-warning"><c:out value="${stats.membresiasVencer}"/></div>
                        <div class="kpi-tendency text-secondary">próximos 7 días</div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="kpi-card">
                        <div class="kpi-title">Reservas hoy</div>
                        <div class="kpi-value"><c:out value="${stats.reservasHoy}"/></div>
                        <div class="kpi-tendency text-secondary">4 sedes activas</div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-8">
                    <div class="admin-table-container h-100">
                        <h6 class="fw-bold mb-4">Ingresos últimos 6 meses</h6>
                        <div class="d-flex align-items-end justify-content-between mt-5 pt-4 border-bottom pb-2 px-3" style="height: 200px;">
                            <div style="height: 40%; width: 40px; background-color: #FFD700; border-radius: 4px 4px 0 0;"></div>
                            <div style="height: 55%; width: 40px; background-color: #FFD700; border-radius: 4px 4px 0 0;"></div>
                            <div style="height: 50%; width: 40px; background-color: #FFD700; border-radius: 4px 4px 0 0;"></div>
                            <div style="height: 70%; width: 40px; background-color: #FFD700; border-radius: 4px 4px 0 0;"></div>
                            <div style="height: 85%; width: 40px; background-color: #FFD700; border-radius: 4px 4px 0 0;"></div>
                            <div style="height: 100%; width: 40px; background-color: #222; border-radius: 4px 4px 0 0;"></div>
                        </div>
                        <div class="d-flex justify-content-between px-3 mt-2 text-secondary small">
                            <span>Nov</span><span>Dic</span><span>Ene</span><span>Feb</span><span>Mar</span><span>Abr</span>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="admin-table-container h-100 d-flex flex-column" style="background-color: #ffffff; color: #212529; border-radius: 12px; padding: 1.5rem;">
                        <h6 class="fw-bold mb-4 text-danger"><i class="fa-solid fa-bell me-2"></i> Próximos Vencimientos</h6>
                        <div class="flex-grow-1 table-responsive">
                            <table class="table table-sm align-middle mb-0">
                                <thead class="table-light">
                                    <tr>
                                        <th class="small text-secondary">Socio</th>
                                        <th class="small text-secondary">Plan</th>
                                        <th class="small text-secondary">Vence</th>
                                        <th class="small text-secondary text-center"><i class="fa-solid fa-paper-plane"></i></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${not empty listaVencimientos}">
                                            <c:forEach var="v" items="${listaVencimientos}">
                                                <tr>
                                                    <td class="fw-bold text-dark" style="font-size: 0.85rem;">${v.socio}</td>
                                                    <td><span class="badge bg-dark text-light" style="font-size: 0.7rem;">${v.plan}</span></td>
                                                    <td>
                                                        <span class="badge ${v.dias == '0' ? 'bg-danger' : 'bg-warning text-dark'}" style="font-size: 0.7rem;">
                                                            ${v.dias == '0' ? 'HOY' : v.dias += ' días'}
                                                        </span>
                                                    </td>
                                                    <td class="text-center">
                                                        <form action="${pageContext.request.contextPath}/AdminDashboard" method="POST" class="d-inline">
                                                            <input type="hidden" name="accion" value="notificar">
                                                            <input type="hidden" name="correo" value="${v.correo}">
                                                            <input type="hidden" name="socio" value="${v.socio}">
                                                            <input type="hidden" name="plan" value="${v.plan}">
                                                            <input type="hidden" name="dias" value="${v.dias}">
                                                            <button type="submit" class="btn btn-sm btn-outline-primary py-0 px-2" title="Enviar Correo"><i class="fa-regular fa-envelope"></i></button>
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </c:when>
                                        <c:otherwise>
                                            <tr>
                                                <td colspan="4" class="text-center text-muted small py-4">No hay membresías por vencer próximamente.</td>
                                            </tr>
                                        </c:otherwise>
                                    </c:choose>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <c:if test="${param.msg == 'correo_enviado'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({ icon: 'success', title: '¡Notificación Enviada!', text: 'El socio ha recibido un correo recordatorio.', confirmButtonColor: '#FFD700' });
            });
        </script>
    </c:if>
    <c:if test="${param.msg == 'correo_error'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({ icon: 'error', title: 'Error', text: 'Hubo un problema enviando el correo. Revisa la consola.', confirmButtonColor: '#d33' });
            });
        </script>
    </c:if>
    </body>
    
</html>