#!/bin/bash
# Script para cambiar entre temas de Waybar dinámicamente

CONFIG_DIR="$HOME/.config/waybar"
STYLE_FILE="$CONFIG_DIR/style.css"

# Temas disponibles
THEMES=("tokyo-night.css" "absolute-black.css" "rose-pine.css")
THEME_NAMES=("Tokyo Night" "Absolute Black" "Rosé Pine")

# Función para mostrar el tema actual
get_current_theme() {
    current=$(grep -E "^@import" "$STYLE_FILE" | grep -v "/\*" | head -1 | sed 's/@import "\(.*\)";/\1/')
    echo "$current"
}

# Función para cambiar el tema
switch_theme() {
    local new_theme="$1"

    # Verificar que el tema existe
    if [ ! -f "$CONFIG_DIR/$new_theme" ]; then
        echo "Error: Tema $new_theme no encontrado"
        exit 1
    fi

    # Crear backup
    cp "$STYLE_FILE" "$STYLE_FILE.backup"

    # Reemplazar la línea @import
    sed -i "s|^@import \".*\";|@import \"$new_theme\";|" "$STYLE_FILE"

    # Reiniciar Waybar
    pkill -SIGUSR2 waybar || killall waybar && waybar &

    echo "Tema cambiado a: $new_theme"
}

# Función para rotar al siguiente tema
rotate_theme() {
    current=$(get_current_theme)

    # Encontrar índice del tema actual
    for i in "${!THEMES[@]}"; do
        if [[ "${THEMES[$i]}" == "$current" ]]; then
            # Obtener siguiente tema (circular)
            next_index=$(( (i + 1) % ${#THEMES[@]} ))
            switch_theme "${THEMES[$next_index]}"
            notify-send "Waybar Theme" "Cambiado a: ${THEME_NAMES[$next_index]}" -t 2000
            exit 0
        fi
    done

    # Si no se encuentra, usar el primero
    switch_theme "${THEMES[0]}"
}

# Función para mostrar menú interactivo
show_menu() {
    current=$(get_current_theme)

    echo "=== Waybar Theme Switcher ==="
    echo "Tema actual: $current"
    echo ""
    echo "Temas disponibles:"

    for i in "${!THEMES[@]}"; do
        marker=""
        if [[ "${THEMES[$i]}" == "$current" ]]; then
            marker=" ✓"
        fi
        echo "  $((i+1)). ${THEME_NAMES[$i]}$marker"
    done

    echo ""
    read -p "Selecciona un tema (1-${#THEMES[@]}): " choice

    if [[ "$choice" =~ ^[0-9]+$ ]] && [ "$choice" -ge 1 ] && [ "$choice" -le "${#THEMES[@]}" ]; then
        index=$((choice - 1))
        switch_theme "${THEMES[$index]}"
        notify-send "Waybar Theme" "Cambiado a: ${THEME_NAMES[$index]}" -t 2000
    else
        echo "Opción inválida"
        exit 1
    fi
}

# Parsear argumentos
case "$1" in
    rotate)
        rotate_theme
        ;;
    menu)
        show_menu
        ;;
    tokyo|tokyo-night)
        switch_theme "tokyo-night.css"
        ;;
    black|absolute-black)
        switch_theme "absolute-black.css"
        ;;
    rose|rose-pine)
        switch_theme "rose-pine.css"
        ;;
    current)
        get_current_theme
        ;;
    *)
        echo "Uso: $0 {rotate|menu|tokyo|black|rose|current}"
        echo ""
        echo "Comandos:"
        echo "  rotate  - Rotar al siguiente tema"
        echo "  menu    - Mostrar menú interactivo"
        echo "  tokyo   - Cambiar a Tokyo Night"
        echo "  black   - Cambiar a Absolute Black"
        echo "  rose    - Cambiar a Rosé Pine"
        echo "  current - Mostrar tema actual"
        exit 1
        ;;
esac
