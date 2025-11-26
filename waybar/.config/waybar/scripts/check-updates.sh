#!/bin/bash
# Script para verificar actualizaciones disponibles en Arch Linux

# Usa paru para obtener todas las actualizaciones (repos oficiales + AUR)
if command -v paru &> /dev/null; then
    # paru -Qu muestra actualizaciones de repos oficiales
    updates=$(paru -Qu 2>/dev/null | wc -l)
    # paru -Qua muestra solo actualizaciones de AUR
    aur_updates=$(paru -Qua 2>/dev/null | wc -l)
    # Calculamos las actualizaciones oficiales
    official_updates=$((updates - aur_updates))
elif command -v yay &> /dev/null; then
    updates=$(yay -Qu 2>/dev/null | wc -l)
    aur_updates=$(yay -Qua 2>/dev/null | wc -l)
    official_updates=$((updates - aur_updates))
else
    # Fallback a pacman si no hay helper de AUR
    updates=$(pacman -Qu 2>/dev/null | wc -l)
    aur_updates=0
    official_updates=$updates
fi

# Output en formato JSON para waybar
if [ "$updates" -eq 0 ]; then
    echo '{"text":"","tooltip":"Sistema actualizado","class":"updated"}'
else
    echo '{"text":"'"$updates"'","tooltip":"Actualizaciones: '"$official_updates"' oficial | '"$aur_updates"' AUR","class":"pending"}'
fi
