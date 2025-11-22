#!/bin/bash
# Script minimalista para mostrar el clima usando wttr.in
# Usa tu ubicación automáticamente o especifica una ciudad

CITY="${1:-}"  # Usa argumento o ubicación automática

# Obtener datos del clima en formato simple
weather_data=$(curl -s "wttr.in/${CITY}?format=%c+%t" 2>/dev/null)

# Si falla, mostrar error
if [ -z "$weather_data" ]; then
    echo '{"text": "󰼯", "tooltip": "Error obteniendo clima", "class": "error"}'
    exit 1
fi

# Obtener información completa para tooltip
weather_full=$(curl -s "wttr.in/${CITY}?format=%l:+%C,+%t+(Sensación:+%f)\nViento:+%w\nHumedad:+%h" 2>/dev/null)

# Output JSON
echo "{\"text\": \"$weather_data\", \"tooltip\": \"$weather_full\", \"class\": \"weather\"}"
