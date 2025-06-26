#!/bin/bash

# Obtén el sink actual
SINK=$(pactl info | grep "Default Sink" | cut -d: -f2 | xargs)

# Obtén el nombre del sink (el ID)
SINK_NAME=$(pactl list sinks | grep -B 10 "Name: $SINK" | grep "device.description" | sed -E 's/.*"(.+)"/\1/')

# Si el nombre del sink incluye "headphone" o "Headset", mostramos ícono de audífonos
if echo "$SINK_NAME" | grep -qi "headphone\|headset\|auriculares\|audífonos"; then
  ICON=""
else
  ICON=""
fi

VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -oP '\d+%' | head -n1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q yes && echo "MUTE")

if [ "$MUTED" ]; then
  echo "婢 Mute"
else
  echo "$ICON $VOLUME"
fi
