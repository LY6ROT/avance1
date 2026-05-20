<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Reservar Clase</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/dashboard.css">
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-4" style="max-width: 500px;">
        
        <div class="d-flex align-items-center mb-4">
            <a href="dashboardSocio.jsp" class="text-white text-decoration-none me-3 fs-5"><i class="fa-solid fa-arrow-left"></i></a>
            <h4 class="mb-0 fw-bold text-warning">Reservar clase</h4>
        </div>

        <div class="alert bg-black border border-warning text-white mb-4 shadow-sm" role="alert">
            <h6 class="fw-bold text-warning mb-1"><i class="fa-solid fa-circle-info me-2"></i> Política de Sedes</h6>
            <p class="small mb-2">Tu sede principal es <strong>Lima Centro</strong>. Tienes un límite para tomar clases en otras sedes.</p>
            <div class="d-flex justify-content-between align-items-center bg-dark p-2 rounded">
                <span class="small text-secondary">Cambios disponibles este mes:</span>
                <span class="badge bg-warning text-dark fs-6">2 / 3</span>
            </div>
        </div>

        <form action="#" method="POST" class="mb-4">
            <div class="mb-3">
                <label class="form-label small text-secondary">Seleccionar Sede</label>
                <select class="form-select bg-dark text-white border-secondary shadow-none">
                    <option value="1">Lima Centro (Sede Principal)</option>
                    <option value="2">Sede Miraflores (Gasto de cupo)</option>
                    <option value="3">Sede San Isidro (Gasto de cupo)</option>
                    <option value="4">Sede Surco (Gasto de cupo)</option>
                </select>
            </div>

            <div class="mb-4">
                <label class="form-label small text-secondary">Fecha</label>
                <input type="date" class="form-control bg-dark text-white border-secondary shadow-none" value="2026-05-20">
            </div>
        </form>

        <h6 class="fw-bold mb-3">Clases disponibles</h6>
        
        <div class="d-flex flex-column gap-3">
            <div class="card bg-dark border-secondary clase-card">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1">CrossFit</h6>
                        <p class="small text-secondary mb-1">18:00 • Prof. Carlos M.</p>
                        <span class="badge bg-success">10/15 cupos</span>
                    </div>
                    <button class="btn btn-warning fw-bold btn-sm px-3 rounded-pill">Reservar</button>
                </div>
            </div>

            <div class="card bg-dark border-secondary clase-card opacity-75">
                <div class="card-body d-flex justify-content-between align-items-center">
                    <div>
                        <h6 class="fw-bold mb-1">Spinning</h6>
                        <p class="small text-secondary mb-1">20:00 • Prof. Luis P.</p>
                        <span class="badge bg-danger">15/15 lleno</span>
                    </div>
                    <button class="btn btn-secondary fw-bold btn-sm px-3 rounded-pill" disabled>Sin cupos</button>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>