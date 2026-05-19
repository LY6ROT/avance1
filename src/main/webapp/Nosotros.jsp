<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Nosotros</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
</head>
<body>

    <%@include file="WEB-INF/fragments/header.jsp" %>

    <main>
        <section class="estilos_descripcion interactivo-banner" style="height: 45vh;">
            <style>
                .interactivo-banner::before { background-image: url('https://images.unsplash.com/photo-1540496905036-5937c10647cc?q=80&w=2070&auto=format&fit=crop'); }
            </style>
            <div class="banner-overlay"></div>
            <div class="banner-content container text-center">
                <h1 style="font-size: 3.5rem;">CONOCE EL <span class="resaltado">OLIMPO</span></h1>
                <p>Más que un gimnasio, somos una comunidad dedicada a forjar la mejor versión de ti.</p>
            </div>
        </section>

        <section class="fondo2 pt-5">
            <div class="container">
                <div class="row align-items-center mb-5 pb-5 border-bottom border-dark">
                    <div class="col-lg-6 mb-4 mb-lg-0 pr-lg-5">
                        <h2 class="titulo-seccion mb-4" style="font-size: 2.2rem; border-bottom: none; display: block;">
                            FORJANDO <span style="color: white;">LEYENDAS DESDE EL 2024</span>
                        </h2>
                        <p class="parrafo_1" style="font-size: 1.1rem;">
                            GymMax nació de una necesidad clara: ofrecer a los limeños un espacio de entrenamiento que combinara tecnología de punta con una asesoría humana real. No solo alquilamos máquinas, construimos disciplina.
                        </p>
                        <p class="parrafo_1" style="font-size: 1.1rem;">
                            Hoy en día, somos la cadena de mayor crecimiento en el país, impulsados por un equipo de ingenieros y entrenadores que optimizan tu rendimiento al máximo.
                        </p>
                    </div>
                    <div class="col-lg-6">
                        <div class="imagen-nosotros-wrapper">
                            <img src="https://images.unsplash.com/photo-1571019614242-c5c5dee9f50b?q=80&w=2070&auto=format&fit=crop" alt="Entrenamiento GymMax" class="img-fluid rounded-4 shadow-lg border border-warning" style="border-width: 2px !important;">
                        </div>
                    </div>
                </div>

                <div class="row g-4 mt-2 mb-5 pb-4">
                    <div class="col-md-6">
                        <div class="item-info h-100 text-center">
                            <i class="fa-solid fa-bullseye fa-3x mb-3 text-warning"></i>
                            <h3 class="pf_titulo text-white">NUESTRA MISIÓN</h3>
                            <p class="parrafo_1">Democratizar el acceso al fitness de élite, brindando instalaciones premium y planes personalizados a precios accesibles para toda la comunidad.</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="item-info h-100 text-center">
                            <i class="fa-solid fa-eye fa-3x mb-3 text-warning"></i>
                            <h3 class="pf_titulo text-white">NUESTRA VISIÓN</h3>
                            <p class="parrafo_1">Ser reconocidos al 2030 como la red de salud y acondicionamiento físico número uno de Sudamérica, integrando inteligencia artificial en cada rutina.</p>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="fondo2" style="background-color: #050505; padding-top: 40px;">
            <div class="container text-center">
                <h2 class="titulo-seccion mb-5">LÍDERES GYMMAX</h2>
                
                <div class="row justify-content-center g-4">
                    <div class="col-md-4">
                        <div class="equipo-card">
                            <div class="equipo-img-container">
                                <img src="https://scontent-lim1-1.xx.fbcdn.net/v/t39.30808-1/505586514_4083602051920948_1622992285524663566_n.jpg?stp=c0.0.869.869a_dst-jpg_s200x200_tt6&_nc_cat=102&ccb=1-7&_nc_sid=1d2534&_nc_eui2=AeHNXJOpbK7Wly8wF_dW6OvBMbtKlYaqPcQxu0qVhqo9xJFO3tBk9AwAQMlVnPUiEvX4uyd1JC5I8msbsNX3EThE&_nc_ohc=mvAy1WmvdUUQ7kNvwHAQsJE&_nc_oc=AdpPHAb1bR8vonzWgpkDw7aTo5mspqU_QV5Pj848hLltBStXe1jcfh09KESgtMv-Qwk&_nc_zt=24&_nc_ht=scontent-lim1-1.xx&_nc_gid=QUwMr7CQrfUHxw1TIOK7Lw&_nc_ss=7a3a8&oh=00_Af06KZEOeJcRMnTSnMf8BvkpAYblCswek-gnljjrcmMh8g&oe=69E62487" alt="Oliver Torre" class="equipo-img">
                            </div>
                            <h3 class="pf_titulo mt-4 mb-1">OLIVER TORRE E.</h3>
                            <p class="text-warning fw-bold mb-3">CEO & Lead Engineer</p>
                            <p class="parrafo_1 small">Desarrollador de la arquitectura digital de GymMax y visionario de la marca. Estudiante destacado de la UTP.</p>
                            <div class="equipo-redes">
                                <a href="#"><i class="fa-brands fa-linkedin"></i></a>
                                <a href="#"><i class="fa-brands fa-github"></i></a>
                            </div>
                        </div>
                    </div>


                </div>
            </div>
        </section>
    </main>

    <footer class="fondo_pie">
        <div class="container text-center">
            <p class="text-white mb-2">Visita nuestras redes sociales.</p>
            <div class="contenedor-redes">
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
                <a href="#"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
            <p class="copyright">© 2026 GymMax. Oliver Torre Escobar - UTP</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>