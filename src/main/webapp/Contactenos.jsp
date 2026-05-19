<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Contáctenos</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <section class="estilos_descripcion interactivo-banner" style="height: 40vh;">
            <style>
                .interactivo-banner::before { background-image: url('https://images.unsplash.com/photo-1574680096145-d05b474e2155?q=80&w=2069&auto=format&fit=crop'); }
            </style>
            <div class="banner-overlay"></div>
            <div class="banner-content container text-center">
                <h1 style="font-size: 3.5rem;">PONTE EN <span class="resaltado">CONTACTO</span></h1>
                <p>¿Tienes dudas sobre nuestras membresías o sedes? Estamos para ayudarte.</p>
            </div>
        </section>

        <section class="fondo2 pt-5">
            <div class="container">
                <div class="row g-5">
                    
                    <div class="col-lg-5">
                        <h2 class="titulo-seccion mb-4" style="font-size: 2.2rem; border-bottom: none; display: block;">
                            HABLA CON <span style="color: white;">NOSOTROS</span>
                        </h2>
                        <p class="parrafo_1 mb-5">
                            Nuestro equipo de soporte está disponible para resolver cualquier consulta sobre planes, horarios, o soporte técnico con tu cuenta GymMax.
                        </p>

                        <div class="info-contacto">
                            <i class="fa-solid fa-location-dot"></i>
                            <div>
                                <h4 class="text-white mb-1" style="font-weight: 600; font-size: 1.1rem;">Sede Principal (HQ)</h4>
                                <p class="mb-0 text-secondary">Av. Nicolás Ayllón 866, Ate, Lima.</p>
                            </div>
                        </div>

                        <div class="info-contacto">
                            <i class="fa-solid fa-phone"></i>
                            <div>
                                <h4 class="text-white mb-1" style="font-weight: 600; font-size: 1.1rem;">Llámanos</h4>
                                <p class="mb-0 text-secondary">+51 987 654 321<br><small>Lun-Sáb: 8:00 AM - 8:00 PM</small></p>
                            </div>
                        </div>

                        <div class="info-contacto">
                            <i class="fa-solid fa-envelope"></i>
                            <div>
                                <h4 class="text-white mb-1" style="font-weight: 600; font-size: 1.1rem;">Correo Electrónico</h4>
                                <p class="mb-0 text-secondary">soporte@gymmax.pe<br>oliver.torre@gymmax.pe</p>
                            </div>
                        </div>
                    </div>

                    <div class="col-lg-7">
                        <div class="formulario-caja">
                            <h3 class="mb-4 text-warning" style="font-family: 'Anton', sans-serif;">ENVÍANOS UN MENSAJE</h3>
                            
                            <form action="#" method="POST">
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <label class="form-label text-secondary">Nombre Completo</label>
                                        <input type="text" class="form-control form-control-dark" placeholder="Ej. Oliver Torre" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label class="form-label text-secondary">Teléfono</label>
                                        <input type="tel" class="form-control form-control-dark" placeholder="Tu número de celular">
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-secondary">Correo Electrónico</label>
                                        <input type="email" class="form-control form-control-dark" placeholder="correo@ejemplo.com" required>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-secondary">Asunto</label>
                                        <select class="form-select form-control-dark">
                                            <option selected>Consulta sobre Membresías</option>
                                            <option value="1">Problemas con mi cuenta / Login</option>
                                            <option value="2">Reclamos y Sugerencias</option>
                                            <option value="3">Trabaja con nosotros</option>
                                        </select>
                                    </div>
                                    <div class="col-12">
                                        <label class="form-label text-secondary">Mensaje</label>
                                        <textarea class="form-control form-control-dark" rows="5" placeholder="Escribe tu consulta aquí..." required></textarea>
                                    </div>
                                    <div class="col-12 mt-4">
                                        <button type="submit" class="btn btn-principal w-100 py-3" onclick="alert('¡Mensaje enviado con éxito! Nos contactaremos pronto.'); return false;">
                                            ENVIAR MENSAJE <i class="fa-solid fa-paper-plane ms-2"></i>
                                        </button>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>

                </div>
            </div>
        </section>

        <section class="mapa-section border-top border-warning">
            <iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3902.0435198083893!2d-76.9248231!3d-12.0298341!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x9105c42a2754d929%3A0x8677c7c00e1215b2!2sAte%2C%20Per%C3%BA!5e0!3m2!1ses-419!2spe!4v1700000000000!5m2!1ses-419!2spe" 
                    width="100%" height="400" style="border:0; filter: invert(90%) hue-rotate(180deg);" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>
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