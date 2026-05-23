<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>GymMax | Detalle SmartFit</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
</head>
<body class="bg-dark text-white">

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-5">
        <h1 class="text-warning">SMART FIT PURUCHUCO</h1>
        <hr>
        
        <div class="row mt-4">
            <div class="col-md-8">
                <h3>Detalle de la Sede</h3>
                <p>Sede premium con infraestructura de alta gama...</p>
            </div>

            <div class="col-md-4">
                <div class="card bg-secondary text-white p-3">
                    <h4>PLANES DISPONIBLES</h4>
                    
                    <div class="mb-3 border p-2">
                        <p><strong>PLAN BLACK</strong> - S/ 149.90</p>
                        <a href="${pageContext.request.contextPath}/Carrito?accion=agregar&idPlan=2" 
                           class="btn btn-warning w-100">AÑADIR AL CARRITO</a>
                    </div>

                    <div class="mb-3 border p-2">
                        <p><strong>PLAN SMART</strong> - S/ 89.90</p>
                        <a href="${pageContext.request.contextPath}/Carrito?accion=agregar&idPlan=1" 
                           class="btn btn-light w-100">AÑADIR AL CARRITO</a>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>