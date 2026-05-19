<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Matrix Gym</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1590239068512-63276724b33f?q=80&w=2069&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>MATRIX GYM</h1>
                <p class="sede">Sede Surco - El Sistema de Entrenamiento Perfecto</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>REDEFINE TU REALIDAD</h2>
                    <p>En <strong>Matrix Gym</strong>, aplicamos la ciencia de datos al deporte. Contamos con equipos de carga selectiva de última generación y un sistema de monitoreo cardíaco en tiempo real para todas nuestras clases de entrenamiento funcional y de fuerza.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">TECNOLOGÍA MATRIX:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-virtual-reality"></i> Simuladores de Ciclismo Virtual</li>
                        <li><i class="fa-solid fa-chart-line"></i> Reporte Semanal de Progreso por App</li>
                        <li><i class="fa-solid fa-weight-hanging"></i> Equipamiento de la marca Matrix Fitness</li>
                        <li><i class="fa-solid fa-spa"></i> Zona de Recuperación con Presoterapia</li>
                        <li><i class="fa-solid fa-fingerprint"></i> Acceso Biométrico Personalizado</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-code"></i> CÓDIGO DE MEMBRESÍA</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #00ff41;">
                            <div>
                                <p style="font-weight: bold; color: white;">MATRIX ONE</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Sede Única Surco</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 115.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">MATRIX INFINITE</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Total + Invitado</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 160.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Has sido seleccionado! Bienvenido al sistema Matrix Gym.')">
                        CONECTAR A MATRIX
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.85rem; color: #888;">
                            <i class="fa-solid fa-location-arrow"></i> Av. El Polo 105, Santiago de Surco
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede Matrix - Redefining Fitness</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - Facultad de Ingeniería UTP</p>
        </footer>
    </div>

</body>
</html>