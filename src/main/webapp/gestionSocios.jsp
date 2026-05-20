<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
            <li><a href="gestionSocios.jsp" class="active"><i class="fa-solid fa-users"></i> Socios</a></li>
            <li><a href="#"><i class="fa-solid fa-location-dot"></i> Sedes</a></li>
            <li><a href="#"><i class="fa-solid fa-award"></i> Membresías</a></li>
            <li><a href="#"><i class="fa-regular fa-calendar-days"></i> Clases</a></li>
            <li><a href="#"><i class="fa-solid fa-money-bill-wave"></i> Pagos</a></li>
            <li><a href="#"><i class="fa-solid fa-chart-line"></i> Reportes</a></li>
        </ul>

        <div class="admin-logout">
            <ul class="admin-nav">
                <li><a href="Login.jsp"><i class="fa-solid fa-arrow-right-from-bracket"></i> Salir</a></li>
            </ul>
        </div>
    </aside>

    <main class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Gestión de socios</h2>
            <button class="btn btn-warning fw-bold text-dark"><i class="fa-solid fa-circle-plus me-2"></i> Nuevo socio</button>
        </div>

        <div class="admin-table-container">
            <div class="row g-3 mb-4 align-items-end">
                <div class="col-md-3">
                    <label class="form-label small text-secondary">Buscar</label>
                    <input type="text" class="form-control" placeholder="Nombre, DNI, correo...">
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-secondary">Sede</label>
                    <select class="form-select">
                        <option>Todas</option>
                        <option>Miraflores</option>
                        <option>San Isidro</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-secondary">Plan</label>
                    <select class="form-select">
                        <option>Todos</option>
                        <option>Básico</option>
                        <option>Premium</option>
                        <option>Anual</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-secondary">Estado</label>
                    <select class="form-select">
                        <option>Todos</option>
                        <option>Activo</option>
                        <option>Por vencer</option>
                        <option>Vencido</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button class="btn btn-primary px-4 me-2"><i class="fa-solid fa-filter me-2"></i> Filtrar</button>
                    <button class="btn btn-light border">Limpiar</button>
                </div>
            </div>

            <div class="table-responsive">
                <table class="table table-hover border">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Nombre completo</th>
                            <th>DNI</th>
                            <th>Correo</th>
                            <th>Plan</th>
                            <th>Sede</th>
                            <th>Estado</th>
                            <th>Vencimiento</th>
                            <th class="text-center">Acciones</th>
                        </tr>
                    </thead>
                    <tbody class="small">
                        <tr>
                            <td class="text-secondary">S-1001</td>
                            <td class="fw-bold">Dennys Marlon Purizaca I.</td>
                            <td>72345678</td>
                            <td>dennys@mail.com</td>
                            <td>Premium</td>
                            <td>Miraflores</td>
                            <td><span class="badge bg-success badge-estado">Activo</span></td>
                            <td>30/11/2026</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary py-0 px-2 me-1"><i class="fa-solid fa-pen"></i></button>
                                <button class="btn btn-sm btn-outline-danger py-0 px-2"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-secondary">S-1002</td>
                            <td class="fw-bold">Niurka Choque Anchante</td>
                            <td>74569812</td>
                            <td>niurka@mail.com</td>
                            <td>Anual</td>
                            <td>San Isidro</td>
                            <td><span class="badge bg-success badge-estado">Activo</span></td>
                            <td>15/09/2026</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary py-0 px-2 me-1"><i class="fa-solid fa-pen"></i></button>
                                <button class="btn btn-sm btn-outline-danger py-0 px-2"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-secondary">S-1003</td>
                            <td class="fw-bold">Ian Soria Chavez</td>
                            <td>76123495</td>
                            <td>ian@mail.com</td>
                            <td>Básico</td>
                            <td>Surco</td>
                            <td><span class="badge bg-warning text-dark badge-estado">Por vencer</span></td>
                            <td>30/04/2026</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary py-0 px-2 me-1"><i class="fa-solid fa-pen"></i></button>
                                <button class="btn btn-sm btn-outline-danger py-0 px-2"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>
                        <tr>
                            <td class="text-secondary">S-1004</td>
                            <td class="fw-bold">Oliver Torre Escobar</td>
                            <td>75239478</td>
                            <td>oliver@mail.com</td>
                            <td>Premium</td>
                            <td>Lince</td>
                            <td><span class="badge bg-danger badge-estado">Vencido</span></td>
                            <td>05/04/2026</td>
                            <td class="text-center">
                                <button class="btn btn-sm btn-outline-primary py-0 px-2 me-1"><i class="fa-solid fa-pen"></i></button>
                                <button class="btn btn-sm btn-outline-danger py-0 px-2"><i class="fa-solid fa-trash"></i></button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            
            <nav aria-label="Page navigation" class="mt-4">
              <ul class="pagination justify-content-end mb-0">
                <li class="page-item disabled"><a class="page-link" href="#">«</a></li>
                <li class="page-item active"><a class="page-link" href="#">1</a></li>
                <li class="page-item"><a class="page-link" href="#">2</a></li>
                <li class="page-item"><a class="page-link" href="#">3</a></li>
                <li class="page-item"><a class="page-link" href="#">»</a></li>
              </ul>
            </nav>

        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>