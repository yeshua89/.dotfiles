#!/bin/bash
# Script para recargar Waybar de forma limpia

echo "🔄 Recargando Waybar..."

# Matar procesos existentes
pkill waybar

# Esperar un momento
sleep 0.5

# Iniciar Waybar en segundo plano
waybar &

# Verificar si se inició correctamente
sleep 1
if pgrep waybar > /dev/null; then
    echo "✅ Waybar recargada exitosamente"
    notify-send "Waybar" "Recargada exitosamente" -t 2000
else
    echo "❌ Error al iniciar Waybar"
    echo "💡 Ejecuta 'waybar -l debug' para ver errores"
fi
