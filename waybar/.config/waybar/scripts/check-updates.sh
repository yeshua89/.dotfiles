#!/bin/bash
# Script para verificar actualizaciones disponibles en Arch Linux

# Cuenta actualizaciones de pacman
updates=$(checkupdates 2>/dev/null | wc -l)

# Cuenta actualizaciones de AUR (si tienes yay o paru)
if command -v yay &> /dev/null; then
    aur_updates=$(yay -Qua 2>/dev/null | wc -l)
elif command -v paru &> /dev/null; then
    aur_updates=$(paru -Qua 2>/dev/null | wc -l)
else
    aur_updates=0
fi

total=$((updates + aur_updates))

# Output en formato JSON para waybar
if [ "$total" -eq 0 ]; then
    echo '{"text":"","tooltip":"Sistema actualizado","class":"updated"}'
else
    echo '{"text":"'"$total"'","tooltip":"Actualizaciones: '"$updates"' oficial | '"$aur_updates"' AUR","class":"pending"}'
fi
