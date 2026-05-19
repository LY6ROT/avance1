/**
 * LÓGICA DEL POP-UP PROMOCIONAL - GYMMAX
 * Desarrollado para: Oliver Torre Escobar (UTP)
 */

document.addEventListener('DOMContentLoaded', () => {
    // 1. Referencias a los elementos del DOM
    const modal = document.getElementById("miModal");
    const btnCerrar = document.querySelector(".cerrar-modal");

    // 2. Función para mostrar el Modal con retraso
    // Lo ponemos en 2000ms (2 segundos) para que el usuario vea primero el contenido
    setTimeout(() => {
        // Verificamos si el usuario ya cerró la promo en esta sesión
        // Esto es un toque de Ingeniería de UX (Experiencia de Usuario)
        if (!sessionStorage.getItem('promoVisto')) {
            if (modal) {
                modal.style.display = "block";
            }
        }
    }, 2000);

    // 3. Evento para cerrar al hacer clic en la "X"
    if (btnCerrar) {
        btnCerrar.addEventListener('click', () => {
            modal.style.display = "none";
            // Guardamos en la sesión que ya se cerró para que no vuelva a salir
            sessionStorage.setItem('promoVisto', 'true');
        });
    }

    // 4. Evento para cerrar si el usuario hace clic fuera de la caja del modal
    window.addEventListener('click', (event) => {
        if (event.target === modal) {
            modal.style.display = "none";
            sessionStorage.setItem('promoVisto', 'true');
        }
    });
});