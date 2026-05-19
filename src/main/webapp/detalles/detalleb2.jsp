<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle B2 Gym</title>

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
                <h1>B2 GYM</h1>
                <p class="sede">Sede San Borja - Entrenamiento de Élite</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>MÁXIMA TECNOLOGÍA EN FITNESS</h2>
                    <p>En <strong>B2 Gym</strong>, nos especializamos en ofrecer una experiencia de entrenamiento premium. Contamos con máquinas con sensores de rendimiento, áreas de recuperación post-entrenamiento y un equipo de entrenadores enfocados en metas corporativas y de alto rendimiento.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">DIFERENCIALES B2:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-microchip"></i> Máquinas con Seguimiento Digital</li>
                        <li><i class="fa-solid fa-temperature-arrow-down"></i> Zona de Crioterápia</li>
                        <li><i class="fa-solid fa-user-tie"></i> Coaching Personalizado</li>
                        <li><i class="fa-solid fa-shower"></i> Sauna y Spa Incluido</li>
                        <li><i class="fa-solid fa-apple-whole"></i> Asesoría Nutricional Avanzada</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-crown"></i> MEMBRESÍAS B2</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-right: 4px solid #FFD700;">
                            <div>
                                <p style="font-weight: bold; color: white;">MEMBRESÍA GOLD</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso 24/7 + Sauna</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 120.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">B2 CORPORATIVO</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Mínimo 3 personas</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 90.00 c/u</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Excelente! Redirigiendo a la plataforma de pago B2...')">
                        UNIRME A B2 GYM
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.8rem; color: #888;">
                            Ubicación: Av. Javier Prado Este 1234
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede B2 - Resultados Reales</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - UTP</p>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/carrito.js"></script>

</body>
</html>