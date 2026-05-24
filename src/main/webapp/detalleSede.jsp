<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page import="com.gymmax.model.Sede"%>
<%@page import="com.gymmax.config.ConexionDB"%>
<%@page import="java.sql.*"%>
<%
    // 1. Obtener el objeto Sede que el SedeDetalleServlet cargó desde la Base de Datos
    Sede sede = (Sede) request.getAttribute("sede");
    
    // Respaldo en caso de que se acceda directamente sin pasar por el servlet
    if (sede == null) {
        sede = new Sede();
        sede.setIdSede(1);
        sede.setNombre("Sede GymMax");
        sede.setDescripcion("Club deportivo equipado con la mejor tecnología para tu entrenamiento.");
        sede.setImagenUrl("https://images.unsplash.com/photo-1534438327276-14e5300c3a48?q=80&w=600");
    }

    // 2. Lógica para verificar si el usuario en sesión es miembro ESPECÍFICO de esta sede
    Usuario usuarioSesion = (Usuario) session.getAttribute("usuarioSession");
    boolean esMiembroDeEstaSede = false;

    if (usuarioSesion != null && "SOCIO".equals(usuarioSesion.getRol())) {
        try (Connection con = ConexionDB.getConexion();
             PreparedStatement ps = con.prepareStatement("SELECT id_sede_principal FROM SOCIO WHERE id_usuario = ?")) {
            ps.setInt(1, usuarioSesion.getIdUsuario());
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    int idSedePrincipal = rs.getInt("id_sede_principal");
                    // Verificamos si coincide exactamente con la sede que estamos visitando
                    if (idSedePrincipal == sede.getIdSede()) {
                        esMiembroDeEstaSede = true;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error verificando membresía de sede: " + e.getMessage());
        }
    }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | <%= sede.getNombre() %></title> 

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css"> 
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/detalles.css">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
</head>
<body class="bg-dark">
    
    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main>
        <div class="img-gym" style="background-image: linear-gradient(rgba(0,0,0,0.3), rgba(0,0,0,0.9)), url('<%= sede.getImagenUrl() %>');">
            <div class="img-overlay container text-center d-flex flex-column justify-content-center align-items-center h-100">
                <p class="sede text-warning fw-bold text-uppercase mb-2">Premium Fitness Experience</p>
                <h1 class="display-3 fw-bold text-white" style="font-family: 'Anton'; text-uppercase: true;"><%= sede.getNombre() %></h1>
            </div>
        </div>

        <div class="container py-5">
            <div class="row g-5">
                <section class="col-lg-8">
                    <div class="descripcion text-white">
                        <h2 class="mb-4" style="font-family: 'Anton'; color: #FFD700;">MÁS QUE ENTRENAMIENTO, ES UN ESTILO DE VIDA</h2>
                        <p class="lead text-secondary mb-5">
                            <%= sede.getDescripcion() %>
                        </p>

                        <h3 class="mb-4" style="color: white; font-family: 'Anton'; letter-spacing: 1px;">
                            BENEFICIOS DE ESTA SEDE
                        </h3>
                        
                        <div class="row g-4">
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-dumbbell text-warning fs-3 me-3"></i>
                                    <span>Zonas de musculación avanzada y peso libre optimizado.</span>
                                </div>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-heart-pulse text-warning fs-3 me-3"></i>
                                    <span>Área Cardiovascular con trotadoras de última generación.</span>
                                </div>
                            </div>
                            <div class="col-md-6">
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-shower text-warning fs-3 me-3"></i>
                                    <span>Vestidores limpios, lockers seguros y duchas privadas.</span>
                                </div>
                                <div class="d-flex align-items-start mb-3">
                                    <i class="fa-solid fa-clock text-warning fs-3 me-3"></i>
                                    <span>Horario extendido para entrenar a tu propio ritmo.</span>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>

                <aside class="col-lg-4">
                    <div class="p-4 rounded-4 shadow-lg sticky-top" style="background: #1a1a1a; top: 100px; border: 1px solid #333;">
                        
                        <% if (esMiembroDeEstaSede) { %>
                            
                            <div class="text-center py-3">
                                <i class="fa-solid fa-circle-check text-success fa-3x mb-3"></i>
                                <h4 class="text-white fw-bold">¡Eres miembro de esta sede!</h4>
                                <p class="text-secondary small mb-4">Tu suscripción se encuentra vinculada a este establecimiento. Puedes registrar tu ingreso diario aquí.</p>
                                
                                <button class="btn btn-success w-100 fw-bold py-3 rounded-pill mb-3 shadow-sm">
                                    <i class="fa-solid fa-user-check me-2"></i> REGISTRAR ASISTENCIA
                                </button>
                                
                                <a href="${pageContext.request.contextPath}/dashboardSocio.jsp" class="btn btn-outline-light w-100 fw-bold py-2 rounded-pill">
                                    Ir a mi Dashboard
                                </a>
                            </div>

                        <% } else { %>

                            <h3 class="text-center text-white mb-4" style="font-family: 'Anton';">PLANES PARA ESTA SEDE</h3>
                            
                            <div class="plan-item-card mb-3 p-3 rounded-3 border border-secondary">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <p class="m-0 fw-bold text-white">PLAN PREMIUM</p>
                                        <small class="text-secondary">Acceso total + Beneficios VIP</small>
                                    </div>
                                    <div class="text-warning fw-bold">S/ 149.90</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/Carrito?accion=agregar&idPlan=2" class="btn btn-outline-warning w-100 fw-bold py-2 rounded-pill">
                                    <i class="fa-solid fa-cart-plus me-2"></i> Adquirir Plan Premium
                                </a>
                            </div>

                            <div class="plan-item-card mb-4 p-3 rounded-3 border border-secondary">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <div>
                                        <p class="m-0 fw-bold text-white">PLAN BASIC</p>
                                        <small class="text-secondary">Entrenamiento estándar en esta sede</small>
                                    </div>
                                    <div class="text-warning fw-bold">S/ 89.90</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/Carrito?accion=agregar&idPlan=1" class="btn btn-outline-light w-100 fw-bold py-2 rounded-pill">
                                    <i class="fa-solid fa-cart-plus me-2"></i> Adquirir Plan Basic
                                </a>
                            </div>

                            <p class="text-center text-secondary mt-3 mb-0" style="font-size: 0.8rem;">
                                <i class="fa-solid fa-shield-halved me-1"></i> Transacción respaldada por GymMax
                            </p>

                        <% } %>

                    </div>
                </aside>
            </div>
        </div>
    </main>

    <div class="fondo_pie mt-5">
        <footer class="pie container text-center">
            <p>Visita nuestras redes sociales.</p>
            <div class="contenedor-redes d-flex justify-content-center gap-3 mb-3">
                <a href="#" class="text-white fs-4"><i class="fa-brands fa-facebook"></i></a>
                <a href="#" class="text-white fs-4"><i class="fa-brands fa-whatsapp"></i></a>
            </div>
            <p class="copyright text-secondary">© 2026 GymMax. Oliver Torre Escobar - UTP</p>
        </footer>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>