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
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container-fluid py-5 mt-5 px-lg-5">
        <div class="row g-4">
            
            <div class="col-md-2">
                <div class="bg-black p-3 rounded-4 border border-secondary h-100 shadow-lg">
                    <h5 class="text-warning fw-bold mb-4 text-center" style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">PANEL ADMIN</h5>
                    <ul class="nav flex-column gap-2 admin-nav">
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/AdminDashboard" class="nav-link text-white rounded px-3 py-2 btn-outline-secondary text-start"><i class="fa-solid fa-chart-line me-2"></i> Panel de Control</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/AdminSocios" class="nav-link text-white rounded px-3 py-2 btn-outline-secondary text-start"><i class="fa-solid fa-users me-2"></i> Socios</a>
                        </li>
                        <li class="nav-item">
                            <a href="${pageContext.request.contextPath}/AdminClases" class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a>
                        </li>
                    </ul>
                </div>
            </div>

            <div class="col-md-10">
                <div class="d-flex flex-column flex-md-row justify-content-between align-items-center mb-4">
                    <div class="d-flex align-items-center">
                        <a href="${pageContext.request.contextPath}/AdminDashboard" class="text-warning text-decoration-none me-3 fs-3" style="transition: transform 0.2s;" onmouseover="this.style.transform='scale(1.1)'" onmouseout="this.style.transform='scale(1)'">
                            <i class="fa-solid fa-circle-arrow-left"></i>
                        </a>
                        <h2 style="font-family: 'Anton', sans-serif; letter-spacing: 1px; margin-bottom: 0;">GESTIÓN DE <span class="text-warning">CLASES</span></h2>
                    </div>
                    <button type="button" class="btn btn-warning text-dark fw-bold mt-3 mt-md-0 shadow" data-bs-toggle="modal" data-bs-target="#modalNuevaClase">
                        <i class="fa-solid fa-plus me-2"></i> Nueva Clase
                    </button>
                </div>

                <div class="card bg-black border-secondary shadow-lg rounded-4 overflow-hidden">
                    <div class="card-body p-0 table-responsive">
                        <table class="table table-dark table-hover mb-0 align-middle" style="min-width: 900px;">
                            <thead class="table-secondary text-dark">
                                <tr>
                                    <th class="ps-4">ID</th>
                                    <th>Sede</th>
                                    <th>Nombre / Disciplina</th>
                                    <th>Instructor</th>
                                    <th>Hora Inicio</th>
                                    <th>Cupo Max.</th>
                                    <th>Estado</th>
                                    <th class="text-center pe-4">Acciones</th>
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
                                        <td class="text-secondary ps-4">C-<%= String.format("%04d", c.getIdClase()) %></td>
                                        <td><span class="badge bg-dark border border-secondary text-light"><i class="fa-solid fa-location-dot me-1 text-warning"></i> <%= nombreSede %></span></td>
                                        <td class="fw-bold"><%= c.getNombre() %> <span class="badge bg-secondary ms-2" style="font-size: 0.65rem;"><%= c.getTipo() %></span></td>
                                        <td><i class="fa-solid fa-user-tie text-secondary me-2"></i><%= c.getInstructor() %></td>
                                        <td class="text-warning fw-bold"><i class="fa-solid fa-clock me-1"></i> <%= c.getHoraInicio() != null ? c.getHoraInicio().toString().substring(0, 5) : "--:--" %></td>
                                        <td><%= c.getCupoMaximo() %> pax</td>
                                        <td><span class="badge bg-success">Activa</span></td>
                                        <td class="text-center pe-4">
                                            <button type="button" class="btn btn-sm btn-outline-warning py-1 px-2 me-1 rounded-3 btn-edit-clase"
                                                    data-bs-toggle="modal" data-bs-target="#modalEditarClase"
                                                    data-id="<%= c.getIdClase() %>"
                                                    data-nombre="<%= c.getNombre() %>"
                                                    data-tipo="<%= c.getTipo() %>"
                                                    data-instructor="<%= c.getInstructor() %>"
                                                    data-hora="<%= c.getHoraInicio() != null ? c.getHoraInicio().toString().substring(0,5) : "" %>"
                                                    data-cupo="<%= c.getCupoMaximo() %>"
                                                    data-sede="<%= c.getIdSede() %>">
                                                <i class="fa-solid fa-pen"></i>
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
                                        <td colspan="8" class="text-center py-5 text-secondary">
                                            <i class="fa-solid fa-calendar-xmark fa-3x mb-3 d-block text-muted"></i>
                                            <h5>No hay clases programadas</h5>
                                        </td>
                                    </tr>
                                <%
                                    }
                                %>
                            </tbody>
                        </table>
                    </div>
                </div>
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