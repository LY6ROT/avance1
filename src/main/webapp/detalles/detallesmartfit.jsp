<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | SmartFit Detalle</title> 

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalles.css">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
</head>
<body class="bg-dark">
    
    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: linear-gradient(rgba(0,0,0,0.2), rgba(0,0,0,0.8)), url('https://mercadofitness.com/wp-content/uploads/2024/07/smartfit-1.jpg');">
            <div class="img-overlay container text-center d-flex flex-column justify-content-center align-items-center h-100">
                <p class="sede text-warning fw-bold text-uppercase mb-2">Premium Fitness Experience</p>
                <h1 class="display-3 fw-bold text-white" style="font-family: 'Anton';">SMART FIT PURUCHUCO</h1>
            </div>
        </div>

        <div class="container py-5">
            <div class="row g-5">
                <section class="col-lg-8">
                    <div class="descripcion text-white">
                        <h2 class="mb-4" style="font-family: 'Anton'; color: #FFD700;">MÁS DE ENTRENAMIENTO, ES UN ESTILO DE VIDA</h2>
                        <p class="lead text-secondary mb-5">
                            Bienvenido a una experiencia diseñada para maximizar tu rendimiento. En esta sede, 
                            fusionamos tecnología deportiva de vanguardia con un ambiente motivador. 
                            Nuestro enfoque integral garantiza que cada gota de sudor te acerque a tus objetivos 
                            de salud, fuerza y estética.
                        </p>

                        <h3 class="mb-4" style="color: white; font-family: 'Anton'; letter-spacing: 1px;">
                            BENEFICIOS EXCLUSIVOS
                        </h3>
                        
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-dumbbell text-warning fs-3 me-3"></i>
                                    <span>Zona de Pesos Libres de alta gama (mancuernas hasta 50kg).</span>
                                </div>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-heart-pulse text-warning fs-3 me-3"></i>
                                    <span>Área Cardiovascular con monitoreo de frecuencia en tiempo real.</span>
                                </div>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-user-check text-warning fs-3 me-3"></i>
                                    <span>Asesoría personalizada con entrenadores certificados.</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-shower text-warning fs-3 me-3"></i>
                                    <span>Vestidores premium con lockers digitales y duchas privadas.</span>
                                </div>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-bottle-water text-warning fs-3 me-3"></i>
                                    <span>Barra de suplementación y nutrición deportiva.</span>
                                </div>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-bolt text-warning fs-3 me-3"></i>
                                    <span>Clases grupales de alta intensidad (HIIT y Funcional).</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <aside class="col-lg-4">
                    <div class="p-4 rounded-4 shadow-lg sticky-top" style="background: #1a1a1a; top: 100px; border: 1px solid #333;">
                        <h3 class="text-center text-white mb-4" style="font-family: 'Anton';">MEMBRESÍAS DISPONIBLES</h3>
                        
                        <div class="plan-item-card mb-3 p-3 rounded-3 border border-secondary" onclick="seleccionarPlan(this, 'PLAN BLACK', 109.90)" style="cursor: pointer; transition: 0.3s;">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="m-0 fw-bold text-white">PLAN BLACK</p>
                                    <small class="text-secondary">Todas las sedes + 1 invitado</small>
                                </div>
                                <div class="text-warning fw-bold">S/ 109.90</div>
                            </div>
                        </div>

                        <div class="plan-item-card mb-4 p-3 rounded-3 border border-secondary" onclick="seleccionarPlan(this, 'PLAN SMART', 79.90)" style="cursor: pointer; transition: 0.3s;">
                            <div class="d-flex justify-content-between align-items-center">
                                <div>
                                    <p class="m-0 fw-bold text-white">PLAN SMART</p>
                                    <small class="text-secondary">Sede elegida únicamente</small>
                                </div>
                                <div class="text-warning fw-bold">S/ 79.90</div>
                            </div>
                        </div>

                        <button class="btn btn-warning w-100 fw-bold py-3 rounded-pill" id="btnComprar" onclick="mandarAlCarrito()">
                            EMPEZAR MI TRANSFORMACIÓN
                        </button>
                        
                        <p class="text-center text-secondary mt-3 mb-0" style="font-size: 0.8rem;">
                            <i class="fa-solid fa-shield-halved me-1"></i> Pago seguro y encriptado
                        </p>
                    </div>
                </aside>
            </div>
        </div>
    </main>

    <div class="fondo_pie mt-5">
        <footer class="pie container text-center">
            <p>Visita nuestras redes sociales.</p>
            <div class="contenedor-redes d-flex justify-content-center gap-3 mb-3">
                <a href="#" class="text-white fs-4"><i class="fa-brands fa-facebook"></i></a>
                <a href="#" class="text-white fs-4"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
            <p class="copyright text-secondary">© 2026 GymMax. Oliver Torre Escobar - UTP</p>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/carrito.js"></script>

</body>
</html>