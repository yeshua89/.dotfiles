#!/bin/bash

STATE_FILE="/tmp/hypr_column_state"

# Leer estado actual (default: 0.7)
if [ -f "$STATE_FILE" ]; then
    CURRENT=$(cat "$STATE_FILE")
else
    CURRENT="0.7"
fi

# Toggle entre 1.0 y 0.7
if [ "$CURRENT" == "1.0" ]; then
    NEW="0.7"
else
    NEW="1.0"
fi

# Guardar nuevo estado
echo "$NEW" > "$STATE_FILE"

# Aplicar resize
hyprctl dispatch layoutmsg "colresize $NEW"
