const btn = document.querySelector(".burger");
const menu = document.querySelector(".mobile-menu");

// Add Event Listeners
btn.addEventListener("click", () => {
menu.classList.toggle("hidden");
});
