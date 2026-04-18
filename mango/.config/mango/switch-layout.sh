#!/bin/bash
mmsg -d switch_layout
sleep 0.05
code=$(mmsg -g -l | awk '{print $NF}')
case $code in
    T)  name="Tile" ;;
    S)  name="Scroller" ;;
    G)  name="Grid" ;;
    M)  name="Monocle" ;;
    K)  name="Deck" ;;
    CT) name="Center Tile" ;;
    RT) name="Right Tile" ;;
    VS) name="Vertical Scroller" ;;
    VT) name="Vertical Tile" ;;
    VG) name="Vertical Grid" ;;
    VK) name="Vertical Deck" ;;
    TG) name="TGMix" ;;
    *)  name="$code" ;;
esac
notify-send -i preferences-system-windows "Layout" "$name"
