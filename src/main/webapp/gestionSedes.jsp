<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Sede"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Usuario userAdminCheck = (Usuario) session.getAttribute("usuarioSession");
    if (userAdminCheck == null || !"ADMIN".equals(userAdminCheck.getRol())) {
        response.sendRedirect("Login.jsp");
        return;
    }
    List<Sede> listaSedes = (List<Sede>) request.getAttribute("listaSedes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Gestión de Sedes</title>
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
            <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/AdminSedes"><i class="fa-solid fa-location-dot me-2"></i> Sedes</a></li>
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

    <main class="admin-content" style="background-color: #f4f6f9 !important; min-height: 100vh;">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0" style="color: #212529 !important;">Gestión de Sedes</h2>
            <div class="text-secondary"><i class="fa-solid fa-user-tie me-2"></i> Administrador</div>
        </div>

        <div class="panel-blanco p-4 shadow-sm" style="border-radius: 12px; border: 1px solid #e0e0e0;">
            <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                <h5 class="fw-bold m-0" style="color: #212529 !important;">
                    <i class="fa-solid fa-location-dot me-2 text-dark"></i>Sedes Operativas
                </h5>

                <div class="d-flex align-items-center gap-2">
                    <form action="${pageContext.request.contextPath}/AdminSedes" method="GET" class="input-group input-group-sm" style="width: 260px;">
                        <input type="text" name="busqueda" class="form-control input-buscar-blanco shadow-none px-3" placeholder="Buscar sede o distrito..." value="${param.busqueda}">
                        <button class="btn btn-dark" type="submit"><i class="fa-solid fa-magnifying-glass text-white"></i></button>
                        <c:if test="${not empty param.busqueda}">
                            <a href="${pageContext.request.contextPath}/AdminSedes" class="btn btn-outline-danger border-start-0" title="Limpiar"><i class="fa-solid fa-xmark"></i></a>
                        </c:if>
                    </form>
                    <button type="button" class="btn btn-sm btn-warning fw-bold text-dark px-3 text-nowrap" data-bs-toggle="modal" data-bs-target="#modalNuevaSede" style="border-radius: 6px; height: 31px;">
                        <i class="fa-solid fa-plus me-1 text-dark"></i> Nueva Sede
                    </button>
                </div>
            </div>

            <div class="table-responsive rounded" style="border: 1px solid #dee2e6;">
                <table class="table align-middle mb-0 panel-blanco">
                    <thead>
                        <tr>
                            <th class="ps-4 fw-bold">ID</th>
                            <th class="fw-bold">Nombre</th>
                            <th class="fw-bold">Distrito</th>
                            <th class="fw-bold">Horario</th>
                            <th class="fw-bold">Capacidad</th>
                            <th class="text-center pe-4 fw-bold">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="small">
                        <% if (listaSedes != null && !listaSedes.isEmpty()) {
                            for (Sede s : listaSedes) {
                        %>
                            <tr>
                                <td class="fw-bold ps-4 text-secondary"># <%= s.getIdSede() %></td>
                                <td class="fw-bold text-dark"><%= s.getNombre() %></td>
                                <td class="text-dark"><i class="fa-solid fa-map-pin text-warning me-1"></i> <%= s.getDistrito() %></td>
                                <td class="text-dark"><%= s.getHoraApertura().toString().substring(0,5) %> - <%= s.getHoraCierre().toString().substring(0,5) %></td>
                                <td class="text-dark"><span class="badge bg-secondary"><%= s.getCapacidad() %> pax</span></td>
                                <td class="text-center pe-4">
                                    <button type="button" class="btn btn-sm btn-light border-secondary btn-editar-modal me-1 text-dark" 
                                            data-bs-toggle="modal" data-bs-target="#modalEditarSede"
                                            data-id="<%= s.getIdSede() %>" data-nombre="<%= s.getNombre() %>"
                                            data-direccion="<%= s.getDireccion() %>" data-distrito="<%= s.getDistrito() %>"
                                            data-telefono="<%= s.getTelefono() %>" data-apertura="<%= s.getHoraApertura().toString().substring(0,5) %>"
                                            data-cierre="<%= s.getHoraCierre().toString().substring(0,5) %>" data-capacidad="<%= s.getCapacidad() %>"
                                            data-img="<%= s.getImagenUrl() != null ? s.getImagenUrl() : "" %>"
                                            data-desc="<%= s.getDescripcion() != null ? s.getDescripcion() : "" %>">
                                        <i class="fa-solid fa-pen-to-square text-dark"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/AdminSedes" method="POST" class="d-inline" onsubmit="return confirm('¿Eliminar esta sede?');">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="idSede" value="<%= s.getIdSede() %>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger"><i class="fa-solid fa-trash"></i></button>
                                    </form>
                                </td>
                            </tr>
                        <% } } else { %>
                            <tr><td colspan="6" class="text-center py-4 text-dark">No hay sedes registradas.</td></tr>
                        <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <div class="modal fade" id="modalNuevaSede" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-building me-2 text-warning"></i> Registrar Sede</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/AdminSedes" method="POST">
                    <input type="hidden" name="accion" value="nueva">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6"><label class="form-label small fw-bold">Nombre</label><input type="text" name="nombre" class="form-control" required></div>
                            <div class="col-md-6"><label class="form-label small fw-bold">Distrito</label><input type="text" name="distrito" class="form-control" required></div>
                            <div class="col-md-8"><label class="form-label small fw-bold">Dirección Completa</label><input type="text" name="direccion" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Teléfono</label><input type="text" name="telefono" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Apertura</label><input type="time" name="horaApertura" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Cierre</label><input type="time" name="horaCierre" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Capacidad (Pax)</label><input type="number" name="capacidad" class="form-control" min="1" required></div>
                            <div class="col-12"><label class="form-label small fw-bold">URL Imagen</label><input type="url" name="imagenUrl" class="form-control"></div>
                            <div class="col-12"><label class="form-label small fw-bold">Descripción</label><textarea name="descripcion" class="form-control" rows="2"></textarea></div>
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

    <div class="modal fade" id="modalEditarSede" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content border-0 shadow-lg">
                <div class="modal-header border-bottom">
                    <h5 class="modal-title fw-bold"><i class="fa-solid fa-pen-to-square me-2 text-warning"></i> Editar Sede</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/AdminSedes" method="POST">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="idSede" id="edit_id">
                    <div class="modal-body">
                        <div class="row g-3">
                            <div class="col-md-6"><label class="form-label small fw-bold">Nombre</label><input type="text" name="nombre" id="edit_nombre" class="form-control" required></div>
                            <div class="col-md-6"><label class="form-label small fw-bold">Distrito</label><input type="text" name="distrito" id="edit_distrito" class="form-control" required></div>
                            <div class="col-md-8"><label class="form-label small fw-bold">Dirección Completa</label><input type="text" name="direccion" id="edit_direccion" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Teléfono</label><input type="text" name="telefono" id="edit_telefono" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Apertura</label><input type="time" name="horaApertura" id="edit_apertura" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Cierre</label><input type="time" name="horaCierre" id="edit_cierre" class="form-control" required></div>
                            <div class="col-md-4"><label class="form-label small fw-bold">Capacidad (Pax)</label><input type="number" name="capacidad" id="edit_capacidad" class="form-control" min="1" required></div>
                            <div class="col-12"><label class="form-label small fw-bold">URL Imagen</label><input type="url" name="imagenUrl" id="edit_img" class="form-control"></div>
                            <div class="col-12"><label class="form-label small fw-bold">Descripción</label><textarea name="descripcion" id="edit_desc" class="form-control" rows="2"></textarea></div>
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
                document.getElementById('edit_direccion').value = this.getAttribute('data-direccion');
                document.getElementById('edit_distrito').value = this.getAttribute('data-distrito');
                document.getElementById('edit_telefono').value = this.getAttribute('data-telefono');
                document.getElementById('edit_apertura').value = this.getAttribute('data-apertura');
                document.getElementById('edit_cierre').value = this.getAttribute('data-cierre');
                document.getElementById('edit_capacidad').value = this.getAttribute('data-capacidad');
                document.getElementById('edit_img').value = this.getAttribute('data-img');
                document.getElementById('edit_desc').value = this.getAttribute('data-desc');
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <c:if test="${param.msg == 'creada'}"><script>Swal.fire({ icon: 'success', title: 'Sede Registrada', text: 'Se guardó correctamente.' });</script></c:if>
    <c:if test="${param.msg == 'editada'}"><script>Swal.fire({ icon: 'success', title: 'Sede Actualizada', text: 'Cambios guardados.' });</script></c:if>
    <c:if test="${param.msg == 'eliminada'}"><script>Swal.fire({ icon: 'success', title: 'Sede Eliminada', text: 'Registro borrado.' });</script></c:if>
    <c:if test="${param.msg == 'error_fk'}"><script>Swal.fire({ icon: 'error', title: 'Acción Denegada', text: 'La sede tiene clases o socios vinculados.' });</script></c:if>
</body>
</html>
