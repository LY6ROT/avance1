<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle X Sport Gym</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://auroracontractors.com/img/projects/xsport-fitness/XSF.I.massequip-1024.jpg');">
            <div class="img-overlay">
                <h1>X SPORT GYM</h1>
                <p class="sede">Sede Lima Sur - Sin Excusas, Solo Resultados</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>ENTRENAMIENTO REAL, FUERZA PURA</h2>
                    <p>En <strong>X Sport Gym</strong>, nos alejamos de lo comercial para enfocarnos en lo que importa: tu progreso. Somos especialistas en musculación pesada, Powerlifting y Boxeo. Si buscas un lugar donde sudar de verdad y llevar tu cuerpo al límite con equipos de alta resistencia, este es tu sitio.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">DENTRO DE X-SPORT:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-hand-fist"></i> Zona de Boxeo y MMA</li>
                        <li><i class="fa-solid fa-weight-hanging"></i> Discos y Mancuernas de Acero Pro</li>
                        <li><i class="fa-solid fa-person-running"></i> Área de Cardio de Alta Resistencia</li>
                        <li><i class="fa-solid fa-dumbbell"></i> Rack de Sentadillas y Bancos Olímpicos</li>
                        <li><i class="fa-solid fa-users-rays"></i> Comunidad de Atletas de Fuerza</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-skull-crossbones"></i> PLANES X-SPORT</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #777;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN X-TREME</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Libre Mes Completo</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 75.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">X-ANNUAL</p>
                                <p style="font-size: 0.8rem; color: #aaa;">El mejor precio de Lima Sur</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 700.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Inscrito! Prepárate para el entrenamiento más duro de tu vida.')">
                        ¡ACEPTAR EL RETO!
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.85rem; color: #888;">
                            <i class="fa-solid fa-location-dot"></i> Av. Los Héroes 123, San Juan de Miraflores
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede X Sport - No Excuses</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - Facultad de Ingeniería UTP</p>
        </footer>
    </div>

</body>
</html>