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

# Hints para seguir enlaces
c.colors.hints.bg = tokyo["yellow"]
c.colors.hints.fg = tokyo["bg"]
c.hints.border = "1px solid " + tokyo["bg"]
c.colors.hints.match.fg = tokyo["red"]

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
        'DEFAULT': 'https://duckduckgo.com/?q={}',
        '!aw': 'https://wiki.archlinux.org/?search={}',
        '!apkg': 'https://archlinux.org/packages/?sort=&q={}&maintainer=&flagged=',
        '!gh': 'https://github.com/search?o=desc&q={}&s=stars',
        '!yt': 'https://www.youtube.com/results?search_query={}',
        }

c.completion.open_categories = ['searchengines', 'quickmarks', 'bookmarks', 'history', 'filesystem']

config.load_autoconfig() # load settings done via the gui

c.auto_save.session = False # save tabs on quit/restart
c.completion.web_history.max_items = 0

# keybinding changes
config.bind('=', 'cmd-set-text -s :open')
config.bind('h', 'history')
config.bind('cs', 'cmd-set-text -s :config-source')
config.bind('tH', 'config-cycle tabs.show multiple never')
config.bind('sH', 'config-cycle statusbar.show always never')
config.bind('T', 'hint links tab')
config.bind('pP', 'open -- {primary}')
config.bind('pp', 'open -- {clipboard}')
config.bind('pt', 'open -t -- {clipboard}')
config.bind('qm', 'macro-record')
config.bind('<ctrl-y>', 'spawn --userscript ytdl.sh')
config.bind('tT', 'config-cycle tabs.position top left')
config.bind('gJ', 'tab-move +')
config.bind('gK', 'tab-move -')
config.bind('gm', 'tab-move')

# dark mode setup
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.darkmode.algorithm = 'lightness-cielab'
c.colors.webpage.darkmode.policy.images = 'never'
config.set('colors.webpage.darkmode.enabled', False, 'file://*')

# styles, cosmetics
# c.content.user_stylesheets = ["~/.config/qutebrowser/styles/youtube-tweaks.css"]
c.tabs.padding = {'top': 5, 'bottom': 5, 'left': 9, 'right': 9}
c.tabs.indicator.width = 0 # no tab indicators
# c.window.transparent = True # apparently not needed
c.tabs.width = '7%'

# fonts
c.fonts.default_family = "FiraCode Nerd Font"
c.fonts.default_size = '13pt'  # Dejamos el tamaño que ya tenías, ¡puedes cambiarlo si quieres!
c.fonts.web.family.fixed = "FiraCode Nerd Font"
c.fonts.web.family.sans_serif = "FiraCode Nerd Font"
c.fonts.web.family.serif = "FiraCode Nerd Font"
c.fonts.web.family.standard = "FiraCode Nerd Font"

# privacy - adjust these settings based on your preference
# config.set("completion.cmd_history_max_items", 0)
# config.set("content.private_browsing", True)
config.set("content.webgl", False, "*")
config.set("content.canvas_reading", True)
config.set("content.geolocation", False)
config.set("content.webrtc_ip_handling_policy", "default-public-interface-only")
config.set("content.cookies.accept", "all")
config.set("content.cookies.store", True)
# config.set("content.javascript.enabled", False) # tsh keybind to toggle

# Adblocking info -->
c.content.blocking.enabled = True
c.content.blocking.method = 'adblock' # uncomment this if you install python-adblock
c.content.blocking.adblock.lists = [
        "https://github.com/ewpratten/youtube_ad_blocklist/blob/master/blocklist.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/legacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2020.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2021.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2022.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2023.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/filters-2024.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badware.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/privacy.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-cookies.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/annoyances-others.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/badlists.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/quick-fixes.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/resource-abuse.txt",
        "https://github.com/uBlockOrigin/uAssets/raw/master/filters/unbreak.txt"]
