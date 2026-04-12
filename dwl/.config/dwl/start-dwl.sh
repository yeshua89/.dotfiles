#!/bin/sh
# Wrapper para lanzar dwl desde TTY o .zprofile
# Uso: añadir al final de ~/.zprofile:
#   [ "$(tty)" = "/dev/tty1" ] && exec ~/.config/dwl/start-dwl.sh

# Cargar autostart antes de dwl
~/.config/dwl/autostart.sh

# Lanzar dwl con waybar como barra de estado integrada
# dwl -s pasa un comando a ejecutar como "status command"
exec dwl > /tmp/dwl.log 2>&1
