<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Detalle Gimnasio Zeus</title>

    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalleSmartFit.css"> 
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: url('https://images.unsplash.com/photo-1517836357463-d25dfeac3438?q=80&w=2070&auto=format&fit=crop');">
            <div class="img-overlay">
                <h1>GIMNASIO ZEUS</h1>
                <p class="sede">Sede Los Olivos - Entrena como un Dios</p>
            </div>
        </div>

        <div class="contenedor-detalle">
            <section class="info-general">
                <div class="descripcion">
                    <h2>FORJA TU DESTINO EN EL OLIMPO</h2>
                    <p>En <strong>Gimnasio Zeus</strong>, nos tomamos el entrenamiento en serio. Somos el punto de encuentro para quienes buscan resultados reales sin distracciones. Contamos con una amplia zona de peso libre, máquinas de poleas de alta resistencia y un área dedicada al boxeo y funcional.</p>
                    
                    <h3 style="color: #FFD700; margin-bottom: 15px;">PODER ZEUS:</h3>
                    <ul class="lista-servicios">
                        <li><i class="fa-solid fa-bolt"></i> Máquinas de Carga Pro</li>
                        <li><i class="fa-solid fa-mound"></i> Zona de Peso Libre Ampliada</li>
                        <li><i class="fa-solid fa-hand-fist"></i> Saco de Boxeo y Pera</li>
                        <li><i class="fa-solid fa-person-chalkboard"></i> Instructores de Piso 24/7</li>
                        <li><i class="fa-solid fa-bottle-water"></i> Suplementación Directa</li>
                    </ul>
                </div>

                <div class="horarios">
                    <h3><i class="fa-solid fa-bolt-lightning"></i> MEMBRESÍAS ZEUS</h3>
                    
                    <div style="margin-bottom: 25px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px; margin-bottom: 10px; border-left: 4px solid #FFD700;">
                            <div>
                                <p style="font-weight: bold; color: white;">MENSUAL ZEUS</p>
                                <p style="font-size: 0.8rem; color: #aaa;">Acceso Total Sede Única</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 70.00</span>
                        </div>

                        <div style="display: flex; justify-content: space-between; align-items: center; background: #252525; padding: 15px; border-radius: 8px;">
                            <div>
                                <p style="font-weight: bold; color: white;">PLAN OLIMPO</p>
                                <p style="font-size: 0.8rem; color: #aaa;">3 meses de entrenamiento</p>
                            </div>
                            <span style="color: #FFD700; font-weight: bold;">S/ 190.00</span>
                        </div>
                    </div>

                    <button class="boton_detalle" onclick="alert('¡Has aceptado el reto de Zeus! Bienvenido al equipo.')">
                        INICIAR ENTRENAMIENTO
                    </button>
                    
                    <div style="margin-top: 20px; text-align: center;">
                        <p style="font-size: 0.85rem; color: #888;">
                            <i class="fa-solid fa-location-dot"></i> Av. Antúnez de Mayolo 456, Los Olivos
                        </p>
                    </div>
                </div>
            </section>
        </div>
    </main>

    <div class="fondo_pie">
        <footer class="pie">
            <p>© 2026 GymMax | Sede Zeus - Forjando Leyendas</p>
            <p style="font-size: 0.7rem; opacity: 0.5;">Oliver Torre Escobar - Facultad de Ingeniería UTP</p>
        </footer>
    </div>

</body>
</html>