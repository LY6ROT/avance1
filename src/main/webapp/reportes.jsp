<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Reportes del Sistema</title>
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
            <li><a href="gestionSocios.jsp"><i class="fa-solid fa-users"></i> Socios</a></li>
            <li><a href="#"><i class="fa-solid fa-location-dot"></i> Sedes</a></li>
            <li><a href="#"><i class="fa-solid fa-award"></i> Membresías</a></li>
            <li><a href="#"><i class="fa-regular fa-calendar-days"></i> Clases</a></li>
            <li><a href="#"><i class="fa-solid fa-money-bill-wave"></i> Pagos</a></li>
            <li><a href="reportes.jsp" class="active"><i class="fa-solid fa-chart-line"></i> Reportes</a></li>
        
        </ul>

        <div class="admin-logout">
            <ul class="admin-nav">
                <li><a href="Login.jsp"><i class="fa-solid fa-arrow-right-from-bracket"></i> Salir</a></li>
            </ul>
        </div>
    </aside>

    <main class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Generación de reportes</h2>
            <div>
                <button class="btn btn-outline-success fw-bold btn-sm me-2 px-3"><i class="fa-solid fa-file-excel me-2"></i> Excel</button>
                <button class="btn btn-outline-danger fw-bold btn-sm px-3"><i class="fa-solid fa-file-pdf me-2"></i> PDF</button>
            </div>
        </div>

        <div class="admin-table-container mb-4">
            <form action="#" method="POST" class="row g-3 align-items-end">
                <div class="col-md-3">
                    <label class="form-label small text-secondary">Tipo de reporte</label>
                    <select class="form-select">
                        <option>Ingresos por sede</option>
                        <option>Asistencias por horario</option>
                        <option>Nuevos socios registrados</option>
                    </select>
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-secondary">Desde</label>
                    <input type="date" class="form-control" value="2026-03-01">
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-secondary">Hasta</label>
                    <input type="date" class="form-control" value="2026-04-19">
                </div>
                <div class="col-md-2">
                    <label class="form-label small text-secondary">Sede</label>
                    <select class="form-select">
                        <option>Todas</option>
                        <option>Miraflores</option>
                        <option>San Isidro</option>
                        <option>Surco</option>
                        <option>Lince</option>
                    </select>
                </div>
                <div class="col-md-3">
                    <button type="submit" class="btn btn-warning fw-bold text-dark px-4 me-2"><i class="fa-solid fa-chart-bar me-2"></i> Generar</button>
                    <button type="reset" class="btn btn-light border">Resetear</button>
                </div>
            </form>
        </div>

        <div class="row g-4">
            <div class="col-md-6">
                <div class="admin-table-container h-100">
                    <h6 class="fw-bold mb-4">Ingresos por sede (mar-abr 2026)</h6>
                    <div class="d-flex align-items-end justify-content-around pt-5 px-2 border-bottom" style="height: 220px;">
                        <div class="text-center w-100">
                            <span class="small text-secondary d-block mb-1">S/28,500</span>
                            <div class="mx-auto" style="height: 140px; width: 45px; background-color: #f97316; border-radius: 4px 4px 0 0;"></div>
                        </div>
                        <div class="text-center w-100">
                            <span class="small text-secondary d-block mb-1">S/21,200</span>
                            <div class="mx-auto" style="height: 105px; width: 45px; background-color: #3b82f6; border-radius: 4px 4px 0 0;"></div>
                        </div>
                        <div class="text-center w-100">
                            <span class="small text-secondary d-block mb-1">S/31,800</span>
                            <div class="mx-auto" style="height: 160px; width: 45px; background-color: #10b981; border-radius: 4px 4px 0 0;"></div>
                        </div>
                        <div class="text-center w-100">
                            <span class="small text-secondary d-block mb-1">S/15,200</span>
                            <div class="mx-auto" style="height: 75px; width: 45px; background-color: #ef4444; border-radius: 4px 4px 0 0;"></div>
                        </div>
                    </div>
                    <div class="d-flex justify-content-around text-center mt-2 text-secondary small fw-bold">
                        <div class="w-100">Miraflores</div>
                        <div class="w-100">San Isidro</div>
                        <div class="w-100">Surco</div>
                        <div class="w-100">Lince</div>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="admin-table-container h-100">
                    <h6 class="fw-bold mb-4">Resumen numérico</h6>
                    <div class="table-responsive">
                        <table class="table table-bordered table-striped mb-0">
                            <thead class="table-dark">
                                <tr>
                                    <th>Sede</th>
                                    <th class="text-center">Socios</th>
                                    <th class="text-end">Ingresos</th>
                                    <th class="text-end">% total</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td>Miraflores</td>
                                    <td class="text-center">412</td>
                                    <td class="text-end">S/ 28,500</td>
                                    <td class="text-end text-secondary">29.8%</td>
                                </tr>
                                <tr>
                                    <td>San Isidro</td>
                                    <td class="text-center">315</td>
                                    <td class="text-end">S/ 21,200</td>
                                    <td class="text-end text-secondary">22.1%</td>
                                </tr>
                                <tr>
                                    <td>Surco</td>
                                    <td class="text-center">378</td>
                                    <td class="text-end">S/ 31,800</td>
                                    <td class="text-end text-secondary">33.2%</td>
                                </tr>
                                <tr>
                                    <td>Lince</td>
                                    <td class="text-center">142</td>
                                    <td class="text-end">S/ 15,200</td>
                                    <td class="text-end text-secondary">14.9%</td>
                                </tr>
                                <tr class="table-dark fw-bold">
                                    <td>TOTAL</td>
                                    <td class="text-center">1,247</td>
                                    <td class="text-end" style="color: #FFD700;">S/ 96,700</td>
                                    <td class="text-end" style="color: #FFD700;">100%</td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>