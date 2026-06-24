const PHONE = "34645482782";
const PHONE_TEL = "+34645482782";

const WP_MSG = encodeURIComponent(
  "Hola, me interesa obtener información sobre vuestros servicios de coding/retrofit para mi Mercedes.",
);

const widgetHTML = `
<div id="chat-widget">
  <button id="chat-toggle" aria-label="Contactar">
    <svg id="chat-icon-open" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5">
      <path stroke-linecap="round" stroke-linejoin="round" d="M8.625 12a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H8.25m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0H12m4.125 0a.375.375 0 1 1-.75 0 .375.375 0 0 1 .75 0Zm0 0h-.375M21 12c0 4.556-4.03 8.25-9 8.25a9.764 9.764 0 0 1-2.555-.337A5.972 5.972 0 0 1 5.41 20.97a5.969 5.969 0 0 1-.474-.065 4.48 4.48 0 0 0 .978-2.025c.09-.457-.133-.901-.467-1.226C3.93 16.178 3 14.189 3 12c0-4.556 4.03-8.25 9-8.25s9 3.694 9 8.25Z" />
    </svg>
    <svg id="chat-icon-close" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5" style="display:none;">
      <path stroke-linecap="round" stroke-linejoin="round" d="M6 18 18 6M6 6l12 12" />
    </svg>
    <span id="chat-badge">1</span>
  </button>

  <div id="chat-panel">
    <div id="chat-header">
      <img id="chat-avatar" src="img/mbr_logo_new.png" alt="MBR Almería" />
      <div>
        <p id="chat-name">MBR Almería</p>
      </div>
    </div>
    <div id="chat-body">
      <div class="chat-bubble chat-bubble--in" id="bubble1" style="opacity:0;">👋 ¡Hola! ¿En qué podemos ayudarte con tu Mercedes?</div>
    </div>
    <div id="chat-actions">
      <a href="https://api.whatsapp.com/send/?phone=${PHONE}&text=${WP_MSG}" target="_blank" id="chat-wp">
        <svg viewBox="0 0 24 24" fill="currentColor"><path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 0 1-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 0 1-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 0 1 2.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0 0 12.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 0 0 5.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893a11.821 11.821 0 0 0-3.48-8.413Z"/></svg>
        Chatear por WhatsApp
      </a>
    </div>
  </div>
</div>
`;

document.body.insertAdjacentHTML("beforeend", widgetHTML);

const toggle = document.getElementById("chat-toggle");
const panel = document.getElementById("chat-panel");
const iconOpen = document.getElementById("chat-icon-open");
const iconClose = document.getElementById("chat-icon-close");
const badge = document.getElementById("chat-badge");

let opened = false;
let bubblesShown = false;

toggle.addEventListener("click", () => {
  opened = !opened;
  if (opened) sessionStorage.setItem("chat-seen", "1");
  panel.classList.toggle("chat-panel--open", opened);
  iconOpen.style.display = opened ? "none" : "block";
  iconClose.style.display = opened ? "block" : "none";
  badge.style.display = "none";

  if (opened && !bubblesShown) {
    bubblesShown = true;
    setTimeout(() => {
      document.getElementById("bubble1").style.opacity = "1";
    }, 400);
  }
});

setTimeout(() => {
  if (!opened && !sessionStorage.getItem("chat-seen")) {
    badge.style.display = "flex";
  }
}, 3000);
