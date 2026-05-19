<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Nuestras Sedes</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <section class="estilos_descripcion interactivo-banner" style="height: 40vh;">
            <div class="banner-overlay"></div>
            <div class="banner-content container">
                <h1 style="font-size: 3.5rem;">NUESTRAS <span class="resaltado">SEDES</span></h1>
                <p>Encuentra el centro de entrenamiento más cercano a ti en Lima.</p>
            </div>
        </section>

        <section class="fondo2">
            <div class="container">
                
                <div class="contenedor-buscador">
                    <div class="caja-input">
                        <i class="fa-solid fa-magnifying-glass icono-busqueda"></i>
                        <input type="text" id="buscador-input" placeholder="Buscar por distrito (Ate, Miraflores, San Borja...)" onkeyup="filtrarGimnasios()">
                    </div>
                </div>

                <div class="titulo-seccion mb-5">
                    <h2>GIMNASIOS DISPONIBLES</h2>
                </div>

                <div class="row g-4" id="contenedor-gimnasios">
                    
                    <div class="col-md-4 card-item" data-distrito="ate">
                        <div class="card-gimnasio h-100">
                            <div class="card-imagen">
                                <img src="https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600" alt="Smart Fit">
                            </div>
                            <div class="card-contenido">
                                <h3 class="pf_titulo">SMART FIT</h3>
                                <p class="parrafo_1">Líder en tecnología y comodidad. Equipos de última generación y ambiente premium.</p>
                                
                                <div class="card-tags">
                                    <p class="tag-titulo text-uppercase">Ubicaciones:</p>
                                    <ul class="lista-tags">
                                        <li><i class="fa-solid fa-location-dot"></i> Ate</li>
                                        <li><i class="fa-solid fa-location-dot"></i> Santa Anita</li>
                                    </ul>
                                </div>
                                
                                <div class="card-accion">
                                    <a href="detalles/detallesmartfit.jsp" class="boton_detalle">VER DETALLES</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 card-item" data-distrito="miraflores">
                        <div class="card-gimnasio h-100">
                            <div class="card-imagen">
                                <img src="https://images.unsplash.com/photo-1540497077202-7c8a3999166f?q=80&w=600" alt="B2 Gym">
                            </div>
                            <div class="card-contenido">
                                <h3 class="pf_titulo">B2 GYM</h3>
                                <p class="parrafo_1">Enfoque en entrenamiento de alto rendimiento y asesoría personalizada constante.</p>
                                
                                <div class="card-tags">
                                    <p class="tag-titulo text-uppercase">Ubicaciones:</p>
                                    <ul class="lista-tags">
                                        <li><i class="fa-solid fa-location-dot"></i> Miraflores</li>
                                        <li><i class="fa-solid fa-location-dot"></i> San Isidro</li>
                                    </ul>
                                </div>
                                
                                <div class="card-accion">
                                    <a href="detalles/detalleb2.jsp" class="boton_detalle">VER DETALLES</a>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-4 card-item" data-distrito="san borja">
                        <div class="card-gimnasio h-100">
                            <div class="card-imagen">
                                <img src="https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=600" alt="Zeus Gym">
                            </div>
                            <div class="card-contenido">
                                <h3 class="pf_titulo">ZEUS GYM</h3>
                                <p class="parrafo_1">El templo del hierro. Ideal para amantes del fisicoculturismo y fuerza bruta.</p>
                                
                                <div class="card-tags">
                                    <p class="tag-titulo text-uppercase">Ubicaciones:</p>
                                    <ul class="lista-tags">
                                        <li><i class="fa-solid fa-location-dot"></i> San Borja</li>
                                        <li><i class="fa-solid fa-location-dot"></i> La Molina</li>
                                    </ul>
                                </div>
                                
                                <div class="card-accion">
                                    <a href="detalles/detallezeus.jsp" class="boton_detalle">VER DETALLES</a>
                                </div>
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

    <script>
        function filtrarGimnasios() {
            let input = document.getElementById('buscador-input').value.toLowerCase();
            let cards = document.getElementsByClassName('card-item');

            for (let i = 0; i < cards.length; i++) {
                let distrito = cards[i].getAttribute('data-distrito');
                let nombre = cards[i].getElementsByClassName('pf_titulo')[0].innerText.toLowerCase();
                
                if (distrito.includes(input) || nombre.includes(input)) {
                    cards[i].style.display = "";
                } else {
                    cards[i].style.display = "none";
                }
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>