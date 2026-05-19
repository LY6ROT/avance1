<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Gimnasio Aventura</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1593079831268-3381b0db4a77?q=80&w=2069&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>GIMNASIO AVENTURA</h1>
                <p class="sede">Sede Lima Este - Tu Reto Empieza Aquí</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>VIVE LA AVENTURA DEL FITNESS</h2>
                    <p>En <strong>Gimnasio Aventura</strong>, creemos que entrenar debe ser una experiencia emocionante. Contamos con una de las zonas de peso libre más grandes de Lima Este, además de un área exclusiva de crossfit y entrenamiento de alta intensidad.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">LO QUE TE OFRECEMOS:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-dumbbell"></i> Área de Crossfit y Funcional</li>
                        <li><i class="fa-solid fa-users-gear"></i> Entrenadores Certificados 24/7</li>
                        <li><i class="fa-solid fa-mound"></i> Zona de Boxeo y Artes Marciales</li>
                        <li><i class="fa-solid fa-bottle-water"></i> Cafetería Saludable</li>
                        <li><i class="fa-solid fa-wifi"></i> WiFi de alta velocidad para socios</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-ticket"></i> TARIFAS DE AVENTURA</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 3px solid #FFD700;">
                            <div>
                                <p style="font-weight: bold; color: white;">MENSUALIDAD PRO</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Todo incluido</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 95.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">SEMESTRE AVENTURA</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Paga 5 y entrena 6 meses</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 475.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Plan seleccionado! Preparando tu registro en Sede Aventura...')">
                        INSCRIBIRME AHORA
                    </button>
                    
                    <div style="margin-top: 20px; border-top: 1px solid #333; padding-top: 15px;">
                        <p style="font-size: 0.85rem; color: #ccc;">
                            <i class="fa-solid fa-location-dot" style="color: #FFD700;"></i> 
                            Av. Los Próceres 456, Santa Anita
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede Aventura - Pasión por el Deporte</p>
            <p class="copyright">Oliver Torre Escobar - Ingeniería UTP</p>
        </footer>
    </div>

    <script src="${pageContext.request.contextPath}/assets/js/carrito.js"></script>

</body>
</html>