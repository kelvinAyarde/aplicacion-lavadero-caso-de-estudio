// Obtén una referencia al botón y a la barra lateral
const closeBtn = document.querySelector("#btn");
const sidebar = document.querySelector(".sidebar");
const btnCierreSession = document.querySelector("#btn_cierre_Session");

// Función para cambiar el botón
function menuBtnChange() {
  if (sidebar.classList.contains("open")) {
    closeBtn.classList.replace("bx-menu", "bx-menu-alt-right");
  } else {
    closeBtn.classList.replace("bx-menu-alt-right", "bx-menu");
  }
}

// Al hacer clic en el botón
closeBtn.addEventListener("click", () => {
  sidebar.classList.toggle("open");
  menuBtnChange();

  // Al hacer clic en el botón, guarda el estado en localStorage
  const isOpen = sidebar.classList.contains("open");
  localStorage.setItem('sidebarState', isOpen ? 'open' : 'closed');
});

// Al cargar la página, verifica y aplica el estado almacenado
document.addEventListener('DOMContentLoaded', function () {
  const sidebarState = localStorage.getItem('sidebarState');
  if (sidebarState === 'open') {
    // Aplicar la clase .sidebar.open si el estado es 'open'
    sidebar.classList.add('open');
    // Cambiar el botón si es necesario
    menuBtnChange();
  } else {
    // Si el estado es 'closed', asegurémonos de que la clase .sidebar.open se elimine
    sidebar.classList.remove('open');
    // Cambiar el botón si es necesario
    menuBtnChange();
  }
});

btnCierreSession.addEventListener('click', function () {
  // Elimina el elemento 'sidebarState' del localStorage
  localStorage.removeItem('sidebarState');
});