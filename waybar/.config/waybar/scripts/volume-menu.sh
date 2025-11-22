#!/bin/bash
# Menú elegante de volumen con fuzzel (Wayland)

# Obtener volumen actual
current_volume=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2*100)}')
is_muted=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q 'MUTED' && echo "Sí" || echo "No")

# Opciones del menú
options="󰝝  Subir 10%
󰝞  Bajar 10%
󰝟  Mutear/Desmutear
󰕾  Volumen 100%
󰖀  Volumen 75%
  Volumen 50%
󰕿  Volumen 25%"

# Mostrar menú con fuzzel
choice=$(echo -e "$options" | fuzzel --dmenu \
    --prompt "Volumen: $current_volume (Mute: $is_muted) > " \
    --width 35 \
    --lines 8)

# Ejecutar acción según elección
case "$choice" in
    *"Subir"*)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%+
        ;;
    *"Bajar"*)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 10%-
        ;;
    *"Mutear"*)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
    *"100%"*)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 100%
        ;;
    *"75%"*)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 75%
        ;;
    *"50%"*)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 50%
        ;;
    *"25%"*)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ 25%
        ;;
esac
