const API_URL = BASE_URL + "/api/contact.php";
const form = document.getElementById("contactForm");
const submitBtn = document.getElementById("submitBtn");
const errorDiv = document.getElementById("formError");
const wrapper = document.getElementById("formWrapper");

if (form) {
  form.addEventListener("submit", async (e) => {
    e.preventDefault();

    // Honeypot (si está relleno es un bot)
    if (form.empresa?.value) return;

    // Turnstile
    const token = document.querySelector(
      '[name="cf-turnstile-response"]',
    )?.value;
    if (!token) {
      showError(FORM_I18N.error_turnstile);
      return;
    }

    const data = {
      name: form.nombre.value.trim(),
      email: form.email.value.trim(),
      phone: form.telefono.value.trim(),
      model: form.modelo.value.trim(),
      message: form.mensaje.value.trim(),
      turnstileToken: token,
    };

    if (!data.name || !data.email || !data.message) {
      showError(FORM_I18N.error_required);
      return;
    }

    submitBtn.disabled = true;
    submitBtn.textContent = FORM_I18N.sending;
    hideError();

    try {
      const res = await fetch(API_URL, {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify(data),
      });

      const json = await res.json();
      if (!res.ok) throw new Error(json.error || FORM_I18N.error_generic);

      wrapper.innerHTML = `
        <div class="form__success">
          <div class="form__success-icon">✓</div>
          <p class="form__success-title">${FORM_I18N.success_title}</p>
          <p class="form__success-text">${FORM_I18N.success_text}</p>
        </div>
      `;
    } catch (err) {
      showError(err.message);
      submitBtn.disabled = false;
      submitBtn.textContent = FORM_I18N.submit_btn;
      if (window.turnstile) window.turnstile.reset();
    }
  });
}

function showError(msg) {
  errorDiv.textContent = msg;
  errorDiv.style.display = "block";
}

function hideError() {
  errorDiv.style.display = "none";
}