<%@include file="/WEB-INF/fragments/header.jsp" %>
<div class="contenedor-carrito">
    <h2><i class="fa-solid fa-cart-shopping"></i> Tu Selección GymMax</h2>
    
    <table class="pro-table">
        <thead>
            <tr>
                <th>Sede y Plan</th>
                <th>Precio Unit.</th>
                <th>Cant.</th>
                <th>Subtotal</th>
                <th>Acción</th>
            </tr>
        </thead>
        <tbody id="tabla-carrito">
            </tbody>
    </table>

    <div class="resumen-pago">
        <h3>Total a Pagar: <span id="total-monto">S/ 0.00</span></h3>
        <button class="btn-checkout" onclick="alert('Redirigiendo a pasarela de pago...')">
            PROCEDER AL PAGO
        </button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/assets/js/carrito.js"></script>
<script>
    // Forzar renderizado inicial en esta página
    CarritoGym.renderizar();
</script>