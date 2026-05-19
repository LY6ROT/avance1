<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Únete a la Leyenda</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="login-pantalla d-flex align-items-center justify-content-center py-5">
        <div class="banner-overlay"></div>
        
        <div class="login-caja position-relative z-3" style="max-width: 650px;">
            
            <div class="text-center mb-4">
                <i class="fa-solid fa-id-card fa-3x text-warning mb-3"></i>
                <h2 style="font-family: 'Anton', sans-serif; color: white; letter-spacing: 1px;">CREA TU CUENTA <span class="text-warning">GYMMAX</span></h2>
                <p class="text-secondary small">Estás a un paso de empezar tu transformación</p>
            </div>

            <form action="RegistroController" method="POST" class="needs-validation" novalidate>
                
                <div class="row g-3">
                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Nombres</label>
                        <input type="text" name="nombres" class="form-control form-control-dark" placeholder="Juan" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Apellidos</label>
                        <input type="text" name="apellidos" class="form-control form-control-dark" placeholder="Pérez" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-bold small text-uppercase">DNI / Documento</label>
                        <input type="text" name="dni" class="form-control form-control-dark" placeholder="77777777" required pattern="[0-9]{8,12}">
                    </div>

                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Teléfono</label>
                        <input type="tel" name="telefono" class="form-control form-control-dark" placeholder="987654321">
                    </div>

                    <div class="col-12">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Correo Electrónico</label>
                        <input type="email" name="correo" class="form-control form-control-dark" placeholder="ejemplo@correo.com" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Contraseña</label>
                        <input type="password" name="password" id="pass" class="form-control form-control-dark" placeholder="********" required>
                    </div>

                    <div class="col-md-6">
                        <label class="form-label text-secondary fw-bold small text-uppercase">Confirmar Contraseña</label>
                        <input type="password" name="confirm_password" id="confirm_pass" class="form-control form-control-dark" placeholder="********" required>
                    </div>
                </div>

                <div class="form-check mt-4 mb-4">
                    <input class="form-check-input" type="checkbox" id="terminos" required style="cursor: pointer; background-color: #000; border-color: #555;">
                    <label class="form-check-label small text-secondary" for="terminos" style="cursor: pointer;">
                        Acepto los <a href="#" class="text-warning text-decoration-none">términos de servicio</a> y la política de privacidad de GymMax.
                    </label>
                </div>

                <button type="submit" class="btn btn-principal w-100 py-3 mb-3" style="border-radius: 8px;">
                    REGISTRARME AHORA <i class="fa-solid fa-user-plus ms-2"></i>
                </button>

                <div class="text-center mt-2">
                    <p class="text-secondary small">¿Ya tienes una cuenta? <a href="Login.jsp" class="text-warning text-decoration-none fw-bold">Inicia sesión aquí</a></p>
                </div>
            </form>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Script de validación de Bootstrap (Desactiva el envío si hay campos vacíos)
        (() => {
          'use strict'
          const forms = document.querySelectorAll('.needs-validation')
          Array.from(forms).forEach(form => {
            form.addEventListener('submit', event => {
              if (!form.checkValidity()) {
                event.preventDefault()
                event.stopPropagation()
              }
              form.classList.add('was-validated')
            }, false)
          })
        })()
    </script>

</body>
</html>