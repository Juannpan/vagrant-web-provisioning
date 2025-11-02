window.addEventListener("load", function () {
  const loader = document.getElementById("loader");
  const audio = document.body.querySelector("audio");
  this.setTimeout(function () {
    loader.classList.toggle("loader2");
    audio.play();
  }, 3000);
});

// Función para crear y mostrar el modal de redirección
function crearModalRedireccion() {
  // Crear elemento modal
  const modal = document.createElement("div");
  modal.id = "redirect-modal";
  modal.style.cssText = `
        position: fixed;
        top: 0;
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0, 0, 0, 0.8);
        display: flex;
        justify-content: center;
        align-items: center;
        z-index: 10000;
    `;

  // Crear contenido del modal
  const modalContent = document.createElement("div");
  modalContent.id = "redirect-content";
  modalContent.style.cssText = `
        background: white;
        padding: 30px;
        border-radius: 15px;
        text-align: center;
        border: 10px solid #000000;
        box-shadow: 0 0 20px rgba(0, 0, 0, 3);
    `;

  modalContent.innerHTML = `
        <h2 style="color: #000000; margin-bottom: 20px;">Redirigiendo...</h2>
        <div id="countdown" style="font-size: 24px; font-weight: bold; color: #3366cc; margin: 10px 0;">5</div>
        <p>Será redirigido a la base de datos</p>
    `;

  modal.appendChild(modalContent);
  document.body.appendChild(modal);

  return modal;
}

// Función para iniciar la secuencia de redirección
function iniciarRedireccion() {
  const modal = crearModalRedireccion();

  let countdown = 5;
  const countdownElement = document.getElementById("countdown");

  // Contador regresivo
  const countdownInterval = setInterval(function () {
    countdown--;
    countdownElement.textContent = countdown;

    if (countdown <= 0) {
      clearInterval(countdownInterval);
      ejecutarRedireccion();
    }
  }, 1000);
}

function ejecutarRedireccion() {
  // URL database
  window.location.href = "info.php";
}

setTimeout(function () {
  iniciarRedireccion();
}, 7000);
if (typeof module !== "undefined" && module.exports) {
  module.exports = {
    crearModalRedireccion,
    iniciarRedireccion,
    ejecutarRedireccion,
  };
}
