<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Energym</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1549060279-7e168fcee0c2?q=80&w=2070&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>ENERGYM</h1>
                <p class="sede">Sede San Miguel - ¡Recarga tu Potencial!</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>ENTRENA CON TODA LA ENERGÍA</h2>
                    <p>En <strong>Energym</strong>, el ambiente lo es todo. Contamos con un sistema de iluminación y sonido diseñado para mantener tu motivación al tope. Somos especialistas en entrenamiento de alta intensidad (HIIT), levantamiento de potencia y ciclismo indoor con efectos visuales.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">LO QUE NOS HACE ÚNICOS:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-bolt-lightning"></i> Clases de HIIT con Luces Neón</li>
                        <li><i class="fa-solid fa-dumbbell"></i> Zona de Powerlifting Profesional</li>
                        <li><i class="fa-solid fa-music"></i> DJ en Vivo en Horarios Estelares</li>
                        <li><i class="fa-solid fa-person-running"></i> Área de Cardio de Alta Gama</li>
                        <li><i class="fa-solid fa-glass-water"></i> Barra de Proteínas y Pre-entrenos</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-fire"></i> TARIFAS ENERGY</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #ccff00;">
                            <div>
                                <p style="font-weight: bold; color: white;">FULL ENERGY</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Total + Clases</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 110.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">ENERGY UTP</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Convenio Universitario</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 85.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Excelente elección, Oliver! Redirigiendo a la plataforma de Energym...')">
                        ¡ACTIVAR MI ENERGÍA!
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.8rem; color: #888;">
                            <i class="fa-solid fa-location-dot"></i> Av. La Marina 2500, San Miguel
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede Energym - Power & Intensity</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - UTP</p>
        </footer>
    </div>

</body>
</html>