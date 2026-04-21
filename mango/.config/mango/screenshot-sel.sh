#!/bin/bash
grim -g "$(slurp)" - | wl-copy
notify-send -i camera 'Screenshot' 'Selección copiada al portapapeles'
