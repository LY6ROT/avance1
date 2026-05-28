<%@page import="java.util.Map"%>
<%@page import="com.gymmax.dao.AdminDAO"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<%
    Usuario userAdminCheck = (Usuario) session.getAttribute("usuarioSession");
    if (userAdminCheck == null || !"ADMIN".equals(userAdminCheck.getRol())) {
        response.sendRedirect("Login.jsp");
        return;
    }

    AdminDAO adminDAO = new AdminDAO();
    Map<String, String> stats = adminDAO.obtenerEstadisticasDashboard();
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Reportes y Estadísticas</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/admin.css">
    
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

    <style>
        .panel-blanco { background-color: #ffffff !important; color: #212529 !important; border-radius: 12px; border: 1px solid #e0e0e0; }
        .stat-card { transition: transform 0.2s; border-left: 5px solid #FFD700; }
        .stat-card:hover { transform: translateY(-5px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; }
        .icon-box { width: 48px; height: 48px; display: flex; align-items: center; justify-content: center; border-radius: 12px; font-size: 1.5rem; }
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
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminMembresias"><i class="fa-solid fa-award me-2"></i> Membresías</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminClases"><i class="fa-solid fa-dumbbell me-2"></i> Clases</a></li>
            <li><a class="nav-link text-white" href="${pageContext.request.contextPath}/AdminPagos"><i class="fa-solid fa-money-bill-wave me-2"></i> Pagos</a></li>
            <li><a class="nav-link text-dark bg-warning fw-bold rounded px-3 py-2 shadow-sm" href="${pageContext.request.contextPath}/reportes.jsp"><i class="fa-solid fa-file-invoice me-2"></i> Reportes</a></li>
        </ul>

        <div class="admin-logout mt-auto">
            <ul class="admin-nav">
                <li><a href="${pageContext.request.contextPath}/index.jsp" class="text-white"><i class="fa-solid fa-house me-2"></i> Volver al Menú</a></li>
                <li><a href="${pageContext.request.contextPath}/LogoutController" class="text-danger"><i class="fa-solid fa-arrow-right-from-bracket me-2"></i> Cerrar Sesión</a></li>
            </ul>
        </div>
    </aside>

    <main class="admin-content" style="background-color: #f4f6f9 !important; min-height: 100vh;">
        
        <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4">
            <div>
                <h2 class="fw-bold mb-0" style="color: #212529 !important;">Reportes y Estadísticas</h2>
                <div class="text-secondary small mt-1"><i class="fa-regular fa-calendar me-1"></i> Resumen General de Operaciones</div>
            </div>
            <div class="d-flex gap-2 mt-3 mt-md-0">
                <button class="btn btn-outline-danger fw-bold bg-white text-danger border-danger shadow-sm" onclick="descargarPDF()">
                    <i class="fa-solid fa-file-pdf me-2"></i> Exportar PDF
                </button>
                <button class="btn btn-outline-success fw-bold bg-white text-success border-success shadow-sm" onclick="descargarExcel()">
                    <i class="fa-solid fa-file-excel me-2"></i> Exportar Excel
                </button>
            </div>
        </div>

        <div id="area-imprimir">
            <div class="row g-4 mb-4">
                <div class="col-md-3">
                    <div class="panel-blanco p-3 stat-card shadow-sm h-100 d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-secondary small fw-bold mb-1">INGRESOS DEL MES</p>
                            <h3 class="fw-bold mb-0 text-dark">S/ <%= stats != null ? stats.get("ingresosMes") : "0.00" %></h3>
                        </div>
                        <div class="icon-box bg-success bg-opacity-10 text-success">
                            <i class="fa-solid fa-sack-dollar"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="panel-blanco p-3 stat-card shadow-sm h-100 d-flex align-items-center justify-content-between">
                        <div>
                            <p class="text-secondary small fw-bold mb-1">SOCIOS ACTIVOS</p>
                            <h3 class="fw-bold mb-0 text-dark"><%= stats != null ? stats.get("sociosActivos") : "0" %></h3>
                        </div>
                        <div class="icon-box bg-primary bg-opacity-10 text-primary">
                            <i class="fa-solid fa-users"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="panel-blanco p-3 stat-card shadow-sm h-100 d-flex align-items-center justify-content-between" style="border-left-color: #dc3545;">
                        <div>
                            <p class="text-secondary small fw-bold mb-1">PRÓXIMOS VENCIMIENTOS</p>
                            <h3 class="fw-bold mb-0 text-dark"><%= stats != null ? stats.get("membresiasVencer") : "0" %></h3>
                        </div>
                        <div class="icon-box bg-danger bg-opacity-10 text-danger">
                            <i class="fa-solid fa-triangle-exclamation"></i>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="panel-blanco p-3 stat-card shadow-sm h-100 d-flex align-items-center justify-content-between" style="border-left-color: #0dcaf0;">
                        <div>
                            <p class="text-secondary small fw-bold mb-1">RESERVAS HOY</p>
                            <h3 class="fw-bold mb-0 text-dark"><%= stats != null ? stats.get("reservasHoy") : "0" %></h3>
                        </div>
                        <div class="icon-box bg-info bg-opacity-10 text-info">
                            <i class="fa-solid fa-calendar-check"></i>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row g-4">
                <div class="col-md-8">
                    <div class="panel-blanco p-4 shadow-sm h-100">
                        <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-chart-column me-2 text-secondary"></i> Ingresos vs Gastos (Últimos 6 Meses)</h5>
                        <div style="height: 300px;">
                            <canvas id="barChart"></canvas>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="panel-blanco p-4 shadow-sm h-100 d-flex flex-column">
                        <h5 class="fw-bold text-dark mb-4"><i class="fa-solid fa-chart-pie me-2 text-secondary"></i> Planes Más Vendidos</h5>
                        <div style="flex-grow: 1; display: flex; align-items: center; justify-content: center; height: 250px;">
                            <canvas id="doughnutChart"></canvas>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        document.addEventListener("DOMContentLoaded", function() {
            // GRÁFICO DE BARRAS
            const ctxBar = document.getElementById('barChart').getContext('2d');
            new Chart(ctxBar, {
                type: 'bar',
                data: {
                    labels: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun'],
                    datasets: [{
                        label: 'Ingresos (S/)',
                        data: [4500, 5200, 4800, 6100, 5900, 7200],
                        backgroundColor: '#FFD700',
                        borderRadius: 6,
                        borderWidth: 1,
                        borderColor: '#e5c100'
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { display: false } }, scales: { y: { beginAtZero: true, grid: { borderDash: [4, 4] } }, x: { grid: { display: false } } } }
            });

            // GRÁFICO CIRCULAR
            const ctxDoughnut = document.getElementById('doughnutChart').getContext('2d');
            new Chart(ctxDoughnut, {
                type: 'doughnut',
                data: {
                    labels: ['Basic', 'Premium', 'Anual'],
                    datasets: [{
                        data: [45, 35, 20],
                        backgroundColor: ['#212529', '#FFD700', '#6c757d'],
                        borderWidth: 2,
                        borderColor: '#ffffff'
                    }]
                },
                options: { responsive: true, maintainAspectRatio: false, plugins: { legend: { position: 'bottom', labels: { usePointStyle: true, padding: 20 } } }, cutout: '70%' }
            });
        });

        // ==========================================
        // LÓGICA PARA EXPORTAR PDF
        // ==========================================
        function descargarPDF() {
            Swal.fire({
                title: 'Generando Reporte...',
                text: 'Por favor espera mientras creamos tu PDF.',
                allowOutsideClick: false,
                didOpen: () => { Swal.showLoading(); }
            });

            // Seleccionamos solo el área de los gráficos y tarjetas (evita capturar el menú lateral)
            const elemento = document.getElementById('area-imprimir'); 
            
            const opciones = {
                margin:       10,
                filename:     'Reporte_Estadistico_GymMax.pdf',
                image:        { type: 'jpeg', quality: 0.98 },
                html2canvas:  { scale: 2, useCORS: true },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'landscape' }
            };

            // Ejecuta la librería y guarda el PDF
            html2pdf().set(opciones).from(elemento).save().then(() => {
                Swal.close();
                Swal.fire({ icon: 'success', title: '¡PDF Descargado!', text: 'El reporte se generó exitosamente.', confirmButtonColor: '#FFD700' });
            });
        }

        // ==========================================
        // LÓGICA PARA EXPORTAR EXCEL
        // ==========================================
        function descargarExcel() {
            Swal.fire({
                title: 'Generando Excel...',
                timer: 1000,
                didOpen: () => { Swal.showLoading(); }
            }).then(() => {
                // Preparamos los datos sacados de Java para el Excel
                const datos = [
                    ["Reporte General de Operaciones - GymMax"],
                    ["Fecha de generación:", new Date().toLocaleDateString()],
                    [],
                    ["Métrica", "Valor Reportado"],
                    ["Ingresos del Mes", "S/ <%= stats != null ? stats.get("ingresosMes") : "0.00" %>"],
                    ["Socios Activos", "<%= stats != null ? stats.get("sociosActivos") : "0" %>"],
                    ["Membresías por Vencer", "<%= stats != null ? stats.get("membresiasVencer") : "0" %>"],
                    ["Reservas del Día", "<%= stats != null ? stats.get("reservasHoy") : "0" %>"]
                ];

                // Usamos SheetJS para crear el libro de Excel
                const hoja = XLSX.utils.aoa_to_sheet(datos);
                
                // Darle un poco de ancho a las columnas
                hoja['!cols'] = [{ wch: 30 }, { wch: 20 }];

                const libro = XLSX.utils.book_new();
                XLSX.utils.book_append_sheet(libro, hoja, "Resumen");

                // Generar y descargar el archivo
                XLSX.writeFile(libro, "Reporte_Data_GymMax.xlsx");
            });
        }
    </script>

</body>
</html>