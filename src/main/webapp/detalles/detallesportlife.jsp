<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Sportlife</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1571902943202-507ec2618e8f?q=80&w=2075&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>SPORTLIFE</h1>
                <p class="sede">Sede La Molina - Tu Estilo de Vida Saludable</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>MÁS QUE UN GIMNASIO, UNA EXPERIENCIA</h2>
                    <p>En <strong>Sportlife</strong>, nos enfocamos en que disfrutes cada minuto de tu entrenamiento. Somos líderes en clases grupales: desde nuestro famoso Indoor Cycling hasta sesiones de Yoga y Pilates. Nuestras sedes cuentan con amplias zonas de entrenamiento cardiovascular y musculación con equipos de primer nivel.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">SERVICIOS SPORTLIFE:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-person-cycling"></i> Sala de Indoor Cycling Pro</li>
                        <li><i class="fa-solid fa-users"></i> Clases Grupales (Zumba, BodyPump)</li>
                        <li><i class="fa-solid fa-heart-pulse"></i> Evaluación de Composición Corporal</li>
                        <li><i class="fa-solid fa-temperature-arrow-up"></i> Sauna Vapor y Seco</li>
                        <li><i class="fa-solid fa-wifi"></i> Zona de Co-working para Socios</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-calendar-check"></i> PLANES SPORTLIFE</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #0056b3;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN ONE</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Total Sede Única</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 140.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">ANUALIDAD FULL</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Nacional + Beneficios</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 1,200.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Excelente elección! Sportlife te espera para transformar tu vida.')">
                        ADQUIRIR PLAN
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.85rem; color: #888;">
                            <i class="fa-solid fa-location-dot"></i> Av. Javier Prado Este 5678, La Molina
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede Sportlife - Pasión por el Movimiento</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - UTP</p>
        </footer>
    </div>

</body>
</html>