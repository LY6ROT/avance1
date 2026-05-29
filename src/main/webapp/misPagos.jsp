<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GymMax | Mis Pagos</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Anton&family=Poppins:wght@300;400;500;600;700&display=swap">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css"/>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    
    <!-- Librería para generar el Comprobante en PDF -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>
    <!-- Librería para Alertas -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>

    <style>
        body { background-color: #121212; color: #ffffff; font-family: 'Poppins', sans-serif; }
        .card-pago { background-color: #1e1e1e; border: 1px solid #333; border-radius: 12px; transition: transform 0.2s; }
        .card-pago:hover { transform: translateY(-3px); border-color: #FFD700; }
        
        /* ESTILOS DEL COMPROBANTE (BOLETA A4) */
        #comprobante-template {
            display: none; /* Lo mantenemos oculto */
            width: 210mm; /* Ancho exacto de A4 */
            padding: 20mm;
            background: #ffffff;
            color: #212529;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            box-sizing: border-box;
        }
        .inv-header { display: flex; justify-content: space-between; align-items: center; border-bottom: 2px solid #FFD700; padding-bottom: 20px; margin-bottom: 30px; }
        .inv-logo h2 { font-family: 'Anton', sans-serif; font-size: 40px; margin: 0; color: #212529; letter-spacing: 1px; }
        .inv-logo span { color: #FFD700; }
        .inv-details { text-align: right; }
        .inv-details h3 { margin: 0; color: #6c757d; font-size: 20px; letter-spacing: 1px; }
        .inv-info { display: flex; justify-content: space-between; margin-bottom: 40px; }
        .inv-table { width: 100%; border-collapse: collapse; margin-bottom: 40px; }
        .inv-table th { background-color: #212529; color: white; padding: 12px; text-align: left; }
        .inv-table td { padding: 12px; border-bottom: 1px solid #dee2e6; color: #212529; }
        .inv-total { text-align: right; font-size: 24px; font-weight: bold; color: #212529; }
        .inv-footer { text-align: center; color: #6c757d; font-size: 13px; border-top: 1px solid #dee2e6; padding-top: 15px; margin-top: 50px; }
    </style>
</head>
<body>

    <!-- Incluye tu Header de Usuario (Ajusta la ruta si es necesario) -->
    <%@include file="/WEB-INF/fragments/header.jsp" %>

    <div class="container py-5 mt-5">
        <h2 class="fw-bold mb-1 text-warning" style="font-family: 'Anton', sans-serif; letter-spacing: 1px;">MI HISTORIAL DE PAGOS</h2>
        <p class="text-secondary mb-4">Revisa tus transacciones y descarga tus comprobantes.</p>

        <div class="row g-4">
            <c:choose>
                <c:when test="${not empty misPagos}">
                    <c:forEach var="pago" items="${misPagos}">
                        <div class="col-md-6 col-lg-4">
                            <div class="card-pago p-4 shadow-sm h-100 d-flex flex-column">
                                <div class="d-flex justify-content-between align-items-center mb-3">
                                    <span class="badge ${pago.estado == 'OK' ? 'bg-success' : (pago.estado == 'ANUL' ? 'bg-danger' : 'bg-warning text-dark')}">
                                        ${pago.estado == 'OK' ? 'Completado' : (pago.estado == 'ANUL' ? 'Anulado' : 'Pendiente')}
                                    </span>
                                    <span class="text-secondary small fw-bold">T-${String.format("%05d", pago.idPago)}</span>
                                </div>
                                
                                <h4 class="fw-bold text-white mb-1">S/ ${String.format("%.2f", pago.monto)}</h4>
                                <p class="text-warning small fw-bold mb-3">${pago.nombrePlan}</p>
                                
                                <div class="d-flex justify-content-between text-secondary small mb-1">
                                    <span><i class="fa-regular fa-calendar me-1"></i> Fecha:</span>
                                    <span>${pago.fechaPago}</span>
                                </div>
                                <div class="d-flex justify-content-between text-secondary small mb-4">
                                    <span><i class="fa-solid fa-credit-card me-1"></i> Método:</span>
                                    <span>${pago.metodo}</span>
                                </div>

                                <div class="mt-auto">
                                    <c:if test="${pago.estado == 'OK'}">
                                        <button class="btn btn-outline-warning w-100 fw-bold rounded-pill" 
                                                onclick="generarComprobante('${pago.idPago}', '${pago.fechaPago}', '${pago.nombrePlan}', '${pago.monto}', '${pago.metodo}', '${pago.nombreSocio}')">
                                            <i class="fa-solid fa-file-arrow-down me-2"></i> Descargar Boleta
                                        </button>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <div class="col-12 text-center py-5">
                        <i class="fa-solid fa-receipt fa-4x text-secondary mb-3"></i>
                        <h4 class="fw-bold text-white">No tienes pagos registrados</h4>
                        <p class="text-secondary">Tus próximas compras de membresía aparecerán aquí.</p>
                        <!-- Ajusta este href según tu ruta correcta para ver los planes -->
                        <a href="${pageContext.request.contextPath}/index.jsp" class="btn btn-warning fw-bold text-dark rounded-pill px-4 mt-2">Ver Planes Disponibles</a>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>

    <!-- PLANTILLA OCULTA PARA EL COMPROBANTE A4 -->
    <div id="comprobante-template">
        <div class="inv-header">
            <div class="inv-logo"><h2>Gym<span>Max</span></h2></div>
            <div class="inv-details">
                <h3 class="fw-bold">BOLETA ELECTRÓNICA</h3>
                <p class="m-0 text-secondary">RUC: 20123456789</p>
                <p class="m-0 fw-bold text-dark" id="inv-id">Nro: T-00000</p>
            </div>
        </div>
        
        <div class="inv-info">
            <div>
                <p class="mb-1 text-secondary small">Facturado a:</p>
                <h5 class="fw-bold mb-1 text-dark" id="inv-cliente">Nombre Cliente</h5>
                <p class="mb-1 text-dark"><strong>Método de Pago:</strong> <span id="inv-metodo">Tarjeta</span></p>
            </div>
            <div class="text-end">
                <p class="mb-1 text-secondary small">Fecha de Emisión:</p>
                <p class="fw-bold text-dark" id="inv-fecha">01/01/2026</p>
            </div>
        </div>
        
        <table class="inv-table">
            <thead>
                <tr>
                    <th>Descripción</th>
                    <th class="text-center">Cant.</th>
                    <th class="text-end">Importe (S/)</th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td class="fw-bold">Renovación de Membresía <br><span class="fw-normal text-secondary">Plan <span id="inv-plan">Basic</span></span></td>
                    <td class="text-center fw-bold">1</td>
                    <td class="text-end fw-bold" id="inv-precio">0.00</td>
                </tr>
            </tbody>
        </table>
        
        <div class="inv-total">
            TOTAL PAGADO: S/ <span id="inv-total" class="text-success">0.00</span>
        </div>
        
        <div class="inv-footer">
            <p class="mb-1">Este es un comprobante de pago válido para su registro. Gracias por preferir GymMax.</p>
            <p class="mb-0 fw-bold">gymmax@contacto.com | +51 987 654 321 | Av. Las Rutinas 123, Lima</p>
        </div>
    </div>

    <script>
        function generarComprobante(id, fecha, plan, monto, metodo, cliente) {
            // 1. Inyectar datos en la boleta A4
            document.getElementById('inv-id').innerText = 'Nro: T-' + id.padStart(5, '0');
            document.getElementById('inv-fecha').innerText = fecha;
            document.getElementById('inv-cliente').innerText = cliente;
            document.getElementById('inv-metodo').innerText = metodo;
            document.getElementById('inv-plan').innerText = plan;
            
            const montoForm = parseFloat(monto).toFixed(2);
            document.getElementById('inv-precio').innerText = montoForm;
            document.getElementById('inv-total').innerText = montoForm;

            const elemento = document.getElementById('comprobante-template');
            
            // 2. MOSTRAMOS EL ELEMENTO UN INSTANTE ANTES DE LA CAPTURA
            elemento.style.display = 'block';

            const opciones = {
                margin:       0,
                filename:     'Boleta_GymMax_T' + id.padStart(5, '0') + '.pdf',
                image:        { type: 'jpeg', quality: 1 },
                html2canvas:  { scale: 2, useCORS: true, letterRendering: true },
                jsPDF:        { unit: 'mm', format: 'a4', orientation: 'portrait' }
            };

            // Alerta inicial de carga
            Swal.fire({
                title: 'Generando Boleta...',
                text: 'Preparando documento en formato PDF',
                allowOutsideClick: false,
                background: '#1a1a1a', 
                color: '#ffffff',
                didOpen: () => { Swal.showLoading(); }
            });

            // 3. GENERAMOS EL PDF Y CAMBIAMOS LA ALERTA
            html2pdf().set(opciones).from(elemento).save().then(() => {
                elemento.style.display = 'none'; // Lo escondemos nuevamente
                
                // Alerta de éxito visible por 5 segundos (5000 ms)
                Swal.fire({
                    icon: 'success',
                    title: '¡Descarga Completa!',
                    text: 'Tu comprobante se ha guardado en tu dispositivo.',
                    background: '#1a1a1a',
                    color: '#ffffff',
                    iconColor: '#FFD700',
                    showConfirmButton: false,
                    timer: 5000,
                    timerProgressBar: true
                });
            });
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>