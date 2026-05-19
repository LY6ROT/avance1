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
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <section class="estilos_descripcion interactivo-banner">
            <div class="banner-overlay"></div> 
            
            <div class="banner-content container">
                <h1>BIENVENIDO A <span class="resaltado">GYM-MAX</span></h1>
                <p>La red de gimnasios más grande de Lima. Tu transformación empieza hoy.</p>
                <div class="botones-hero">
                    <a href="gimnasios.jsp" class="btn-principal">BUSCAR SEDE</a>
                    <a href="Nosotros.jsp" class="btn-scroll">CONÓCENOS</a> 
                </div>
            </div>
        </section>

        <section class="fondo2">
            <div class="container text-center">
                <h2 class="titulo-seccion mb-5">
                    ¿POR QUÉ ENTRENAR CON NOSOTROS?
                </h2>
                
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

    <div id="miModal" class="modal-fondo">
        <div class="modal-contenido">
            <span class="cerrar-modal">&times;</span>
            
            <div class="promo-header" style="background-image: url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600&auto=format&fit=crop');">
                <div class="promo-overlay">
                    <span class="badge">NUEVA SEDE ATE</span>
                </div>
            </div>

            <div class="promo-body">
                <h2>¡BIENVENIDO A <span class="dorado">GYMMAX</span>!</h2>
                <p>Por ser tu primera vez, aprovecha un 15% de descuento en tu matrícula online.</p>
                
                <div class="codigo-box">
                    <p>Tu código de regalo:</p>
                    <span class="codigo-texto">HOLA2026</span>
                </div>

                <a href="Login.jsp" class="btn-promo">¡EMPEZAR AHORA!</a>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="${pageContext.request.contextPath}/assets/js/pop-up.js"></script>

</body>
</html>