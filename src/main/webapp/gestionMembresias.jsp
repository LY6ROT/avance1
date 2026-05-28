<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Plan"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Usuario userAdminCheck = (Usuario) session.getAttribute("usuarioSession");
    if (userAdminCheck == null || !"ADMIN".equals(userAdminCheck.getRol())) {
        response.sendRedirect("Login.jsp");
        return;
    }
    List<Plan> listaPlanes = (List<Plan>) request.getAttribute("listaPlanes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Gestión de Membresías</title>
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
            <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/AdminMembresias"><i class="fa-solid fa-award me-2"></i> Membresías</a></li>
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

    <main class="admin-content" style="background-color: #f4f6f9 !important; min-height: 100vh;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0" style="color: #212529 !important;">Gestión de Membresías</h2>
            <div class="text-secondary"><i class="fa-solid fa-user-tie me-2"></i> Administrador</div>
        </div>

        <div class="panel-blanco p-4 shadow-sm" style="border-radius: 12px; border: 1px solid #e0e0e0;">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <h5 class="fw-bold m-0" style="color: #212529 !important;">
                    <i class="fa-solid fa-award me-2 text-dark"></i>Planes Disponibles
                </h5>

                <div class="d-flex align-items-center gap-2">
                    <form action="${pageContext.request.contextPath}/AdminMembresias" method="GET" class="input-group input-group-sm" style="width: 260px;">
                        <input type="text" name="busqueda" class="form-control input-buscar-blanco shadow-none px-3" placeholder="Buscar plan..." value="${param.busqueda}">
                        <button class="btn btn-dark" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                        <c:if test="${not empty param.busqueda}">
                            <a href="${pageContext.request.contextPath}/AdminMembresias" class="btn btn-outline-danger border-start-0" title="Limpiar"><i class="fa-solid fa-xmark"></i></a>
                        </c:if>
                    </form>
                    <button type="button" class="btn btn-sm btn-warning fw-bold text-dark px-3 text-nowrap" data-bs-toggle="modal" data-bs-target="#modalNuevoPlan" style="border-radius: 6px; height: 31px;">
                        <i class="fa-solid fa-plus me-1 text-dark"></i> Nuevo Plan
                    </button>
                </div>
            </div>

            <div class="table-responsive rounded" style="border: 1px solid #dee2e6;">
                <table class="table align-middle mb-0 panel-blanco">
                    <thead>
                        <tr>
                            <th class="ps-4 fw-bold">ID</th>
                            <th class="fw-bold">Nombre del Plan</th>
                            <th class="fw-bold">Categoría</th>
                            <th class="fw-bold">Precio (S/)</th>
                            <th class="fw-bold">Duración</th>
                            <th class="fw-bold">Estado</th>
                            <th class="text-center pe-4 fw-bold">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="small">
                        <% if (listaPlanes != null && !listaPlanes.isEmpty()) {
                            for (Plan p : listaPlanes) {
                        %>
                            <tr>
                                <td class="fw-bold ps-4 text-secondary">P-<%= String.format("%04d", p.getIdPlan()) %></td>
                                <td class="fw-bold text-dark"><%= p.getNombre() %></td>
                                <td class="text-dark"><span class="badge bg-secondary"><%= p.getTipo() %></span></td>
                                <td class="text-dark fw-bold text-success">S/ <%= String.format("%.2f", p.getPrecio()) %></td>
                                <td class="text-dark"><i class="fa-regular fa-calendar me-1 text-secondary"></i> <%= p.getDuracionDias() %> días</td>
                                <td>
                                    <% if(p.isActivo()) { %>
                                        <span class="badge" style="background-color: #d1e7dd !important; color: #0f5132 !important; border: 1px solid #badbcc !important;">Activo</span>
                                    <% } else { %>
                                        <span class="badge" style="background-color: #f8d7da !important; color: #842029 !important; border: 1px solid #f5c2c7 !important;">Inactivo</span>
                                    <% } %>
                                </td>
                                <td class="text-center pe-4">
                                    <button type="button" class="btn btn-sm btn-light border-secondary btn-editar-modal me-1 text-dark" 
                                            data-bs-toggle="modal" data-bs-target="#modalEditarPlan"
                                            data-id="<%= p.getIdPlan() %>" data-nombre="<%= p.getNombre() %>"
                                            data-tipo="<%= p.getTipo() %>" data-precio="<%= p.getPrecio() %>"
                                            data-duracion="<%= p.getDuracionDias() %>" data-activo="<%= p.isActivo() %>">
                                        <i class="fa-solid fa-pen-to-square text-dark"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/AdminMembresias" method="POST" class="d-inline" onsubmit="return confirm('¿Eliminar este plan?');">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="idPlan" value="<%= p.getIdPlan() %>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr><td colspan="7" class="text-center py-4 text-dark">No hay planes registrados.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <div class="modal fade" id="modalNuevoPlan" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-award me-2 text-warning"></i> Registrar Plan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/AdminMembresias" method="POST">
                    <input type="hidden" name="accion" value="nuevo">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-12"><label class="form-label small fw-bold">Nombre del Plan</label><input type="text" name="nombre" class="form-control" required></div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Categoría (Tipo)</label>
                                <select name="tipo" class="form-select" required>
                                    <option value="BASIC">BASIC</option>
                                    <option value="PREM">PREM</option>
                                    <option value="ANUAL">ANUAL</option>
                                </select>
                            </div>
                            <div class="col-md-6"><label class="form-label small fw-bold">Precio (S/)</label><input type="number" step="0.01" name="precio" class="form-control" required></div>
                            <div class="col-md-12"><label class="form-label small fw-bold">Duración (Días)</label><input type="number" name="duracion" class="form-control" required></div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-sm btn-warning fw-bold rounded-pill px-4">Guardar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalEditarPlan" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-pen-to-square me-2 text-warning"></i> Editar Plan</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/AdminMembresias" method="POST">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="idPlan" id="edit_id">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-12"><label class="form-label small fw-bold">Nombre del Plan</label><input type="text" name="nombre" id="edit_nombre" class="form-control" required></div>
                            <div class="col-md-6">
                                <label class="form-label small fw-bold">Categoría (Tipo)</label>
                                <select name="tipo" id="edit_tipo" class="form-select" required>
                                    <option value="BASIC">BASIC</option>
                                    <option value="PREM">PREM</option>
                                    <option value="ANUAL">ANUAL</option>
                                </select>
                            </div>
                            <div class="col-md-6"><label class="form-label small fw-bold">Precio (S/)</label><input type="number" step="0.01" name="precio" id="edit_precio" class="form-control" required></div>
                            <div class="col-md-12"><label class="form-label small fw-bold">Duración (Días)</label><input type="number" name="duracion" id="edit_duracion" class="form-control" required></div>
                            <div class="col-md-12">
                                <div class="form-check form-switch mt-2">
                                    <input class="form-check-input" type="checkbox" name="activo" id="edit_activo" value="true">
                                    <label class="form-check-label small fw-bold" for="edit_activo">Plan Activo (Visible en tienda)</label>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer bg-light">
                        <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-sm btn-warning fw-bold rounded-pill px-4">Actualizar</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.btn-editar-modal').forEach(btn => {
            btn.addEventListener('click', function() {
                document.getElementById('edit_id').value = this.getAttribute('data-id');
                document.getElementById('edit_nombre').value = this.getAttribute('data-nombre');
                document.getElementById('edit_tipo').value = this.getAttribute('data-tipo');
                document.getElementById('edit_precio').value = this.getAttribute('data-precio');
                document.getElementById('edit_duracion').value = this.getAttribute('data-duracion');
                document.getElementById('edit_activo').checked = this.getAttribute('data-activo') === 'true';
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <c:if test="${param.msg == 'creado'}"><script>Swal.fire({ icon: 'success', title: 'Plan Registrado', text: 'Se guardó correctamente.' });</script></c:if>
    <c:if test="${param.msg == 'editado'}"><script>Swal.fire({ icon: 'success', title: 'Plan Actualizado', text: 'Cambios guardados.' });</script></c:if>
    <c:if test="${param.msg == 'eliminado'}"><script>Swal.fire({ icon: 'success', title: 'Plan Eliminado', text: 'Registro borrado.' });</script></c:if>
    <c:if test="${param.msg == 'error_fk'}"><script>Swal.fire({ icon: 'error', title: 'Acción Denegada', text: 'El plan tiene socios vinculados.' });</script></c:if>
</body>
</html>