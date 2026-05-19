<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Bodytech</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1574673130244-c747e748041d?q=80&w=2069&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>BODYTECH CLUB</h1>
                <p class="sede">Sede Miraflores - Transformación Médica y Física</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>MÁS QUE UN GIMNASIO, UN CLUB</h2>
                    <p>En <strong>Bodytech</strong> combinamos el deporte con la ciencia. Somos los únicos con un equipo médico deportivo que supervisa tu progreso. Nuestras sedes cuentan con zonas de entrenamiento funcional, pilates, indoor cycling y áreas húmedas de primer nivel.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">EXPERIENCIA BODYTECH:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-user-doctor"></i> Evaluación Médica Deportiva</li>
                        <li><i class="fa-solid fa-dumbbell"></i> Zonas de Musculación de Élite</li>
                        <li><i class="fa-solid fa-water-ladder"></i> Piscina Semiolímpica y Sauna</li>
                        <li><i class="fa-solid fa-person-rays"></i> Clases de Pilates y Yoga</li>
                        <li><i class="fa-solid fa-mobile-screen-button"></i> App de Entrenamiento Personalizado</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-gem"></i> PLANES ELITE</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #FF0000;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN CLASSIC</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Sede Única</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 180.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; border-left: 4px solid #C0C0C0;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN PLATINUM</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Nacional + Piscina</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 250.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Excelente! Redirigiendo a la plataforma de inscripción Bodytech...')">
                        UNIRME AL CLUB
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.8rem; color: #888;">
                            <i class="fa-solid fa-map-pin"></i> Av. Larco 789, Miraflores
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede Bodytech - Salud y Rendimiento</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - Ingeniería de Sistemas UTP</p>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/carrito.js"></script>

</body>
</html>