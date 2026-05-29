<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Recuperar Contraseña</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <style>
        body { background-color: #121212; color: #ffffff; font-family: 'Poppins', sans-serif; display: flex; align-items: center; justify-content: center; min-height: 100vh; margin: 0; }
        .login-card { background: #1a1a1a; border: 1px solid #333; border-radius: 12px; width: 100%; max-width: 450px; padding: 2.5rem; box-shadow: 0 10px 30px rgba(0,0,0,0.5); }
        .form-control-dark { background-color: #2a2a2a; border: 1px solid #444; color: #fff; padding: 12px; }
        .form-control-dark:focus { background-color: #2a2a2a; border-color: #FFD700; color: #fff; box-shadow: 0 0 0 0.25rem rgba(255, 215, 0, 0.25); }
        .gymmax-logo { font-family: 'Anton', sans-serif; font-size: 2.5rem; letter-spacing: 1px; text-decoration: none; color: #fff; text-align: center; display: block; margin-bottom: 30px; }
        .gymmax-logo span { color: #FFD700; }
    </style>
</head>
<body>

    <div class="login-card">
        <a href="index.jsp" class="gymmax-logo">Gym<span>Max</span></a>
        
        <h4 class="fw-bold mb-2 text-center">Recuperar Contraseña</h4>
        <p class="text-secondary small text-center mb-4">Ingresa tu correo electrónico y te enviaremos una contraseña temporal para que puedas acceder.</p>
        
        <form action="${pageContext.request.contextPath}/Recuperar" method="POST">
            <div class="mb-4">
                <label class="form-label small fw-bold text-secondary">Correo Electrónico</label>
                <div class="input-group">
                    <span class="input-group-text bg-dark border-secondary text-white"><i class="fa-solid fa-envelope"></i></span>
                    <input type="email" name="correo" class="form-control form-control-dark" placeholder="tu@correo.com" required>
                </div>
            </div>
            
            <button type="submit" class="btn btn-warning w-100 fw-bold py-2 mb-3">Enviar Enlace</button>
            
            <div class="text-center">
                <a href="Login.jsp" class="text-warning text-decoration-none small fw-bold"><i class="fa-solid fa-arrow-left me-1"></i> Volver al Login</a>
            </div>
        </form>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <c:if test="${param.msg == 'no_existe'}">
        <script>Swal.fire({ icon: 'error', title: 'Correo no encontrado', text: 'No existe ninguna cuenta registrada con ese correo.', background: '#1a1a1a', color: '#fff' });</script>
    </c:if>
    <c:if test="${param.msg == 'error_bd'}">
        <script>Swal.fire({ icon: 'error', title: 'Error del sistema', text: 'No pudimos actualizar la contraseña. Intenta nuevamente.', background: '#1a1a1a', color: '#fff' });</script>
    </c:if>
</body>
</html>