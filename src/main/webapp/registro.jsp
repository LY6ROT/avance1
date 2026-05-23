<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>GymMax | Registro de socio</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/login.css">
    </head>
    <body>
        <%@include file="/WEB-INF/fragments/header.jsp" %>

        <main class="login-pantalla d-flex align-items-center justify-content-center py-5">
            <div class="login-caja position-relative z-3 mt-5" style="max-width: 500px; width: 100%;">

                <div class="mb-4 text-center position-relative">
                    <a href="Login.jsp" class="text-white position-absolute start-0 top-0 mt-1 fs-5 text-decoration-none">
                        <i class="fa-solid fa-arrow-left"></i>
                    </a>
                    <h4 class="mb-3 text-white fw-bold">Registro de socio</h4>
                    <div class="bg-warning rounded-circle d-inline-flex align-items-center justify-content-center" style="width: 70px; height: 70px;">
                        <i class="fa-solid fa-user-plus fa-2x text-dark"></i>
                    </div>
                </div>
                
                <% if ("1".equals(request.getParameter("error"))) { %>
                <div class="alert alert-danger bg-transparent border-danger text-danger text-center fw-bold p-2 mb-4 small" role="alert">
                    <i class="fa-solid fa-circle-exclamation me-2"></i> El correo o DNI ya están registrados.
                </div>
                <% }%>
         
                <form action="${pageContext.request.contextPath}/RegistroServlet" method="POST" class="needs-validation text-start" novalidate>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label text-secondary small mb-1">Nombres *</label>
                            <input type="text" name="nombres" class="form-control form-control-dark custom-input" placeholder="Ej: Dennys Marlon" required>
                            <div class="invalid-feedback">Ingrese sus nombres.</div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label text-secondary small mb-1">Apellidos *</label>
                            <input type="text" name="apellidos" class="form-control form-control-dark custom-input" placeholder="Ej: Purizaca Ipanaque" required>
                            <div class="invalid-feedback">Ingrese sus apellidos.</div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label text-secondary small mb-1">DNI *</label>
                            <input type="text" name="dni" class="form-control form-control-dark custom-input" placeholder="12345678" required pattern="[0-9]{8}">
                            <div class="invalid-feedback">El DNI debe tener 8 dígitos.</div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label text-secondary small mb-1">Celular</label>
                            <input type="tel" name="telefono" class="form-control form-control-dark custom-input" placeholder="9XXXXXXXX">
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label text-secondary small mb-1">Fecha de Nacimiento *</label>
                            <input type="date" name="fecha_nac" class="form-control form-control-dark custom-input" required>
                            <div class="invalid-feedback">Seleccione su fecha.</div>
                        </div>

                        <div class="col-md-6 mb-3">
                            <label class="form-label text-secondary small mb-1">Género *</label>
                            <select name="genero" class="form-select form-control-dark custom-input" required>
                                <option value="" disabled selected>Seleccione...</option>
                                <option value="M">Masculino</option>
                                <option value="F">Femenino</option>
                            </select>
                            <div class="invalid-feedback">Seleccione un género.</div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-secondary small mb-1">Dirección</label>
                        <input type="text" name="direccion" class="form-control form-control-dark custom-input" placeholder="Ej: Av. Las Palmeras 1020">
                    </div>

                    <div class="mb-3">
                        <label class="form-label text-secondary small mb-1">Correo *</label>
                        <input type="email" name="correo" class="form-control form-control-dark custom-input" placeholder="correo@ejemplo.com" required>
                        <div class="invalid-feedback">Ingrese un correo válido.</div>
                    </div>

                    <div class="mb-4">
                        <label class="form-label text-secondary small mb-1">Contraseña *</label>
                        <input type="password" name="password" class="form-control form-control-dark custom-input" placeholder="Mínimo 8 caracteres" required minlength="8">
                        <div class="invalid-feedback">Debe tener al menos 8 caracteres.</div>
                    </div>

                    <div class="form-check mb-4">
                        <input class="form-check-input bg-dark border-secondary" type="checkbox" id="terminos" required>
                        <label class="form-check-label small text-secondary" for="terminos">
                            Acepto los términos y condiciones
                        </label>
                        <div class="invalid-feedback">Debe aceptar los términos.</div>
                    </div>

                    <button type="submit" class="btn btn-warning w-100 py-2 fw-bold text-dark" style="border-radius: 8px;">
                        <i class="fa-regular fa-circle-check me-2"></i> Crear cuenta
                    </button>
                </form>
            </div>
        </main>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
        <script>
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