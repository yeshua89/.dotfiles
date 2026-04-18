#!/bin/bash
f=~/Screenshots/$(date +%Y%m%d_%H%M%S).png
grim "$f" && notify-send -i camera 'Screenshot' "Guardado: $f"
