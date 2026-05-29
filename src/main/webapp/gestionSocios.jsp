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
        <style>
            /* REGLAS FUERTES PARA FORZAR EL BLOQUE BLANCO */
            .panel-blanco {
                background-color: #ffffff !important;
                color: #212529 !important;
            }
            .panel-blanco th, .panel-blanco td, .panel-blanco i:not(.fa-magnifying-glass):not(.fa-pen-to-square):not(.fa-trash) {
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
            }
            .input-buscar-blanco {
                background-color: #ffffff !important;
                color: #212529 !important;
                border: 1px solid #ced4da !important;
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
            <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/AdminSocios"><i class="fa-solid fa-users me-2"></i> Socios</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminSedes">
                    <i class="fa-solid fa-location-dot me-2"></i> Sedes</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminMembresias">
                    <i class="fa-solid fa-award me-2"></i> Membresías</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminClases">
                    <i class="fa-solid fa-dumbbell me-2"></i> Clases</a></li>
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
                <h2 class="fw-bold mb-0" style="color: #212529 !important;">Gestión de Socios</h2>
                <div class="text-secondary">
                    <i class="fa-solid fa-user-tie me-2"></i> Administrador
                </div>
            </div>

            <div class="panel-blanco p-4 shadow-sm" style="border-radius: 12px; border: 1px solid #e0e0e0;">

                <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center gap-3 mb-4">
                    <h5 class="fw-bold m-0" style="color: #212529 !important;">
                        <i class="fa-solid fa-users me-2 text-dark"></i>Socios Registrados en el Sistema
                    </h5>

                    <div class="d-flex align-items-center gap-2">
                        <form action="${pageContext.request.contextPath}/AdminSocios" method="GET" class="input-group input-group-sm" style="width: 260px;">
                            <input type="text" name="busqueda" class="form-control input-buscar-blanco shadow-none px-3" placeholder="Buscar socio..." value="${param.busqueda}">
                            <button class="btn btn-dark" type="submit">
                                <i class="fa-solid fa-magnifying-glass text-white"></i>
                            </button>
                            <c:if test="${not empty param.busqueda}">
                                <a href="${pageContext.request.contextPath}/AdminSocios" class="btn btn-outline-danger border-start-0" title="Limpiar búsqueda">
                                    <i class="fa-solid fa-xmark"></i>
                                </a>
                            </c:if>
                        </form>
                        <button type="button" class="btn btn-sm btn-warning fw-bold text-dark px-3 text-nowrap" data-bs-toggle="modal" data-bs-target="#modalNuevoSocio" style="border-radius: 6px; height: 31px;">
                            <i class="fa-solid fa-plus me-1 text-dark"></i> Nuevo Socio
                        </button>
                    </div>
                </div>

                <div class="table-responsive rounded" style="border: 1px solid #dee2e6;">
                    <table class="table align-middle mb-0 panel-blanco">
                        <thead>
                            <tr>
                                <th class="ps-4 fw-bold" style="padding: 12px 8px;">ID Socio</th>
                                <th class="fw-bold" style="padding: 12px 8px;">Nombre Completo</th>
                                <th class="fw-bold" style="padding: 12px 8px;">Correo Electrónico</th>
                                <th class="fw-bold" style="padding: 12px 8px;">Registro</th>
                                <th class="text-center pe-4 fw-bold" style="padding: 12px 8px;">Acciones</th>
                            </tr>
                        </thead>

                        <tbody class="small">
                            <c:choose>
                                <c:when test="${not empty listaSocios}">
                                    <c:forEach var="socio" items="${listaSocios}">
                                        <tr>
                                            <td class="fw-bold ps-4 text-secondary"># ${socio.idUsuario}</td>
                                            <td class="fw-bold text-dark"><c:out value="${socio.nombreCompleto}"/></td>
                                            <td class="text-dark"><c:out value="${socio.correo}"/></td>
                                            <td>
                                                <c:choose>
                                                    <c:when test="${not empty socio.fechaRegistro}">
                                                        <span class="badge border" style="background-color: #d1e7dd !important; color: #0f5132 !important; border-color: #badbcc !important; font-weight: bold;">Activo</span>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="badge border" style="background-color: #f8d7da !important; color: #842029 !important; border-color: #f5c2c7 !important; font-weight: bold;">Inactivo</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </td>
                                            <td class="text-center pe-4">
                                                <button type="button" class="btn btn-sm btn-light border-secondary btn-editar-modal me-1 text-dark" 
                                                        data-bs-toggle="modal" data-bs-target="#modalEditarSocio"
                                                        data-id="${socio.idUsuario}"
                                                        data-nombres="${socio.nombres}"
                                                        data-apellidos="${socio.apellidos}"
                                                        data-correo="${socio.correo}">
                                                    <i class="fa-solid fa-pen-to-square text-dark"></i>
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
                                        <td colspan="5" class="text-center py-5 text-dark">
                                            <i class="fa-solid fa-users-slash fa-3x mb-3" style="color: #adb5bd !important;"></i><br>
                                            <h5 class="fw-bold text-dark">No hay registro de socios</h5>
                                            <p class="small text-secondary">Aún no se ha registrado ningún socio en el sistema.</p>
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

        <div class="modal fade" id="modalNuevoSocio" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content bg-white text-dark border-0 shadow-lg">

                    <div class="modal-header border-bottom">
                        <h5 class="modal-title fw-bold" style="color: #212529;">
                            <i class="fa-solid fa-user-plus me-2 text-warning"></i>
                            Registrar Nuevo Socio
                        </h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>

                    <form action="${pageContext.request.contextPath}/AdminSocios" method="POST">
                        <input type="hidden" name="accion" value="nuevo">

                        <div class="modal-body d-flex flex-column gap-3">
                            <div>
                                <label class="form-label small text-secondary fw-bold">Nombres</label>
                                <input type="text" name="nombres" class="form-control" placeholder="Ej. Juan" required>
                            </div>

                            <div>
                                <label class="form-label small text-secondary fw-bold">Apellidos</label>
                                <input type="text" name="apellidos" class="form-control" placeholder="Ej. Pérez" required>
                            </div>

                            <div>
                                <label class="form-label small text-secondary fw-bold">Correo Electrónico</label>
                                <input type="email" name="correo" class="form-control" placeholder="juan@ejemplo.com" required>
                            </div>

                            <div>
                                <label class="form-label small text-secondary fw-bold">DNI</label>
                                <input type="text" name="dni" class="form-control" placeholder="8 dígitos" pattern="\d{8}" maxlength="8" required>
                            </div>

                            <div>
                                <label class="form-label small text-secondary fw-bold">Contraseña Inicial</label>
                                <input type="password" name="password" class="form-control" placeholder="Asigna una clave temporal" required>
                            </div>
                        </div>

                        <div class="modal-footer border-top bg-light">
                            <button type="button" class="btn btn-sm btn-outline-secondary rounded-pill px-3" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" class="btn btn-sm btn-warning fw-bold text-dark rounded-pill px-4">Registrar Socio</button>
                        </div>
                    </form>

                </div>
            </div>
        </div>

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

        <c:if test="${param.msg == 'registrado'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'success', title: 'Registro Exitoso',
                        text: 'El nuevo socio ha sido registrado en la base de datos.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#FFD700'
                    });
                });
            </script>
        </c:if>
        
        <c:if test="${param.msg == 'error_registro'}">
            <script>
                document.addEventListener("DOMContentLoaded", function () {
                    Swal.fire({
                        icon: 'error', title: 'Error de Registro',
                        text: 'No se pudo crear el socio. Verifica que el DNI o correo no existan ya.',
                        background: '#1a1a1a', color: '#ffffff', confirmButtonColor: '#d33'
                    });
                });
            </script>
        </c:if>
    </body>
</html>