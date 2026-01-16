# pylint: disable=C0111
c = c  # noqa: F821 pylint: disable=E0602,C0103
config = config  # noqa: F821 pylint: disable=E0602,C0103
# pylint settings included to disable linting errors

# --- AJUSTE: La función xrdb y su llamada están comentadas para evitar errores.
# import subprocess
# def read_xresources(prefix):
#     props = {}
#     x = subprocess.run(['xrdb', '-query'], capture_output=True, check=True, text=True)
#     lines = x.stdout.split('\n')
#     for line in filter(lambda l : l.startswith(prefix), lines):
#         prop, _, value = line.partition(':\t')
#         props[prop] = value
#     return props
#
# xresources = read_xresources("*")

# --- AJUSTE: Comentado para evitar errores. Wayland se activa con variables de entorno.
# c.backend = 'wayland'


# --- TEMA TOKYO NIGHT DARK INTEGRADO (VERSIÓN FINAL CORREGIDA) ---

# 1. Paleta de colores de Tokyo Night
tokyo = {
    "bg": "#1a1b26",
    "bg_dark": "#16161e",
    "bg_highlight": "#292e42",
    "fg": "#c0caf5",
    "fg_dark": "#a9b1d6",
    "fg_gutter": "#3b4261",
    "comment": "#565f89",
    "red": "#f7768e",
    "orange": "#ff9e64",
    "yellow": "#e0af68",
    "green": "#9ece6a",
    "cyan": "#7dcfff",
    "blue": "#7aa2f7",
    "purple": "#bb9af7",
}

# 2. Aplicación de los colores a la interfaz

# Fondo general
c.colors.webpage.bg = tokyo["bg"]

# Barra de estado
c.colors.statusbar.normal.bg = tokyo["bg_dark"]
c.colors.statusbar.normal.fg = tokyo["fg_dark"]
c.colors.statusbar.command.bg = tokyo["bg"]
c.colors.statusbar.command.fg = tokyo["fg"]
c.colors.statusbar.url.fg = tokyo["fg"]
c.colors.statusbar.url.hover.fg = tokyo["blue"]
c.colors.statusbar.url.success.https.fg = tokyo["green"]

# Pestañas (Tabs)
c.colors.tabs.bar.bg = tokyo["bg_dark"]
c.colors.tabs.even.bg = tokyo["bg_dark"]
c.colors.tabs.odd.bg = tokyo["bg_dark"]
c.colors.tabs.even.fg = tokyo["comment"]
c.colors.tabs.odd.fg = tokyo["comment"]
c.colors.tabs.selected.even.bg = tokyo["blue"]
c.colors.tabs.selected.odd.bg = tokyo["blue"]
c.colors.tabs.selected.even.fg = tokyo["bg"]
c.colors.tabs.selected.odd.fg = tokyo["bg"]
c.colors.tabs.indicator.start = tokyo["purple"]
c.colors.tabs.indicator.stop = tokyo["blue"]
c.colors.tabs.indicator.error = tokyo["red"]
c.tabs.show = "multiple"

# Hints para seguir enlaces - optimizado para velocidad
c.colors.hints.bg = tokyo["yellow"]
c.colors.hints.fg = tokyo["bg"]
c.hints.border = "2px solid " + tokyo["purple"]
c.colors.hints.match.fg = tokyo["red"]
c.hints.chars = "asdfghjkl"  # teclas del home row para eficiencia máxima
c.hints.min_chars = 1
c.hints.uppercase = False
c.hints.radius = 3  # bordes redondeados sutiles

# Barra de completado (comandos y búsquedas)
c.colors.completion.category.bg = tokyo["bg_dark"]
c.colors.completion.category.fg = tokyo["blue"]
c.colors.completion.even.bg = tokyo["bg"]
c.colors.completion.odd.bg = tokyo["bg"]
c.colors.completion.fg = tokyo["fg_dark"]
c.colors.completion.match.fg = tokyo["orange"]
c.colors.completion.item.selected.bg = tokyo["bg_highlight"]
c.colors.completion.item.selected.fg = tokyo["fg"]
# --- LÍNEAS CORREGIDAS ---
c.colors.completion.item.selected.border.top = tokyo["blue"]
c.colors.completion.item.selected.border.bottom = tokyo["blue"]

# Mensajes
c.colors.messages.info.bg = tokyo["bg_dark"]
c.colors.messages.info.fg = tokyo["fg"]
c.colors.messages.error.bg = tokyo["red"]
c.colors.messages.error.fg = tokyo["bg"]

# Barra de descargas
c.colors.downloads.bar.bg = tokyo["bg"]
c.colors.downloads.start.bg = tokyo["blue"]
c.colors.downloads.stop.bg = tokyo["green"]
c.colors.downloads.error.bg = tokyo["red"]

# --- FIN DEL TEMA ---

# c.url.start_pages = ""
# c.url.default_page = ""

c.tabs.title.format = "{audio}{current_title}"
c.fonts.web.size.default = 20

c.url.searchengines = {
    # note - if you use duckduckgo, you can make use of its built in bangs, of which there are many! https://duckduckgo.com/bangs
    "DEFAULT": "https://duckduckgo.com/?q={}",
    "!aw": "https://wiki.archlinux.org/?search={}",
    "!apkg": "https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=",
    "!gh": "https://github.com/search?o=desc&q={}&s=stars",
    "!yt": "https://www.youtube.com/results?search_query={}",
}

c.completion.open_categories = [
    "searchengines",
    "quickmarks",
    "bookmarks",
    "history",
    "filesystem",
]

config.load_autoconfig()  # load settings done via the gui

c.auto_save.session = False  # save tabs on quit/restart
c.completion.web_history.max_items = 0

# keybinding changes - optimizados para eficiencia máxima
config.bind("=", "cmd-set-text -s :open")
config.bind("h", "history")
config.bind("cs", "cmd-set-text -s :config-source")
config.bind("tH", "config-cycle tabs.show multiple never")
config.bind("sH", "config-cycle statusbar.show always never")
config.bind("T", "hint links tab")
config.bind("pP", "open -- {primary}")
config.bind("pp", "open -- {clipboard}")
config.bind("pt", "open -t -- {clipboard}")
config.bind("qm", "macro-record")
config.bind("tT", "config-cycle tabs.position top left")
config.bind("gJ", "tab-move +")
config.bind("gK", "tab-move -")
config.bind("gm", "tab-move")

# Atajos adicionales para máxima eficiencia
config.bind("J", "tab-next")  # navegación rápida entre tabs
config.bind("K", "tab-prev")
config.bind("x", "tab-close")  # cerrar tab actual
config.bind("X", "undo")  # reabrir tab cerrado
config.bind("gd", "download-clear")  # limpiar descargas
config.bind("<ctrl-shift-t>", "undo")  # reabrir tab (como en navegadores normales)

# Privacidad rápida
config.bind(",p", "config-cycle content.javascript.enabled")  # toggle JS
config.bind(",i", "config-cycle content.proxy system none")  # toggle proxy
config.bind(",w", "config-cycle content.webgl")  # toggle WebGL si necesitas para algún sitio

# Zoom rápido
config.bind("+", "zoom-in")
config.bind("-", "zoom-out")
config.bind("=z", "zoom")  # reset zoom

# Búsqueda mejorada
config.bind("/", "cmd-set-text /")
config.bind("?", "cmd-set-text ?")
config.bind("n", "search-next")
config.bind("N", "search-prev")

# Modo lectura (sin distracciones)
config.bind(",r", "config-cycle content.user_stylesheets '' '~/.config/qutebrowser/styles/youtube-tweaks.css'")

# Limpieza rápida de datos privados
config.bind(",C", "clear-cookies ;; clear-keychain ;; message-info 'Cookies y cache limpiados'")

# Abrir video actual en mpv (usando yt-dlp)
config.bind(",m", "spawn ~/.config/qutebrowser/script-ytdl/ytdl.sh")
config.bind(",M", "hint links spawn ~/.config/qutebrowser/script-ytdl/ytdl.sh {hint-url}")

# Hints más eficientes
config.bind("f", "hint all")
config.bind("F", "hint all tab")
config.bind(";y", "hint links yank")  # copiar URL
config.bind(";Y", "hint links yank-primary")  # copiar a primary selection

# dark mode setup - optimizado para Tokyo Night
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = "lightness-cielab"
c.colors.webpage.darkmode.policy.images = "never"
c.colors.webpage.darkmode.policy.page = "smart"  # solo oscurece páginas claras
c.colors.webpage.darkmode.threshold.foreground = 150  # nombre correcto del setting
c.colors.webpage.darkmode.threshold.background = 100
config.set("colors.webpage.darkmode.enabled", False, "file://*")

# styles, cosmetics - minimalismo Tokyo Night
c.tabs.padding = {"top": 6, "bottom": 6, "left": 10, "right": 10}
c.tabs.indicator.width = 0  # sin indicadores, más limpio
c.tabs.width = "8%"  # un poco más ancho para mejor legibilidad
c.tabs.min_width = 100
c.tabs.max_width = 200
c.tabs.title.format_pinned = "{audio}"  # pestañas pinneadas solo muestran audio
c.tabs.favicons.scale = 1.0
c.tabs.show_switching_delay = 800  # delay antes de mostrar tabs (minimalismo)

# Barra de estado minimalista
c.statusbar.padding = {"top": 4, "bottom": 4, "left": 10, "right": 10}
c.statusbar.widgets = ["keypress", "url", "scroll", "history", "progress"]

# Scrollbar invisible (minimalismo extremo)
c.scrolling.bar = "never"
c.scrolling.smooth = True

# fonts
c.fonts.default_family = "FiraCode Nerd Font"
c.fonts.default_size = (
    "13pt"  # Dejamos el tamaño que ya tenías, ¡puedes cambiarlo si quieres!
)
c.fonts.web.family.fixed = "FiraCode Nerd Font"
c.fonts.web.family.sans_serif = "FiraCode Nerd Font"
c.fonts.web.family.serif = "FiraCode Nerd Font"
c.fonts.web.family.standard = "FiraCode Nerd Font"

# privacy - balanceada para funcionalidad y privacidad
config.set("completion.cmd_history_max_items", 100)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "disable-non-proxied-udp")  # previene IP leak
config.set("content.cookies.accept", "all")  # necesario para YouTube
config.set("content.cookies.store", True)
config.set("content.headers.do_not_track", True)  # envía DNT header
config.set("content.headers.referer", "always")  # YouTube lo necesita para funcionar
config.set("content.notifications.enabled", False)  # deshabilita notificaciones web
config.set("content.register_protocol_handler", False)  # previene que sitios registren protocolos
config.set("content.media.video_capture", False)  # bloquea acceso a cámara
config.set("content.media.audio_capture", False)  # bloquea acceso a micrófono
config.set("content.media.audio_video_capture", False)  # bloquea ambos
config.set("content.local_storage", True)  # necesario para YouTube
config.set("content.autoplay", False)  # deshabilita autoplay
config.set("content.hyperlink_auditing", False)  # bloquea ping tracking
# config.set("content.javascript.enabled", False) # tsh keybind to toggle

# Excepciones específicas para YouTube (para que funcione correctamente)
config.set("content.cookies.accept", "all", "*://youtube.com")
config.set("content.cookies.accept", "all", "*://*.youtube.com")
config.set("content.cookies.accept", "all", "*://youtu.be")
config.set("content.local_storage", True, "*://youtube.com")
config.set("content.local_storage", True, "*://*.youtube.com")
config.set("content.canvas_reading", True, "*://*.youtube.com")  # YouTube lo necesita
config.set("content.webgl", True, "*://*.youtube.com")  # YouTube lo puede necesitar

# Adblocking info - configuración agresiva anti-anuncios
c.content.blocking.enabled = True
c.content.blocking.method = "adblock"  # requiere python-adblock (más eficiente)
c.content.blocking.adblock.lists = [
    # Listas básicas principales
    "https://easylist.to/easylist/easylist.txt",
    "https://easylist.to/easylist/easyprivacy.txt",
    "https://secure.fanboy.co.nz/fanboy-annoyance.txt",
    "https://secure.fanboy.co.nz/fanboy-social.txt",

    # uBlock Origin filters - solo las esenciales (consolidadas)
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
    "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt",

    # Anti-tracking
    "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts",
]

# Habilita stylesheets de usuario para YouTube
c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
