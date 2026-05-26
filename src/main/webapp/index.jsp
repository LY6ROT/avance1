<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Entrena al Máximo</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    
    <style>
        /* Ajustes específicos para que el carrusel de Bootstrap mantenga tu estilo oscuro */
        .carousel-item {
            height: calc(100vh - 76px);
            background-color: #000;
        }
        .carousel-item img {
            object-fit: cover;
            height: 100%;
            width: 100%;
            opacity: 0.6; /* Oscurece la imagen para que resalte el texto */
        }
        .carousel-caption {
            bottom: 30%;
            z-index: 10;
        }
        .carousel-caption h1 {
            font-family: 'Anton', sans-serif;
            font-size: 4.5rem;
            text-transform: uppercase;
            text-shadow: 2px 2px 15px rgba(0,0,0,0.9);
        }
        .carousel-caption p {
            font-size: 1.5rem;
            text-shadow: 1px 1px 10px rgba(0,0,0,0.9);
        }
    </style>
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div id="heroCarousel" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#heroCarousel" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>
            
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=2070&auto=format&fit=crop" class="d-block w-100" alt="Gimnasio">
                    <div class="carousel-caption d-none d-md-block">
                        <h1>BIENVENIDO A <span class="resaltado">GYM-MAX</span></h1>
                        <p>La red de gimnasios más grande de Lima. Tu transformación empieza hoy.</p>
                        <div class="botones-hero mt-4">
                            <a href="${pageContext.request.contextPath}/SedesServlet" class="btn btn-warning fw-bold rounded-pill">Buscar Sede</a>
                            <a href="Nosotros.jsp" class="btn-scroll">CONÓCENOS</a> 
                        </div>
                    </div>
                </div>
                
                <div class="carousel-item">
                    <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop" class="d-block w-100" alt="Entrenamiento">
                    <div class="carousel-caption d-none d-md-block">
                        <h1>ENTRENA SIN <span class="resaltado">LÍMITES</span></h1>
                        <p>Accede a más de 20 sedes con tu misma membresía.</p>
                        <div class="botones-hero mt-4">
                            <a href="registro.jsp" class="btn-principal">ÚNETE AHORA</a>
                        </div>
                    </div>
                </div>

                <div class="carousel-item">
                    <img src="https://images.unsplash.com/photo-1581009146145-b5ef050c2e1e?q=80&w=2070&auto=format&fit=crop" class="d-block w-100" alt="Pesas">
                    <div class="carousel-caption d-none d-md-block">
                        <h1>EQUIPAMIENTO <span class="resaltado">PREMIUM</span></h1>
                        <p>Maquinaria de última generación para mejores resultados.</p>
                        <div class="botones-hero mt-4">
                            <a href="gimnasios.jsp" class="btn-scroll">VER CLASES</a>
                        </div>
                    </div>
                </div>
            </div>
            
            <button class="carousel-control-prev" type="button" data-bs-target="#heroCarousel" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Anterior</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#heroCarousel" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Siguiente</span>
            </button>
        </div>
        <section class="fondo2">
            <div class="container text-center">
                <h2 class="titulo-seccion mb-5">¿POR QUÉ ENTRENAR CON NOSOTROS?</h2>
                
                <div class="row g-4 mt-2">
                    <div class="col-md-4">
                        <div class="item-info">
                            <i class="fa-solid fa-location-dot fa-4x mb-4"></i>
                            <h3 class="pf_titulo">MÁS DE 20 SEDES</h3>
                            <p class="parrafo_1 mb-0">Cerca de tu casa o trabajo en todo Lima.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="item-info">
                            <i class="fa-solid fa-dumbbell fa-4x mb-4"></i>
                            <h3 class="pf_titulo">EQUIPOS PRO</h3>
                            <p class="parrafo_1 mb-0">Maquinaria de última generación para mejores resultados.</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="item-info">
                            <i class="fa-solid fa-clock fa-4x mb-4"></i>
                            <h3 class="pf_titulo">HORARIOS FLEXIBLES</h3>
                            <p class="parrafo_1 mb-0">Entrena desde las 5:00 AM hasta las 11:00 PM.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <footer class="fondo_pie">
        <div class="container">
            <p class="text-white mb-2">Visita nuestras redes sociales.</p>
            <div class="contenedor-redes">
                <a href="https://www.facebook.com/" target="_blank"><i class="fa-brands fa-facebook"></i></a>
                <a href="https://www.whatsapp.com/" target="_blank"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
            <p class="copyright">© 2026 GymMax. Todos los derechos reservados. | Oliver Torre Escobar - UTP</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/pop-up.js"></script>

</body>
</html>