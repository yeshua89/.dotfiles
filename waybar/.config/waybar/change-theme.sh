#!/bin/bash
# Script simple para cambiar tema

if [ "$1" == "black" ]; then
    sed -i 's|@import ".*\.css";|@import "absolute-black.css";|' ~/.config/waybar/style.css
elif [ "$1" == "tokyo" ]; then
    sed -i 's|@import ".*\.css";|@import "tokyo-night.css";|' ~/.config/waybar/style.css
elif [ "$1" == "rose" ]; then
    sed -i 's|@import ".*\.css";|@import "rose-pine.css";|' ~/.config/waybar/style.css
elif [ "$1" == "mocha" ]; then
    sed -i 's|@import ".*\.css";|@import "catppuccin-mocha.css";|' ~/.config/waybar/style.css
else
    echo "Uso: $0 {black|tokyo|rose|mocha}"
    exit 1
fi

# Reiniciar waybar en background sin output
(pkill waybar; sleep 0.5; nohup waybar >/dev/null 2>&1 &) &
exit 0
