#!/bin/bash
# Toggle dropdown terminal - equivalent to MangoWM named scratchpad
if hyprctl clients -j | jq -e '.[] | select(.class == "dropdown")' > /dev/null 2>&1; then
    hyprctl dispatch togglespecialworkspace dropdown
else
    hyprctl dispatch exec "[workspace special:dropdown silent] kitty --class dropdown"
fi
