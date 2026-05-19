/**
 * Lógica de búsqueda para GymMax
 * Filtra las sedes por Nombre o Distrito
 */

function filtrarGimnasios() {
    // 1. Obtener el texto del buscador y pasarlo a minúsculas
    const input = document.getElementById('buscador-input');
    const filtro = input.value.toLowerCase();
    
    // 2. Seleccionar todas las tarjetas de gimnasios
    // Asegúrate de que en tu JSP cada columna de gimnasio tenga la clase 'card-item'
    const tarjetas = document.querySelectorAll('.card-item');

    tarjetas.forEach(tarjeta => {
        // Obtenemos el nombre del gimnasio y el distrito desde el contenido de la tarjeta
        const nombreGimnasio = tarjeta.querySelector('.pf_titulo').innerText.toLowerCase();
        
        // También buscamos dentro de los tags de ubicación (distritos)
        const distritos = tarjeta.querySelector('.lista-tags').innerText.toLowerCase();

        // 3. Comprobar si el filtro coincide con el nombre o el distrito
        if (nombreGimnasio.includes(filtro) || distritos.includes(filtro)) {
            // Mostrar la tarjeta con una transición suave (Bootstrap usa d-block)
            tarjeta.style.display = "block";
            tarjeta.classList.add('animate__fadeIn'); // Si usas Animate.css
        } else {
            // Ocultar la tarjeta
            tarjeta.style.display = "none";
        }
    });

    // 4. Mostrar mensaje si no hay resultados (Opcional pero pro)
    verificarResultados(tarjetas);
}

function verificarResultados(tarjetas) {
    const contenedor = document.getElementById('contenedor-gimnasios');
    let visibles = 0;

    tarjetas.forEach(t => {
        if (t.style.display !== "none") visibles++;
    });

    // Si no hay resultados, podemos insertar un mensaje dinámico
    let mensajeNoHay = document.getElementById('no-results-msg');
    
    if (visibles === 0) {
        if (!mensajeNoHay) {
            mensajeNoHay = document.createElement('div');
            mensajeNoHay.id = 'no-results-msg';
            mensajeNoHay.className = 'text-center w-100 py-5';
            mensajeNoHay.innerHTML = `
                <i class="fa-solid fa-dumbbell fa-3x mb-3 text-secondary"></i>
                <h3 class="text-white">No encontramos gimnasios en ese distrito</h3>
                <p class="text-secondary">Prueba buscando "Ate", "Miraflores" o "Smart Fit"</p>
            `;
            contenedor.appendChild(mensajeNoHay);
        }
    } else {
        if (mensajeNoHay) mensajeNoHay.remove();
    }
}

// Escuchar el evento cuando se escribe para que sea instantáneo
document.addEventListener('DOMContentLoaded', () => {
    const inputBuscador = document.getElementById('buscador-input');
    if (inputBuscador) {
        inputBuscador.addEventListener('keyup', filtrarGimnasios);
    }
});