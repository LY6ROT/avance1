<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle MegaForce</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=2070&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>MEGAFORCE GYM</h1>
                <p class="sede">Sede Independencia - Donde se Forjan los Campeones</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>FUERZA SIN LÍMITES</h2>
                    <p>En <strong>MegaForce</strong>, no hay espacio para las excusas. Somos el centro de entrenamiento de fuerza más grande del Cono Norte. Contamos con plataformas de levantamiento olímpico, mancuernas de hasta 60kg y un ambiente diseñado para el culturismo profesional y el powerlifting.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">EQUIPAMIENTO DE PODER:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-dumbbell"></i> Mancuernas Pro de Hierro Fundido</li>
                        <li><i class="fa-solid fa-mound"></i> Plataformas de Deadlift</li>
                        <li><i class="fa-solid fa-person-military-pointing"></i> Coaching de Competición</li>
                        <li><i class="fa-solid fa-user-shield"></i> Suplementación de Alta Gama</li>
                        <li><i class="fa-solid fa-award"></i> Sala de Posing para Atletas</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-hand-fist"></i> PLANES MEGAFORCE</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #ff8c00;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN GUERRERO</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Total 30 días</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 80.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">MEGA ANUAL</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Paga 10 meses, entrena 12</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 800.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="confirm('¿Estás listo para liberar tu MegaForce?')">
                        UNIRME A LA FUERZA
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.85rem; color: #888;">
                            <i class="fa-solid fa-map-location-dot"></i> Av. Carlos Izaguirre 123, Independencia
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede MegaForce - Forjando Acero</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - Facultad de Ingeniería UTP</p>
        </footer>
    </div>

</body>
</html>