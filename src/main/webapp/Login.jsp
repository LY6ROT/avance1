<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
    <link href="/assets/css/login.css" rel="stylesheet" type="text/css"/>
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>
    <br>
    <br>
    <br>
    <br>

    <main class="login-pantalla d-flex align-items-center justify-content-center">
        <div class="banner-overlay"></div>
        
        <div class="login-caja position-relative z-3">
            
            <div class="text-center mb-4">
                <i class="fa-solid fa-user-shield fa-3x text-warning mb-3"></i>
                
                <h2 style="font-family: 'Anton', sans-serif; color: white; letter-spacing: 1px;">ACCESO AL <span class="text-warning">OLIMPO</span></h2>
                <p class="text-secondary small">Ingresa tus credenciales para continuar</p>
            </div>

            <% 
                // Si tu Servlet detecta un error, puede enviar un parámetro en la URL (?error=1) o un atributo
                String error = request.getParameter("error");
                if (error != null) { 
            %>
                <div class="alert alert-danger bg-transparent border-danger text-danger text-center fw-bold p-2 mb-4" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i> Usuario o contraseña incorrectos.
                </div>
            <% } %>

            <form action="LoginController" method="POST">
                
                <div class="mb-3">
                    <label class="form-label text-secondary fw-bold small text-uppercase">Correo Electrónico</label>
                    <div class="input-group">
                        <span class="input-group-text bg-dark border-dark text-warning"><i class="fa-solid fa-envelope"></i></span>
                        <input type="email" name="correo" class="form-control form-control-dark border-start-0" placeholder="ejemplo@gymmax.pe" required>
                    </div>
                </div>

                <div class="mb-4">
                    <div class="d-flex justify-content-between">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Contraseña</label>
                        <a href="#" class="text-warning small text-decoration-none">¿Olvidaste tu clave?</a>
                    </div>
                    <div class="input-group">
                        <span class="input-group-text bg-dark border-dark text-warning"><i class="fa-solid fa-lock"></i></span>
                        <input type="password" name="password" class="form-control form-control-dark border-start-0" placeholder="********" required>
                    </div>
                </div>

                <button type="submit" class="btn btn-principal w-100 py-3 mb-3" style="border-radius: 8px;">
                    ENTRAR AL SISTEMA <i class="fa-solid fa-right-to-bracket ms-2"></i>
                </button>

                <div class="text-center mt-3">
                    <p class="text-secondary small mb-0">¿Aún no eres miembro? <a href="registro.jsp" class="text-warning text-decoration-none fw-bold">Regístrate aquí</a></p>
                </div>
            </form>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>