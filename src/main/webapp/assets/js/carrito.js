let planSeleccionado = null;

// 1. Permite seleccionar visualmente un plan
function seleccionarPlan(elemento, nombre, precio) {
    // Quitar selección previa
    document.querySelectorAll('.plan-item').forEach(p => p.classList.remove('selected'));
    
    // Marcar el nuevo
    elemento.classList.add('selected');
    
    // Guardar datos temporalmente
    planSeleccionado = {
        sede: document.querySelector('h1').innerText,
        plan: nombre,
        precio: precio
    };
}

// 2. Agrega al carrito profesional (LocalStorage)
function confirmarAgregarAlCarrito() {
    if (!planSeleccionado) {
        alert("Por favor, selecciona una membresía primero.");
        return;
    }

    let carrito = JSON.parse(localStorage.getItem('gymmax_cart')) || [];
    
    // Lógica profesional: Si ya existe el mismo plan en la misma sede, sumar cantidad
    const index = carrito.findIndex(item => item.sede === planSeleccionado.sede && item.plan === planSeleccionado.plan);
    
    if (index !== -1) {
        carrito[index].cantidad += 1;
    } else {
        carrito.push({ ...planSeleccionado, cantidad: 1, id: Date.now() });
    }

    localStorage.setItem('gymmax_cart', JSON.stringify(carrito));
    actualizarWidget();
    alert("¡Membresía añadida con éxito!");
}

// 3. Actualiza el número en la esquina
function actualizarWidget() {
    let carrito = JSON.parse(localStorage.getItem('gymmax_cart')) || [];
    const count = carrito.reduce((acc, item) => acc + item.cantidad, 0);
    document.getElementById('cart-count').innerText = count;
}

// Ejecutar al cargar
document.addEventListener('DOMContentLoaded', actualizarWidget);