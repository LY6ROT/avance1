<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Panel Administrativo</title>
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
            <li><a href="adminDashboard.jsp" class="active"><i class="fa-solid fa-gauge-high"></i> Dashboard</a></li>
            <li><a href="gestionSocios.jsp"><i class="fa-solid fa-users"></i> Socios</a></li>
            <li><a href="#"><i class="fa-solid fa-location-dot"></i> Sedes</a></li>
            <li><a href="#"><i class="fa-solid fa-award"></i> Membresías</a></li>
            <li><a href="reservarClase.jsp"><i class="fa-regular fa-calendar-days"></i> Clases</a></li>
            <li><a href="#"><i class="fa-solid fa-money-bill-wave"></i> Pagos</a></li>
            <li><a href="reportes.jsp"><i class="fa-solid fa-chart-line"></i> Reportes</a></li>
            
        </ul>

        <div class="admin-logout">
            <ul class="admin-nav">
                <li><a href="Login.jsp"><i class="fa-solid fa-arrow-right-from-bracket"></i> Salir</a></li>
            </ul>
        </div>
    </aside>

    <main class="admin-content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="fw-bold mb-0">Dashboard</h2>
            <div class="text-secondary">
                <i class="fa-solid fa-user-tie me-2"></i> Admin • 19 Abril 2026
            </div>
        </div>

        <div class="row g-4 mb-4">
            <div class="col-md-3">
                <div class="kpi-card">
                    <div class="kpi-title">Socios activos</div>
                    <div class="kpi-value text-warning">1,247</div>
                    <div class="kpi-tendency"><i class="fa-solid fa-arrow-up"></i> +12% este mes</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="kpi-card">
                    <div class="kpi-title">Ingresos del mes</div>
                    <div class="kpi-value">S/ 89,450</div>
                    <div class="kpi-tendency"><i class="fa-solid fa-arrow-up"></i> +8%</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="kpi-card">
                    <div class="kpi-title">Membresías por vencer</div>
                    <div class="kpi-value text-warning">34</div>
                    <div class="kpi-tendency text-secondary">próximos 7 días</div>
                </div>
            </div>
            <div class="col-md-3">
                <div class="kpi-card">
                    <div class="kpi-title">Reservas hoy</div>
                    <div class="kpi-value">182</div>
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
                <div class="admin-table-container h-100">
                    <h6 class="fw-bold mb-4">Actividad reciente</h6>
                    <ul class="list-unstyled mb-0 small">
                        <li class="mb-3"><i class="fa-solid fa-user-plus text-success me-2"></i> Juan López se registró</li>
                        <li class="mb-3"><i class="fa-solid fa-money-check-dollar text-primary me-2"></i> Pago de S/ 99 — Plan Premium</li>
                        <li class="mb-3"><i class="fa-regular fa-calendar-check text-warning me-2"></i> 8 nuevas reservas</li>
                        <li class="mb-0"><i class="fa-solid fa-triangle-exclamation text-danger me-2"></i> 3 membresías vencidas</li>
                    </ul>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>