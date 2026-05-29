<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Clase"%>
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
    
    // Obtenemos las listas directamente con casting nativo para evitar conflictos con JSTL
    List<Clase> listaClases = (List<Clase>) request.getAttribute("listaClases");
    List<Sede> listaSedes = (List<Sede>) request.getAttribute("listaSedes");
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Gestión de Clases</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    <style>
        /* REGLAS FUERTES PARA FORZAR EL BLOQUE BLANCO */
        .panel-blanco {
            background-color: #ffffff !important;
            color: #212529 !important;
        }
        .panel-blanco th, .panel-blanco td {
            background-color: #ffffff !important;
            color: #212529 !important;
        }
        .panel-blanco thead th {
            background-color: #f8f9fa !important;
            border-bottom: 2px solid #dee2e6 !important;
        }
        .panel-blanco tbody tr {
            border-bottom: 1px solid #dee2e6 !important;
        }
        .panel-blanco tbody tr:hover td {
            background-color: #f8f9fa !important;
            color: #212529 !important;
        }
    </style>
</head>
<body>

    <aside class="admin-sidebar">
        <div class="admin-logo text-white">Gym<span style="color: #FFD700;">Max</span></div>
        <div class="admin-subtitle">Administrador</div>

        <ul class="admin-nav">
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminDashboard">
                    <i class="fa-solid fa-chart-line me-2"></i> Panel de Control</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSocios">
                    <i class="fa-solid fa-users me-2"></i> Socios</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSedes">
                    <i class="fa-solid fa-location-dot me-2"></i> Sedes</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminMembresias">
                    <i class="fa-solid fa-award me-2"></i> Membresías</a></li>
            <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/AdminClases"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminPagos">
                    <i class="fa-solid fa-money-bill-wave me-2"></i> Pagos</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/reportes.jsp">
                    <i class="fa-solid fa-file-invoice me-2"></i> Reportes</a></li>
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
            <h2 class="fw-bold mb-0" style="color: #212529 !important;">Gestión de Clases</h2>
            <button type="button" class="btn btn-warning text-dark fw-bold shadow" data-bs-toggle="modal" data-bs-target="#modalNuevaClase" style="border-radius: 6px;">
                <i class="fa-solid fa-plus me-2"></i> Nueva Clase
            </button>
        </div>

        <div class="panel-blanco p-4 shadow-sm" style="border-radius: 12px; border: 1px solid #e0e0e0;">
            <div class="table-responsive rounded" style="border: 1px solid #dee2e6;">
                <table class="table align-middle mb-0 panel-blanco">
                    <thead>
                        <tr>
                            <th class="ps-4 fw-bold" style="padding: 12px 8px;">ID</th>
                            <th class="fw-bold" style="padding: 12px 8px;">Sede</th>
                            <th class="fw-bold" style="padding: 12px 8px;">Nombre / Disciplina</th>
                            <th class="fw-bold" style="padding: 12px 8px;">Instructor</th>
                            <th class="fw-bold" style="padding: 12px 8px;">Hora Inicio</th>
                            <th class="fw-bold" style="padding: 12px 8px;">Cupo Max.</th>
                            <th class="fw-bold" style="padding: 12px 8px;">Estado</th>
                            <th class="text-center pe-4 fw-bold" style="padding: 12px 8px;">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="small">
                        <%
                            if (listaClases != null && !listaClases.isEmpty()) {
                                for (Clase c : listaClases) {
                                    String nombreSede = "No asignada";
                                    if (listaSedes != null) {
                                        for (Sede s : listaSedes) {
                                            if (s.getIdSede() == c.getIdSede()) {
                                                nombreSede = s.getNombre();
                                                break;
                                            }
                                        }
                                    }
                        %>
                            <tr>
                                <td class="fw-bold ps-4 text-secondary">C-<%= String.format("%04d", c.getIdClase()) %></td>
                                <td><span class="badge border text-dark" style="background-color: #f8f9fa !important; border-color: #ced4da !important;"><i class="fa-solid fa-location-dot me-1 text-secondary"></i> <%= nombreSede %></span></td>
                                <td class="fw-bold text-dark"><%= c.getNombre() %> <span class="badge border ms-2 text-dark" style="background-color: #e9ecef !important; font-size: 0.65rem;"><%= c.getTipo() %></span></td>
                                <td class="text-dark"><i class="fa-solid fa-user-tie text-secondary me-2"></i><%= c.getInstructor() %></td>
                                <td class="text-dark fw-bold"><i class="fa-regular fa-clock me-1 text-secondary"></i> <%= c.getHoraInicio() != null ? c.getHoraInicio().toString().substring(0, 5) : "--:--" %></td>
                                <td class="text-dark"><%= c.getCupoMaximo() %> pax</td>
                                <td><span class="badge" style="background-color: #d1e7dd !important; color: #0f5132 !important; border: 1px solid #badbcc !important; font-weight: bold;">Activa</span></td>
                                <td class="text-center pe-4">
                                    <button type="button" class="btn btn-sm btn-light border-secondary btn-edit-clase me-1 text-dark"
                                            data-bs-toggle="modal" data-bs-target="#modalEditarClase"
                                            data-id="<%= c.getIdClase() %>"
                                            data-nombre="<%= c.getNombre() %>"
                                            data-tipo="<%= c.getTipo() %>"
                                            data-instructor="<%= c.getInstructor() %>"
                                            data-hora="<%= c.getHoraInicio() != null ? c.getHoraInicio().toString().substring(0, 5) : "" %>"
                                            data-cupo="<%= c.getCupoMaximo() %>"
                                            data-sede="<%= c.getIdSede() %>">
                                        <i class="fa-solid fa-pen-to-square"></i>
                                    </button>
                                    <form action="${pageContext.request.contextPath}/AdminClases" method="POST" class="d-inline" onsubmit="return confirm('¿Está seguro de eliminar esta clase del sistema?');">
                                        <input type="hidden" name="accion" value="eliminar">
                                        <input type="hidden" name="idClase" value="<%= c.getIdClase() %>">
                                        <button type="submit" class="btn btn-sm btn-outline-danger py-1 px-2 rounded-3">
                                            <i class="fa-solid fa-trash"></i>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        <%
                                }
                            } else {
                        %>
                            <tr>
                                <td colspan="8" class="text-center py-5 text-dark">
                                    <i class="fa-solid fa-calendar-xmark fa-3x mb-3 d-block text-muted"></i>
                                    <h5 class="fw-bold">No hay clases programadas</h5>
                                    <p class="small text-secondary">Aún no se ha registrado ninguna clase en el sistema.</p>
                                </td>
                            </tr>
                        <%
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </main>

    <div class="modal fade" id="modalNuevaClase" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content bg-dark text-white border-warning">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-dumbbell me-2"></i> Agregar Nueva Clase</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/AdminClases" method="POST">
                    <input type="hidden" name="accion" value="nueva">
                    <div class="modal-body d-flex flex-column gap-3">
                        <div>
                            <label class="form-label small text-secondary fw-bold">Nombre / Disciplina</label>
                            <input type="text" name="nombre" class="form-control bg-black text-white border-secondary" placeholder="Ej. Zumba, Spinning" required>
                        </div>
                        <div>
                            <label class="form-label small text-secondary fw-bold">Tipo</label>
                            <input type="text" name="tipo" class="form-control bg-black text-white border-secondary" placeholder="Ej. Cardio, Fuerza" required>
                        </div>
                        <div>
                            <label class="form-label small text-secondary fw-bold">Instructor</label>
                            <input type="text" name="instructor" class="form-control bg-black text-white border-secondary" placeholder="Nombre del instructor" required>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label class="form-label small text-secondary fw-bold">Hora de Inicio</label>
                                <input type="time" name="horaInicio" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label small text-secondary fw-bold">Cupo Máximo</label>
                                <input type="number" name="cupoMaximo" class="form-control bg-black text-white border-secondary" min="1" placeholder="Ej. 20" required>
                            </div>
                        </div>
                        <div>
                            <label class="form-label small text-secondary fw-bold">Sede</label>
                            <select name="idSede" class="form-select bg-black text-white border-secondary" required>
                                <option value="" disabled selected>Seleccione una sede...</option>
                                <%
                                    if (listaSedes != null) {
                                        for (Sede s : listaSedes) {
                                %>
                                    <option value="<%= s.getIdSede() %>"><%= s.getNombre() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button type="button" class="btn btn-sm btn-outline-light rounded-pill px-3" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-sm btn-warning fw-bold rounded-pill px-4">Guardar Clase</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <div class="modal fade" id="modalEditarClase" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content bg-dark text-white border-warning">
                <div class="modal-header border-secondary">
                    <h5 class="modal-title text-warning fw-bold"><i class="fa-solid fa-pen-to-square me-2"></i> Editar Clase</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <form action="${pageContext.request.contextPath}/AdminClases" method="POST">
                    <input type="hidden" name="accion" value="editar">
                    <input type="hidden" name="idClase" id="edit_idClase">
                    <div class="modal-body d-flex flex-column gap-3">
                        <div>
                            <label class="form-label small text-secondary fw-bold">Nombre / Disciplina</label>
                            <input type="text" name="nombre" id="edit_nombre" class="form-control bg-black text-white border-secondary" required>
                        </div>
                        <div>
                            <label class="form-label small text-secondary fw-bold">Tipo</label>
                            <input type="text" name="tipo" id="edit_tipo" class="form-control bg-black text-white border-secondary" required>
                        </div>
                        <div>
                            <label class="form-label small text-secondary fw-bold">Instructor</label>
                            <input type="text" name="instructor" id="edit_instructor" class="form-control bg-black text-white border-secondary" required>
                        </div>
                        <div class="row">
                            <div class="col-6">
                                <label class="form-label small text-secondary fw-bold">Hora de Inicio</label>
                                <input type="time" name="horaInicio" id="edit_hora" class="form-control bg-black text-white border-secondary" required>
                            </div>
                            <div class="col-6">
                                <label class="form-label small text-secondary fw-bold">Cupo Máximo</label>
                                <input type="number" name="cupoMaximo" id="edit_cupo" class="form-control bg-black text-white border-secondary" min="1" required>
                            </div>
                        </div>
                        <div>
                            <label class="form-label small text-secondary fw-bold">Sede</label>
                            <select name="idSede" id="edit_sede" class="form-select bg-black text-white border-secondary" required>
                                <%
                                    if (listaSedes != null) {
                                        for (Sede s : listaSedes) {
                                %>
                                    <option value="<%= s.getIdSede() %>"><%= s.getNombre() %></option>
                                <%
                                        }
                                    }
                                %>
                            </select>
                        </div>
                    </div>
                    <div class="modal-footer border-secondary">
                        <button type="button" class="btn btn-sm btn-outline-light rounded-pill px-3" data-bs-dismiss="modal">Cancelar</button>
                        <button type="submit" class="btn btn-sm btn-warning fw-bold rounded-pill px-4">Guardar Cambios</button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        document.querySelectorAll('.btn-edit-clase').forEach(btn => {
            btn.addEventListener('click', function() {
                document.getElementById('edit_idClase').value = this.getAttribute('data-id');
                document.getElementById('edit_nombre').value = this.getAttribute('data-nombre');
                document.getElementById('edit_tipo').value = this.getAttribute('data-tipo');
                document.getElementById('edit_instructor').value = this.getAttribute('data-instructor');
                document.getElementById('edit_hora').value = this.getAttribute('data-hora');
                document.getElementById('edit_cupo').value = this.getAttribute('data-cupo');
                document.getElementById('edit_sede').value = this.getAttribute('data-sede');
            });
        });
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    
    <c:if test="${param.msg == 'creada'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({ icon: 'success', title: 'Clase Registrada', text: 'Se ha agregado correctamente a la grilla horaria.', background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700' });
            });
        </script>
    </c:if>
    <c:if test="${param.msg == 'editada'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({ icon: 'success', title: 'Clase Actualizada', text: 'Los cambios se aplicaron exitosamente.', background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700' });
            });
        </script>
    </c:if>
    <c:if test="${param.msg == 'eliminada'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({ icon: 'success', title: 'Clase Eliminada', text: 'El horario ha sido cancelado y removido.', background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700' });
            });
        </script>
    </c:if>
</body>
</html>