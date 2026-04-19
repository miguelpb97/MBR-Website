// ── Año en footer ────────────────────────────────────────────
document.querySelectorAll("#year").forEach((el) => {
  el.textContent = new Date().getFullYear();
});

// ── Navbar scroll ────────────────────────────────────────────
const navbar = document.getElementById("navbar");
if (navbar && !navbar.classList.contains("scrolled")) {
  window.addEventListener("scroll", () => {
    navbar.classList.toggle("scrolled", window.scrollY > 40);
  });
}

// ── Burger menu ──────────────────────────────────────────────
const burger = document.getElementById("burger");
const mobileMenu = document.getElementById("mobileMenu");

if (burger && mobileMenu) {
  burger.addEventListener("click", () => {
    const open = mobileMenu.classList.toggle("open");
    burger.classList.toggle("open", open);
  });

  // Cierra al hacer click en un enlace
  mobileMenu.querySelectorAll("a").forEach((link) => {
    link.addEventListener("click", () => {
      mobileMenu.classList.remove("open");
      burger.classList.remove("open");
    });
  });
}

// ── Slider about ─────────────────────────────────────────────
const slides = document.querySelectorAll(".about__slide");
if (slides.length > 1) {
  let current = 0;
  setInterval(() => {
    slides[current].classList.remove("active");
    current = (current + 1) % slides.length;
    slides[current].classList.add("active");
  }, 5000);
}

// ── FAQ accordion ────────────────────────────────────────────
document.querySelectorAll(".faq__question").forEach((btn) => {
  btn.addEventListener("click", () => {
    const answer = btn.nextElementSibling;
    const isOpen = btn.classList.contains("open");

    // Cierra todos
    document.querySelectorAll(".faq__question").forEach((b) => {
      b.classList.remove("open");
      b.nextElementSibling.style.maxHeight = null;
    });

    // Abre el clickado si estaba cerrado
    if (!isOpen) {
      btn.classList.add("open");
      answer.style.maxHeight = answer.scrollHeight + "px";
    }
  });
});
