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
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminDashboard">
                        <i class="fa-solid fa-chart-line me-2"></i> Panel de Control</a></li>
                <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSocios">
                        <i class="fa-solid fa-users me-2"></i> Gestión de Socios </a></li>
                <li><a href="#"><i class="fa-solid fa-location-dot"></i> Sedes</a></li>
                <li><a href="#"><i class="fa-solid fa-award"></i> Membresías</a></li>
                <li><a href="${pageContext.request.contextPath}/AdminClases" class="nav-link text-white rounded px-3 py-2 btn-outline-secondary text-start"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a></li>
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
                        <thead class="table-secondary text-dark">
                            <tr>
                                <th class="ps-4">ID Socio</th>
                                <th>Nombre Completo</th>
                                <th>Correo Electrónico</th>
                                <th>Estado</th>
                                <th class="text-center pe-4">Acciones</th>
                            </tr>
                        </thead>

                        <tbody class="small">
                            <c:choose>
                                <c:when test="${not empty listaSocios}">
                                    <c:forEach var="socio" items="${listaSocios}">
                                        <tr>
                                            <td class="text-secondary fw-bold ps-4"># ${socio.idUsuario}</td>
                                            <td class="fw-bold"><c:out value="${socio.nombreCompleto}"/></td>

                                            <td><c:out value="${socio.correo}"/></td>

                                            <td><span class="badge bg-dark text-warning border border-warning"><c:out value="${socio.fechaRegistro}"/></span></td>

                                            <td class="text-center pe-4">
                                                <button type="button" class="btn btn-sm btn-outline-warning btn-editar-modal" 
                                                        data-bs-toggle="modal" data-bs-target="#modalEditarSocio"
                                                        data-id="${socio.idUsuario}"
                                                        data-nombres="${socio.nombres}"
                                                        data-apellidos="${socio.apellidos}"
                                                        data-correo="${socio.correo}">
                                                    <i class="fa-solid fa-pen-to-square"></i>
                                                </button>

                                                <form action="${pageContext.request.contextPath}/AdminSocios" method="POST" class="d-inline" onsubmit="return confirm('¿Estás absolutamente seguro de eliminar a este socio del gimnasio?');">
                                                    <input type="hidden" name="accion" value="eliminar">
                                                    <input type="hidden" name="idSocio" value="${socio.idSocio}">
                                                    <button type="submit" class="btn btn-sm btn-outline-danger" title="Eliminar Socio">
                                                        <i class="fa-solid fa-trash"></i>
                                                    </button>
                                                </form>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>

                                <c:otherwise>
                                    <tr>
                                        <td colspan="5" class="text-center text-secondary py-5">
                                            <i class="fa-solid fa-users-slash fa-3x mb-3"></i><br>
                                            <h5 class="fw-bold">No hay registro de socios</h5>
                                            <p class="small">Aún no se ha registrado ningún socio en el sistema.</p>
                                        </td>
                                    </tr>
                                </c:otherwise>
                            </c:choose>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

        <c:if test="${param.msg == 'eliminado'}">
            <script>
                                                        document.addEventListener("DOMContentLoaded", function () {
                                                            Swal.fire({
                                                                icon: 'success', title: 'Socio Eliminado',
                                                                text: 'El registro se ha borrado exitosamente del sistema.',
                                                                background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700'
                                                            });
                                                        });
            </script>
        </c:if>

        <c:if test="${param.msg == 'error_fk'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'error', title: 'Acción Denegada',
                        text: 'No se puede eliminar a este socio porque tiene pagos o reservas registradas en el sistema.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#d33'
                    });
                });
            </script>
        </c:if>
        <!-- MODAL EDITAR SOCIO -->
        <!-- MODAL EDITAR SOCIO -->
        <div class="modal fade" id="modalEditarSocio" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-dark text-white border-warning">

                    <div class="modal-header border-secondary">
                        <h5 class="modal-title text-warning fw-bold">
                            <i class="fa-solid fa-user-pen me-2"></i>
                            Editar Información del Socio
                        </h5>

                        <button type="button"
                                class="btn-close btn-close-white"
                                data-bs-dismiss="modal"
                                aria-label="Close">
                        </button>
                    </div>

                    <form action="${pageContext.request.contextPath}/AdminSocios"
                          method="POST">

                        <input type="hidden" name="accion" value="editar">
                        <input type="hidden" name="idUsuario" id="edit_idUsuario">

                        <div class="modal-body d-flex flex-column gap-3">

                            <div>
                                <label class="form-label small text-secondary fw-bold">
                                    Nombres
                                </label>

                                <input type="text"
                                       name="nombres"
                                       id="edit_nombres"
                                       class="form-control bg-black text-white border-secondary"
                                       required>
                            </div>

                            <div>
                                <label class="form-label small text-secondary fw-bold">
                                    Apellidos
                                </label>

                                <input type="text"
                                       name="apellidos"
                                       id="edit_apellidos"
                                       class="form-control bg-black text-white border-secondary"
                                       required>
                            </div>

                            <div>
                                <label class="form-label small text-secondary fw-bold">
                                    Correo Electrónico
                                </label>

                                <input type="email"
                                       name="correo"
                                       id="edit_correo"
                                       class="form-control bg-black text-white border-secondary"
                                       required>
                            </div>

                        </div>

                        <div class="modal-footer border-secondary">

                            <button type="button"
                                    class="btn btn-sm btn-outline-light rounded-pill px-3"
                                    data-bs-dismiss="modal">
                                Cancelar
                            </button>

                            <button type="submit"
                                    class="btn btn-sm btn-warning fw-bold rounded-pill px-4">
                                Guardar Cambios
                            </button>

                        </div>

                    </form>

                </div>
            </div>
        </div>

        <!-- SCRIPT PARA RELLENAR EL MODAL -->
        <script>
            document.querySelectorAll('.btn-editar-modal').forEach(button => {
                button.addEventListener('click', function () {
                    document.getElementById('edit_idUsuario').value = this.getAttribute('data-id');
                    document.getElementById('edit_nombres').value = this.getAttribute('data-nombres');
                    document.getElementById('edit_apellidos').value = this.getAttribute('data-apellidos');
                    document.getElementById('edit_correo').value = this.getAttribute('data-correo');
                });
            });
        </script>

        <!-- ALERTA EDITADO -->
        <c:if test="${param.msg == 'editado'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    Swal.fire({
                        icon: 'success',
                        title: 'Socio Actualizado',
                        text: 'Los datos fueron guardados exitosamente.',
                        background: '#1a1a1a',
                        color: '#ffffff',
                        confirmButtonColor: '#FFD700'
                    });

                });
            </script>
        </c:if>

        <!-- ALERTA ERROR -->
        <c:if test="${param.msg == 'error_edit'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {

                    Swal.fire({
                        icon: 'error',
                        title: 'Error',
                        text: 'No se pudo actualizar la información.',
                        background: '#1a1a1a',
                        color: '#ffffff',
                        confirmButtonColor: '#d33'
                    });

                });
            </script>
        </c:if>
    </body>
</html>