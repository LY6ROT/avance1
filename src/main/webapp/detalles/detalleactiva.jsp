<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Gimnasio Activa</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1540497077202-7c8a3999166f?q=80&w=2070&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>GIMNASIO ACTIVA</h1>
                <p class="sede">Sede Lima Norte - Actívate Hoy</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>TU MEJOR VERSIÓN EMPIEZA AQUÍ</h2>
                    <p>En <strong>Gimnasio Activa</strong>, nos enfocamos en un entrenamiento funcional y personalizado. Contamos con amplias zonas de cardio, pesas libres y las mejores clases de baile y funcional de la zona.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">NUESTROS SERVICIOS:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-check"></i> Zona de Musculación Completa</li>
                        <li><i class="fa-solid fa-check"></i> Clases de Zumba y Baile</li>
                        <li><i class="fa-solid fa-check"></i> Nutricionista Deportivo</li>
                        <li><i class="fa-solid fa-check"></i> Duchas y Lockers Seguros</li>
                        <li><i class="fa-solid fa-check"></i> Estacionamiento Gratuito</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-tags"></i> PLANES DISPONIBLES</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN MENSUAL</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Total</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 89.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN TRIMESTRAL</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Ahorra un 15%</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 239.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Excelente elección! Redirigiendo al pago...')">
                        ADQUIRIR MEMBRESÍA
                    </button>
                    
                    <p style="font-size: 0.75rem; text-align: center; color: #666; margin-top: 15px;">
                        * Sujeto a términos y condiciones de Gimnasio Activa.
                    </p>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax - Sede Activa | Oliver Torre Escobar</p>
            <div class="contenedor-redes">
                <a href="#"><i class="fa-brands fa-facebook"></i></a>
                <a href="#"><i class="fa-brands fa-instagram"></i></a>
            </div>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/carrito.js"></script>

</body>
</html>