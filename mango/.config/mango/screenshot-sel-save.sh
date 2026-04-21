#!/bin/bash
f=~/Screenshots/$(date +%Y%m%d_%H%M%S)_sel.png
grim -g "$(slurp)" "$f" && notify-send -i camera 'Screenshot' "Guardado: $f"
