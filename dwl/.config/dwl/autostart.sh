#!/bin/sh
# dwl autostart — equivalente al exec-once de Hyprland
# Usar con el patch "autostart" de dwl, o llamar este script
# antes de lanzar dwl desde tu .zprofile / sesión Wayland.

# Variables de entorno Wayland (mismas que en hyprland.conf)
export XDG_SESSION_TYPE=wayland
export XDG_CURRENT_DESKTOP=dwl
export MOZ_ENABLE_WAYLAND=1
export QT_QPA_PLATFORM=wayland
export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
export GDK_BACKEND="wayland,x11"
export SDL_VIDEODRIVER=wayland
export CLUTTER_BACKEND=wayland
export ELECTRON_OZONE_PLATFORM_HINT=wayland
export XCURSOR_SIZE=24
export WLR_NO_HARDWARE_CURSORS=0

# Barra de estado — config específica para DWL (usa dwl/tags en vez de hyprland/workspaces)
waybar --config ~/.config/dwl/waybar/config.jsonc \
       --style ~/.config/dwl/waybar/style.css &

# Notificaciones
swaync &

# Fondo de pantalla (swww o wpaperd son alternativas a hyprpaper)
# hyprpaper NO funciona sin Hyprland — usar swww:
# swww-daemon &
# swww img ~/path/to/wallpaper.jpg &

# Idle / bloqueo automático (hypridle funciona standalone)
hypridle &

# Ajuste de temperatura de color (hyprsunset también funciona standalone)
hyprsunset &

# Portapapeles
wl-paste --type text  --watch cliphist store &
wl-paste --type image --watch cliphist store &

# Polkit
/usr/lib/hyprpolkitagent &
