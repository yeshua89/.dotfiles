#!/bin/bash
grim -g "$(slurp)" - | tee ~/Screenshots/$(date +%Y%m%d_%H%M%S)_sel.png | wl-copy
notify-send -i camera 'Screenshot' 'Selección copiada al portapapeles'
