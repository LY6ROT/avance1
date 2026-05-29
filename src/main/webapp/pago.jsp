<%@page import="java.util.List"%>
<%@page import="com.gymmax.model.Usuario"%>
<%@page import="com.gymmax.model.ItemCarrito"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    Usuario user = (Usuario) session.getAttribute("usuarioSession");
    List<ItemCarrito> carrito = (List<ItemCarrito>) session.getAttribute("carrito");
    
    // Si no está logueado o el carrito está vacío, lo regresamos a comprar
    if(user == null || carrito == null || carrito.isEmpty()) {
        response.sendRedirect("Gimnasios");
        return;
    }

    double totalPagar = 0.0;
    for(ItemCarrito item : carrito) { totalPagar += item.getSubtotal(); }
%>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Pago Seguro</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;600;800&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/inicio.css">
    
    <style>
        body { background-color: #121212; color: #ffffff; font-family: 'Poppins', sans-serif; }
        .checkout-container { max-width: 900px; margin: 0 auto; }
        .resumen-card { background: #1a1a1a; border: 1px solid #333; border-radius: 12px; }
        .payment-card { background: #1a1a1a; border: 1px solid #333; border-radius: 12px; }
        .nav-pills .nav-link { color: #fff; border-radius: 8px; margin-bottom: 10px; border: 1px solid #333; transition: all 0.3s; }
        .nav-pills .nav-link.active { background-color: #FFD700; color: #000; border-color: #FFD700; font-weight: bold; }
        .nav-pills .nav-link:hover:not(.active) { border-color: #FFD700; color: #FFD700; }
        .form-control-dark { background-color: #2a2a2a; border: 1px solid #444; color: #fff; }
        .form-control-dark:focus { background-color: #2a2a2a; border-color: #FFD700; color: #fff; box-shadow: 0 0 0 0.25rem rgba(255, 215, 0, 0.25); }
        .qr-box { background: #fff; padding: 15px; border-radius: 12px; display: inline-block; }
        .qr-box img { width: 180px; height: 180px; }
    </style>
</head>
<body>

    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <main class="container py-5 mt-5 checkout-container">
        <div class="text-center mb-5">
            <h2 class="fw-bold text-warning" style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">FINALIZA TU COMPRA</h2>
            <p class="text-secondary">Estás a un paso de completar tu membresía.</p>
        </div>

        <div class="row g-4">
            <div class="col-md-5 order-md-2">
                <div class="resumen-card p-4 shadow sticky-top" style="top: 100px;">
                    <h5 class="fw-bold text-warning mb-4 border-bottom border-secondary pb-3"><i class="fa-solid fa-receipt me-2"></i> Resumen del Pedido</h5>
                    
                    <ul class="list-group list-group-flush bg-transparent mb-3">
                        <% for(ItemCarrito item : carrito) { %>
                            <li class="list-group-item bg-transparent text-white px-0 d-flex justify-content-between lh-sm border-secondary">
                                <div>
                                    <h6 class="my-0"><%= item.getPlan().getNombre() %></h6>
                                    <small class="text-secondary">Duración: <%= item.getPlan().getDuracionDias() %> días</small>
                                </div>
                                <span class="text-light fw-bold">S/ <%= String.format("%.2f", item.getSubtotal()) %></span>
                            </li>
                        <% } %>
                        <li class="list-group-item bg-transparent text-white px-0 d-flex justify-content-between border-secondary pt-3">
                            <span class="fs-5 fw-bold">TOTAL A PAGAR</span>
                            <span class="text-warning fs-3 fw-bold">S/ <%= String.format("%.2f", totalPagar) %></span>
                        </li>
                    </ul>
                    
                    <div class="text-center small text-secondary mt-4">
                        <i class="fa-solid fa-lock text-success me-1"></i> Transacción 100% segura y encriptada
                    </div>
                </div>
            </div>

            <div class="col-md-7 order-md-1">
                <div class="payment-card p-4 shadow">
                    <h5 class="fw-bold mb-4">Selecciona tu método de pago</h5>
                    
                    <div class="d-flex align-items-start">
                        <div class="nav flex-column nav-pills me-4 w-100" id="v-pills-tab" role="tablist" aria-orientation="vertical" style="max-width: 150px;">
                            <button class="nav-link active py-3 text-start" id="tab-tarjeta" data-bs-toggle="pill" data-bs-target="#content-tarjeta" type="button" role="tab">
                                <i class="fa-regular fa-credit-card me-2"></i> Tarjeta
                            </button>
                            <button class="nav-link py-3 text-start" id="tab-yape" data-bs-toggle="pill" data-bs-target="#content-yape" type="button" role="tab">
                                <img src="https://upload.wikimedia.org/wikipedia/commons/thumb/d/d1/Yape_text_logo.png/1200px-Yape_text_logo.png" alt="Yape" style="height: 15px; filter: brightness(0) invert(1);">
                            </button>
                            <button class="nav-link py-3 text-start" id="tab-plin" data-bs-toggle="pill" data-bs-target="#content-plin" type="button" role="tab">
                                <i class="fa-solid fa-mobile-screen me-2"></i> Plin
                            </button>
                        </div>
                        
                        <form action="${pageContext.request.contextPath}/ProcesarPago" method="POST" id="form-pago" class="tab-content w-100">
                            <input type="hidden" name="metodoPago" id="input-metodo" value="TARJETA">

                            <div class="tab-pane fade show active" id="content-tarjeta" role="tabpanel" tabindex="0">
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-secondary">Nombre en la tarjeta</label>
                                    <input type="text" class="form-control form-control-dark" placeholder="EJ: JUAN PEREZ" required id="card-name">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label small fw-bold text-secondary">Número de Tarjeta</label>
                                    <div class="input-group">
                                        <span class="input-group-text bg-dark border-secondary border-end-0 text-white"><i class="fa-regular fa-credit-card"></i></span>
                                        <input type="text" class="form-control form-control-dark border-start-0" placeholder="0000 0000 0000 0000" maxlength="19" required id="card-num">
                                    </div>
                                </div>
                                <div class="row g-3 mb-4">
                                    <div class="col-6">
                                        <label class="form-label small fw-bold text-secondary">Vencimiento</label>
                                        <input type="text" class="form-control form-control-dark" placeholder="MM/AA" maxlength="5" required id="card-exp">
                                    </div>
                                    <div class="col-6">
                                        <label class="form-label small fw-bold text-secondary">CVV</label>
                                        <input type="password" class="form-control form-control-dark" placeholder="123" maxlength="4" required id="card-cvv">
                                    </div>
                                </div>
                                <button type="button" class="btn btn-warning w-100 py-3 fw-bold text-dark fs-5 rounded-3" onclick="validarTarjetaYEnviar()">
                                    <i class="fa-solid fa-lock me-2"></i> PAGAR S/ <%= String.format("%.2f", totalPagar) %>
                                </button>
                            </div>

                            <div class="tab-pane fade" id="content-yape" role="tabpanel" tabindex="0">
                                <div class="text-center py-2">
                                    <div class="qr-box mb-3 border border-3" style="border-color: #742284 !important;">
                                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=GymMaxYape_<%= totalPagar %>" alt="QR Yape">
                                    </div>
                                    <h5 class="fw-bold mb-1" style="color: #742284;">Escanea para pagar</h5>
                                    <p class="text-secondary small mb-4">O transfiere al número: <strong>987 654 321</strong></p>
                                    
                                    <div class="text-start mb-4">
                                        <label class="form-label small fw-bold text-secondary">Nro. de Celular (Origen)</label>
                                        <input type="text" class="form-control form-control-dark" placeholder="Ingresa el celular con el que yapeaste" maxlength="9" id="yape-cel">
                                    </div>
                                    <button type="button" class="btn text-white w-100 fw-bold rounded-pill py-2" style="background-color: #742284;" onclick="validarBilleteraYEnviar('yape-cel')">Validar Pago Yape</button>
                                </div>
                            </div>

                            <div class="tab-pane fade" id="content-plin" role="tabpanel" tabindex="0">
                                <div class="text-center py-2">
                                    <div class="qr-box mb-3 border border-3" style="border-color: #00E4FF !important;">
                                        <img src="https://api.qrserver.com/v1/create-qr-code/?size=150x150&data=GymMaxPlin_<%= totalPagar %>" alt="QR Plin">
                                    </div>
                                    <h5 class="fw-bold mb-1" style="color: #00E4FF;">Escanea para pagar</h5>
                                    <p class="text-secondary small mb-4">O transfiere al número: <strong>987 654 321</strong></p>
                                    
                                    <div class="text-start mb-4">
                                        <label class="form-label small fw-bold text-secondary">Nro. de Celular (Origen)</label>
                                        <input type="text" class="form-control form-control-dark" placeholder="Ingresa el celular con el que plineaste" maxlength="9" id="plin-cel">
                                    </div>
                                    <button type="button" class="btn text-dark w-100 fw-bold rounded-pill py-2" style="background-color: #00E4FF;" onclick="validarBilleteraYEnviar('plin-cel')">Validar Pago Plin</button>
                                </div>
                            </div>

                        </form>
                    </div>
                </div>
            </div>
        </div>
    </main>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <script>
        // Formatear input de tarjeta (espacios cada 4 números)
        document.getElementById('card-num').addEventListener('input', function (e) {
            e.target.value = e.target.value.replace(/[^\d]/g, '').replace(/(.{4})/g, '$1 ').trim();
        });
        
        // Formatear input de vencimiento (MM/AA)
        document.getElementById('card-exp').addEventListener('input', function (e) {
            let val = e.target.value.replace(/[^\d]/g, '');
            if(val.length > 2) val = val.substring(0, 2) + '/' + val.substring(2, 4);
            e.target.value = val;
        });

        // Cambiar el valor del input oculto (método de pago) al hacer click en la pestaña
        document.getElementById('tab-tarjeta').addEventListener('click', () => document.getElementById('input-metodo').value = 'TARJETA');
        document.getElementById('tab-yape').addEventListener('click', () => document.getElementById('input-metodo').value = 'YAPE');
        document.getElementById('tab-plin').addEventListener('click', () => document.getElementById('input-metodo').value = 'PLIN');

        // Validar y enviar Pago con Tarjeta
        function validarTarjetaYEnviar() {
            const nom = document.getElementById('card-name').value;
            const num = document.getElementById('card-num').value.replace(/\s/g, '');
            const exp = document.getElementById('card-exp').value;
            const cvv = document.getElementById('card-cvv').value;

            if(nom === "" || num.length < 15 || exp.length < 5 || cvv.length < 3) {
                Swal.fire({ icon: 'error', title: 'Datos Incompletos', text: 'Por favor, llena correctamente todos los datos de la tarjeta.', background: '#1a1a1a', color: '#fff' });
                return;
            }
            lanzarProcesamiento();
        }

        // Validar y enviar Pago con Billetera Digital (Yape/Plin)
        function validarBilleteraYEnviar(inputId) {
            const cel = document.getElementById(inputId).value;
            if(cel.length < 9) {
                Swal.fire({ icon: 'error', title: 'Celular Inválido', text: 'Debes ingresar un número de celular de 9 dígitos.', background: '#1a1a1a', color: '#fff' });
                return;
            }
            lanzarProcesamiento();
        }

        // Animación SweetAlert y Envío del Formulario
        function lanzarProcesamiento() {
            Swal.fire({
                title: 'Procesando transacción...',
                html: 'Conectando con la pasarela bancaria segura<br><br><i class="fa-solid fa-shield-halved text-success fa-3x mt-3 mb-2"></i>',
                allowOutsideClick: false,
                background: '#1a1a1a', color: '#ffffff',
                showConfirmButton: false,
                didOpen: () => { Swal.showLoading(); }
            });

            setTimeout(() => {
                document.getElementById('form-pago').submit();
            }, 2500); // 2.5 segundos de carga falsa
        }
    </script>
</body>
</html>