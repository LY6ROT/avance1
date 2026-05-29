<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | Iniciar Sesión</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
    </head>
    <body>
        <%@include file="/WEB-INF/fragments/header.jsp" %>

        <main class="login-pantalla d-flex align-items-center justify-content-center">
            <div class="login-caja position-relative z-3">

                <div class="text-center mb-4">
                    <h1 style="font-family: 'Anton', sans-serif; font-size: 3.5rem; letter-spacing: 1px;">
                        Gym<span class="text-warning">Max</span>
                    </h1>
                    <p class="text-secondary small">Entrena sin límites</p>
                </div>

                <%                // Manejo de errores desde el Servlet
                    String error = request.getParameter("error");
                    if (error != null) {
                %>
                <div class="alert alert-danger bg-transparent border-danger text-danger text-center fw-bold p-2 mb-4 small" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i> Credenciales inválidas.
                </div>
                <% }%>

                <form action="LoginServlet" method="POST">

                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small mb-1">Correo electrónico</label>
                        <input type="email" name="correo" class="form-control form-control-dark custom-input" placeholder="socio@gymmax.com" required>
                    </div>

                    <div class="mb-3 text-start">
                        <label class="form-label text-secondary small mb-1">Contraseña</label>
                        <input type="password" name="password" class="form-control form-control-dark custom-input" placeholder="********" required>
                    </div>

                    <div class="d-flex justify-content-start align-items-center mb-4">
                        <div class="form-check">
                            <input class="form-check-input bg-dark border-secondary" type="checkbox" id="recordarme">
                            <label class="form-check-label text-white small" for="recordarme">
                                Recordarme
                            </label>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark mb-3" style="border-radius: 8px;">
                        <i class="fa-solid fa-right-to-bracket me-2"></i> Ingresar
                    </button>

                    <div class="text-center mb-3">
                        <a href="recuperar.jsp" class="text-secondary small text-decoration-none border-bottom border-secondary pb-1">¿Olvidaste tu contraseña?</a>
                    </div>

                    <div class="text-center mt-3 pt-3 border-top border-secondary">
                        <p class="text-secondary small mb-0">¿No tienes cuenta? <a href="registro.jsp" class="text-warning text-decoration-none fw-bold">Regístrate</a></p>
                    </div>
                </form>
            </div>
        </main>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <c:if test="${param.msg == 'recuperado'}">
        <script>
            document.addEventListener("DOMContentLoaded", function() {
                Swal.fire({ 
                    icon: 'success', 
                    title: '¡Revisa tu correo!', 
                    text: 'Te hemos enviado una nueva contraseña temporal. (Revisa la consola de NetBeans)', 
                    background: '#1a1a1a', 
                    color: '#fff', 
                    confirmButtonColor: '#FFD700' 
                });
            });
        </script>
    </c:if>
</body>
</html>