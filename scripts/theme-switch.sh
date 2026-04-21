#!/bin/bash
# ─── GLOBAL THEME SWITCHER ────────────────────────────────────────────────────
# Cycles through 9 dark themes, updating all apps simultaneously.
# Apps affected: Waybar, Hyprland borders, Fuzzel, Kitty, SwayNC, Hyprlock, Swaylock, Starship
# Usage: theme-switch.sh [theme-name]  (no args = cycle to next)

DOTFILES="$HOME/.dotfiles"
STATE_FILE="$HOME/.config/current-theme"

HYPR_CONF="$DOTFILES/hypr/.config/hypr/hyprland.conf"
LOCK_CONF="$DOTFILES/hypr/.config/hypr/hyprlock.conf"
FUZZEL_CONF="$DOTFILES/fuzzel/.config/fuzzel/fuzzel.ini"
KITTY_CONF="$DOTFILES/kitty/.config/kitty/color.ini"
SWAYNC_CSS="$DOTFILES/swaync/.config/swaync/style.css"
WAYBAR_CSS="$DOTFILES/waybar/.config/waybar/style.css"
WAYBAR_MANGO_CSS="$DOTFILES/waybar-mango/.config/waybar/style.css"
STARSHIP_CONF="$DOTFILES/starship/.config/starship.toml"
SWAYLOCK_CONF="$DOTFILES/swaylock/.config/swaylock/config"

THEMES=(catppuccin-mocha tokyo-night rose-pine gruvbox-dark dracula nord obsidian aurora ember absolute-black)

# ─── DETERMINE NEXT THEME ─────────────────────────────────────────────────────
current=$(cat "$STATE_FILE" 2>/dev/null || echo "catppuccin-mocha")

if [[ "$1" == "--menu" ]]; then
    # Build menu list with current theme marked
    menu_list=""
    for t in "${THEMES[@]}"; do
        if [[ "$t" == "$current" ]]; then
            menu_list+=" $t (activo)\n"
        else
            menu_list+="  $t\n"
        fi
    done
    selected=$(printf "$menu_list" | fuzzel --dmenu \
        --prompt="󰏘 Tema: " \
        --width=28 \
        --lines=10 \
        --font="FiraCode Nerd Font:size=11" \
        2>/dev/null | awk '{print $1}')
    selected="${selected// /}"
    [[ -z "$selected" ]] && exit 0
    next="$selected"
elif [[ -n "$1" ]]; then
    next="$1"
else
    for i in "${!THEMES[@]}"; do
        if [[ "${THEMES[$i]}" == "$current" ]]; then
            next="${THEMES[$(( (i+1) % ${#THEMES[@]} ))]}"
            break
        fi
    done
    next="${next:-${THEMES[0]}}"
fi

# Validate theme
valid=false
for t in "${THEMES[@]}"; do [[ "$t" == "$next" ]] && valid=true && break; done
if [[ "$valid" == "false" ]]; then
    echo "Unknown theme: $next. Available: ${THEMES[*]}"
    exit 1
fi

[[ "$next" == "$current" ]] && exit 0
echo "Switching: $current → $next"

# ─── THEME DATA ───────────────────────────────────────────────────────────────
# Each set_theme_* function sets variables used by apply functions.
# Colors: BG, BGLIGHT, BGVISUAL for structural prompt shapes
#         RED GREEN YELLOW BLUE CYAN MAGENTA ORANGE for accents
#         KITTY_* for full terminal palette
#         LOCK_* for hyprlock rgba values
#         SWAYNC_* for notification center rgba

set_theme_catppuccin-mocha() {
    WAYBAR_FILE="catppuccin-mocha.css"
    BORDER_ACTIVE="rgba(137,180,250,221) rgba(203,166,247,170) 45deg"
    BORDER_INACTIVE="rgba(49,50,68,170)"
    FUZZEL_BG="1e1e2eee"   FUZZEL_FG="cdd6f4ff"  FUZZEL_SEL="313244ff"
    FUZZEL_SEL_FG="cdd6f4ff" FUZZEL_SEL_MATCH="fab387ff" FUZZEL_BORDER="89b4faaa"
    FUZZEL_PROMPT="89b4faff" FUZZEL_PH="6c7086ff" FUZZEL_INPUT="cdd6f4ff"
    FUZZEL_MATCH="fab387ff"  FUZZEL_COUNTER="cba6f7ff"
    KITTY_FG="#cdd6f4" KITTY_BG="#11111b"
    KITTY_C0="#313244" KITTY_C8="#585b70"
    KITTY_C1="#f38ba8" KITTY_C9="#f38ba8"
    KITTY_C2="#a6e3a1" KITTY_C10="#a6e3a1"
    KITTY_C3="#f9e2af" KITTY_C11="#f9e2af"
    KITTY_C4="#89b4fa" KITTY_C12="#74c7ec"
    KITTY_C5="#cba6f7" KITTY_C13="#f5c2e7"
    KITTY_C6="#94e2d5" KITTY_C14="#89dceb"
    KITTY_C7="#bac2de" KITTY_C15="#cdd6f4"
    KITTY_CUR="#f5e0dc" KITTY_CUR_TEXT="#11111b"
    KITTY_SEL_FG="#cdd6f4" KITTY_SEL_BG="#313244"
    KITTY_TAB_AFG="#11111b" KITTY_TAB_ABG="#cba6f7"
    KITTY_TAB_IFG="#a6adc8" KITTY_TAB_IBG="#181825" KITTY_TAB_BAR="#11111b"
    SWAYNC_BASE_R=30  SWAYNC_BASE_G=30  SWAYNC_BASE_B=46
    SWAYNC_SURF_R=24  SWAYNC_SURF_G=24  SWAYNC_SURF_B=37
    SWAYNC_MUT_R=88   SWAYNC_MUT_G=91   SWAYNC_MUT_B=112
    SWAYNC_TEXT="#cdd6f4"   SWAYNC_SUBTEXT="#a6adc8"
    SWAYNC_LOVE="#f38ba8"   SWAYNC_ROSE="#f5c2e7"
    SWAYNC_FOAM="#94e2d5"   SWAYNC_PINE="#89b4fa"
    LOCK_BG_R=30   LOCK_BG_G=30   LOCK_BG_B=46
    LOCK_OUT1_R=137 LOCK_OUT1_G=180 LOCK_OUT1_B=250
    LOCK_OUT2_R=203 LOCK_OUT2_G=166 LOCK_OUT2_B=247
    LOCK_CHK1_R=148 LOCK_CHK1_G=226 LOCK_CHK1_B=213
    LOCK_CHK2_R=166 LOCK_CHK2_G=227 LOCK_CHK2_B=161
    LOCK_FAIL_R=243 LOCK_FAIL_G=139 LOCK_FAIL_B=168
    LOCK_FONT_R=205 LOCK_FONT_G=214 LOCK_FONT_B=244
    LOCK_TIME_R=245 LOCK_TIME_G=224 LOCK_TIME_B=220
    LOCK_DATE_R=148 LOCK_DATE_G=226 LOCK_DATE_B=213
    LOCK_WELC_R=203 LOCK_WELC_G=166 LOCK_WELC_B=247
    S_PALETTE="catppuccin_mocha"
    S_BG="#1e1e2e" S_BGLIGHT="#313244" S_BGVISUAL="#45475a"
    S_FG="#cdd6f4" S_FGDIM="#6c7086"
    S_RED="#f38ba8" S_ORANGE="#fab387" S_YELLOW="#f9e2af"
    S_GREEN="#a6e3a1" S_CYAN="#89dceb" S_BLUE="#89b4fa"
    S_VIOLET="#cba6f7" S_MAGENTA="#f5c2e7"
}

set_theme_tokyo-night() {
    WAYBAR_FILE="tokyo-night.css"
    BORDER_ACTIVE="rgba(122,162,247,221) rgba(187,154,247,170) 45deg"
    BORDER_INACTIVE="rgba(36,40,59,170)"
    FUZZEL_BG="1a1b26ee"   FUZZEL_FG="c0caf5ff"  FUZZEL_SEL="24283bff"
    FUZZEL_SEL_FG="c0caf5ff" FUZZEL_SEL_MATCH="ff9e64ff" FUZZEL_BORDER="7aa2f7aa"
    FUZZEL_PROMPT="7aa2f7ff" FUZZEL_PH="565f89ff" FUZZEL_INPUT="c0caf5ff"
    FUZZEL_MATCH="ff9e64ff"  FUZZEL_COUNTER="bb9af7ff"
    KITTY_FG="#c0caf5" KITTY_BG="#16161e"
    KITTY_C0="#414868" KITTY_C8="#414868"
    KITTY_C1="#f7768e" KITTY_C9="#f7768e"
    KITTY_C2="#9ece6a" KITTY_C10="#9ece6a"
    KITTY_C3="#e0af68" KITTY_C11="#e0af68"
    KITTY_C4="#7aa2f7" KITTY_C12="#7dcfff"
    KITTY_C5="#bb9af7" KITTY_C13="#bb9af7"
    KITTY_C6="#7dcfff" KITTY_C14="#7dcfff"
    KITTY_C7="#a9b1d6" KITTY_C15="#c0caf5"
    KITTY_CUR="#c0caf5" KITTY_CUR_TEXT="#16161e"
    KITTY_SEL_FG="#c0caf5" KITTY_SEL_BG="#24283b"
    KITTY_TAB_AFG="#16161e" KITTY_TAB_ABG="#bb9af7"
    KITTY_TAB_IFG="#565f89" KITTY_TAB_IBG="#1a1b26" KITTY_TAB_BAR="#16161e"
    SWAYNC_BASE_R=26  SWAYNC_BASE_G=27  SWAYNC_BASE_B=38
    SWAYNC_SURF_R=22  SWAYNC_SURF_G=22  SWAYNC_SURF_B=30
    SWAYNC_MUT_R=65   SWAYNC_MUT_G=72   SWAYNC_MUT_B=104
    SWAYNC_TEXT="#c0caf5"   SWAYNC_SUBTEXT="#9aa5ce"
    SWAYNC_LOVE="#f7768e"   SWAYNC_ROSE="#ff9e64"
    SWAYNC_FOAM="#7dcfff"   SWAYNC_PINE="#7aa2f7"
    LOCK_BG_R=26   LOCK_BG_G=27   LOCK_BG_B=38
    LOCK_OUT1_R=122 LOCK_OUT1_G=162 LOCK_OUT1_B=247
    LOCK_OUT2_R=187 LOCK_OUT2_G=154 LOCK_OUT2_B=247
    LOCK_CHK1_R=125 LOCK_CHK1_G=207 LOCK_CHK1_B=255
    LOCK_CHK2_R=158 LOCK_CHK2_G=206 LOCK_CHK2_B=106
    LOCK_FAIL_R=247 LOCK_FAIL_G=118 LOCK_FAIL_B=142
    LOCK_FONT_R=192 LOCK_FONT_G=202 LOCK_FONT_B=245
    LOCK_TIME_R=192 LOCK_TIME_G=202 LOCK_TIME_B=245
    LOCK_DATE_R=125 LOCK_DATE_G=207 LOCK_DATE_B=255
    LOCK_WELC_R=187 LOCK_WELC_G=154 LOCK_WELC_B=247
    S_PALETTE="tokyo_night"
    S_BG="#1a1b26" S_BGLIGHT="#24283b" S_BGVISUAL="#2f3549"
    S_FG="#c0caf5" S_FGDIM="#565f89"
    S_RED="#f7768e" S_ORANGE="#ff9e64" S_YELLOW="#e0af68"
    S_GREEN="#9ece6a" S_CYAN="#7dcfff" S_BLUE="#7aa2f7"
    S_VIOLET="#bb9af7" S_MAGENTA="#bb9af7"
}

set_theme_rose-pine() {
    WAYBAR_FILE="rose-pine.css"
    BORDER_ACTIVE="rgba(196,167,231,221) rgba(235,111,146,170) 45deg"
    BORDER_INACTIVE="rgba(38,35,58,170)"
    FUZZEL_BG="191724ee"   FUZZEL_FG="e0def4ff"  FUZZEL_SEL="26233aff"
    FUZZEL_SEL_FG="e0def4ff" FUZZEL_SEL_MATCH="f6c177ff" FUZZEL_BORDER="9ccfd8aa"
    FUZZEL_PROMPT="9ccfd8ff" FUZZEL_PH="6e6a86ff" FUZZEL_INPUT="e0def4ff"
    FUZZEL_MATCH="f6c177ff"  FUZZEL_COUNTER="c4a7e7ff"
    KITTY_FG="#e0def4" KITTY_BG="#191724"
    KITTY_C0="#26233a" KITTY_C8="#6e6a86"
    KITTY_C1="#eb6f92" KITTY_C9="#eb6f92"
    KITTY_C2="#31748f" KITTY_C10="#9ccfd8"
    KITTY_C3="#f6c177" KITTY_C11="#f6c177"
    KITTY_C4="#9ccfd8" KITTY_C12="#9ccfd8"
    KITTY_C5="#c4a7e7" KITTY_C13="#c4a7e7"
    KITTY_C6="#ebbcba" KITTY_C14="#9ccfd8"
    KITTY_C7="#e0def4" KITTY_C15="#e0def4"
    KITTY_CUR="#ebbcba" KITTY_CUR_TEXT="#191724"
    KITTY_SEL_FG="#e0def4" KITTY_SEL_BG="#26233a"
    KITTY_TAB_AFG="#191724" KITTY_TAB_ABG="#c4a7e7"
    KITTY_TAB_IFG="#908caa" KITTY_TAB_IBG="#1f1d2e" KITTY_TAB_BAR="#191724"
    SWAYNC_BASE_R=25  SWAYNC_BASE_G=23  SWAYNC_BASE_B=36
    SWAYNC_SURF_R=31  SWAYNC_SURF_G=29  SWAYNC_SURF_B=46
    SWAYNC_MUT_R=110  SWAYNC_MUT_G=106  SWAYNC_MUT_B=134
    SWAYNC_TEXT="#e0def4"   SWAYNC_SUBTEXT="#908caa"
    SWAYNC_LOVE="#eb6f92"   SWAYNC_ROSE="#ebbcba"
    SWAYNC_FOAM="#9ccfd8"   SWAYNC_PINE="#31748f"
    LOCK_BG_R=25   LOCK_BG_G=23   LOCK_BG_B=36
    LOCK_OUT1_R=196 LOCK_OUT1_G=167 LOCK_OUT1_B=231
    LOCK_OUT2_R=235 LOCK_OUT2_G=111 LOCK_OUT2_B=146
    LOCK_CHK1_R=156 LOCK_CHK1_G=207 LOCK_CHK1_B=216
    LOCK_CHK2_R=235 LOCK_CHK2_G=188 LOCK_CHK2_B=186
    LOCK_FAIL_R=235 LOCK_FAIL_G=111 LOCK_FAIL_B=146
    LOCK_FONT_R=224 LOCK_FONT_G=222 LOCK_FONT_B=244
    LOCK_TIME_R=235 LOCK_TIME_G=188 LOCK_TIME_B=186
    LOCK_DATE_R=156 LOCK_DATE_G=207 LOCK_DATE_B=216
    LOCK_WELC_R=196 LOCK_WELC_G=167 LOCK_WELC_B=231
    S_PALETTE="rose_pine"
    S_BG="#191724" S_BGLIGHT="#26233a" S_BGVISUAL="#403d52"
    S_FG="#e0def4" S_FGDIM="#6e6a86"
    S_RED="#eb6f92" S_ORANGE="#f6c177" S_YELLOW="#f6c177"
    S_GREEN="#9ccfd8" S_CYAN="#ebbcba" S_BLUE="#9ccfd8"
    S_VIOLET="#c4a7e7" S_MAGENTA="#c4a7e7"
}

set_theme_gruvbox-dark() {
    WAYBAR_FILE="gruvbox-dark.css"
    BORDER_ACTIVE="rgba(131,165,152,221) rgba(211,134,155,170) 45deg"
    BORDER_INACTIVE="rgba(60,56,54,170)"
    FUZZEL_BG="282828ee"   FUZZEL_FG="ebdbb2ff"  FUZZEL_SEL="3c3836ff"
    FUZZEL_SEL_FG="ebdbb2ff" FUZZEL_SEL_MATCH="fe8019ff" FUZZEL_BORDER="83a598aa"
    FUZZEL_PROMPT="83a598ff" FUZZEL_PH="928374ff" FUZZEL_INPUT="ebdbb2ff"
    FUZZEL_MATCH="fe8019ff"  FUZZEL_COUNTER="d3869bff"
    KITTY_FG="#ebdbb2" KITTY_BG="#1d2021"
    KITTY_C0="#282828" KITTY_C8="#928374"
    KITTY_C1="#cc241d" KITTY_C9="#fb4934"
    KITTY_C2="#98971a" KITTY_C10="#b8bb26"
    KITTY_C3="#d79921" KITTY_C11="#fabd2f"
    KITTY_C4="#458588" KITTY_C12="#83a598"
    KITTY_C5="#b16286" KITTY_C13="#d3869b"
    KITTY_C6="#689d6a" KITTY_C14="#8ec07c"
    KITTY_C7="#a89984" KITTY_C15="#ebdbb2"
    KITTY_CUR="#ebdbb2" KITTY_CUR_TEXT="#1d2021"
    KITTY_SEL_FG="#ebdbb2" KITTY_SEL_BG="#3c3836"
    KITTY_TAB_AFG="#1d2021" KITTY_TAB_ABG="#d3869b"
    KITTY_TAB_IFG="#928374" KITTY_TAB_IBG="#282828" KITTY_TAB_BAR="#1d2021"
    SWAYNC_BASE_R=40  SWAYNC_BASE_G=40  SWAYNC_BASE_B=40
    SWAYNC_SURF_R=60  SWAYNC_SURF_G=56  SWAYNC_SURF_B=54
    SWAYNC_MUT_R=102  SWAYNC_MUT_G=92   SWAYNC_MUT_B=84
    SWAYNC_TEXT="#ebdbb2"   SWAYNC_SUBTEXT="#bdae93"
    SWAYNC_LOVE="#fb4934"   SWAYNC_ROSE="#d3869b"
    SWAYNC_FOAM="#8ec07c"   SWAYNC_PINE="#83a598"
    LOCK_BG_R=40   LOCK_BG_G=40   LOCK_BG_B=40
    LOCK_OUT1_R=131 LOCK_OUT1_G=165 LOCK_OUT1_B=152
    LOCK_OUT2_R=211 LOCK_OUT2_G=134 LOCK_OUT2_B=155
    LOCK_CHK1_R=142 LOCK_CHK1_G=192 LOCK_CHK1_B=124
    LOCK_CHK2_R=250 LOCK_CHK2_G=189 LOCK_CHK2_B=47
    LOCK_FAIL_R=251 LOCK_FAIL_G=73  LOCK_FAIL_B=52
    LOCK_FONT_R=235 LOCK_FONT_G=219 LOCK_FONT_B=178
    LOCK_TIME_R=235 LOCK_TIME_G=219 LOCK_TIME_B=178
    LOCK_DATE_R=142 LOCK_DATE_G=192 LOCK_DATE_B=124
    LOCK_WELC_R=211 LOCK_WELC_G=134 LOCK_WELC_B=155
    S_PALETTE="gruvbox_dark"
    S_BG="#282828" S_BGLIGHT="#3c3836" S_BGVISUAL="#504945"
    S_FG="#ebdbb2" S_FGDIM="#928374"
    S_RED="#fb4934" S_ORANGE="#fe8019" S_YELLOW="#fabd2f"
    S_GREEN="#b8bb26" S_CYAN="#8ec07c" S_BLUE="#83a598"
    S_VIOLET="#d3869b" S_MAGENTA="#d3869b"
}

set_theme_dracula() {
    WAYBAR_FILE="dracula.css"
    BORDER_ACTIVE="rgba(189,147,249,221) rgba(255,121,198,170) 45deg"
    BORDER_INACTIVE="rgba(68,71,90,170)"
    FUZZEL_BG="282a36ee"   FUZZEL_FG="f8f8f2ff"  FUZZEL_SEL="44475aff"
    FUZZEL_SEL_FG="f8f8f2ff" FUZZEL_SEL_MATCH="ffb86cff" FUZZEL_BORDER="bd93f9aa"
    FUZZEL_PROMPT="bd93f9ff" FUZZEL_PH="6272a4ff" FUZZEL_INPUT="f8f8f2ff"
    FUZZEL_MATCH="ffb86cff"  FUZZEL_COUNTER="bd93f9ff"
    KITTY_FG="#f8f8f2" KITTY_BG="#1e1f29"
    KITTY_C0="#21222c" KITTY_C8="#6272a4"
    KITTY_C1="#ff5555" KITTY_C9="#ff6e6e"
    KITTY_C2="#50fa7b" KITTY_C10="#69ff94"
    KITTY_C3="#f1fa8c" KITTY_C11="#ffffa5"
    KITTY_C4="#bd93f9" KITTY_C12="#d6acff"
    KITTY_C5="#ff79c6" KITTY_C13="#ff92df"
    KITTY_C6="#8be9fd" KITTY_C14="#a4ffff"
    KITTY_C7="#f8f8f2" KITTY_C15="#ffffff"
    KITTY_CUR="#f8f8f2" KITTY_CUR_TEXT="#282a36"
    KITTY_SEL_FG="#f8f8f2" KITTY_SEL_BG="#44475a"
    KITTY_TAB_AFG="#282a36" KITTY_TAB_ABG="#bd93f9"
    KITTY_TAB_IFG="#6272a4" KITTY_TAB_IBG="#282a36" KITTY_TAB_BAR="#1e1f29"
    SWAYNC_BASE_R=40  SWAYNC_BASE_G=42  SWAYNC_BASE_B=54
    SWAYNC_SURF_R=68  SWAYNC_SURF_G=71  SWAYNC_SURF_B=90
    SWAYNC_MUT_R=98   SWAYNC_MUT_G=114  SWAYNC_MUT_B=164
    SWAYNC_TEXT="#f8f8f2"   SWAYNC_SUBTEXT="#bfbfbf"
    SWAYNC_LOVE="#ff5555"   SWAYNC_ROSE="#ff79c6"
    SWAYNC_FOAM="#8be9fd"   SWAYNC_PINE="#50fa7b"
    LOCK_BG_R=40   LOCK_BG_G=42   LOCK_BG_B=54
    LOCK_OUT1_R=189 LOCK_OUT1_G=147 LOCK_OUT1_B=249
    LOCK_OUT2_R=255 LOCK_OUT2_G=121 LOCK_OUT2_B=198
    LOCK_CHK1_R=139 LOCK_CHK1_G=233 LOCK_CHK1_B=253
    LOCK_CHK2_R=80  LOCK_CHK2_G=250 LOCK_CHK2_B=123
    LOCK_FAIL_R=255 LOCK_FAIL_G=85  LOCK_FAIL_B=85
    LOCK_FONT_R=248 LOCK_FONT_G=248 LOCK_FONT_B=242
    LOCK_TIME_R=248 LOCK_TIME_G=248 LOCK_TIME_B=242
    LOCK_DATE_R=139 LOCK_DATE_G=233 LOCK_DATE_B=253
    LOCK_WELC_R=189 LOCK_WELC_G=147 LOCK_WELC_B=249
    S_PALETTE="dracula"
    S_BG="#282a36" S_BGLIGHT="#44475a" S_BGVISUAL="#6272a4"
    S_FG="#f8f8f2" S_FGDIM="#6272a4"
    S_RED="#ff5555" S_ORANGE="#ffb86c" S_YELLOW="#f1fa8c"
    S_GREEN="#50fa7b" S_CYAN="#8be9fd" S_BLUE="#6272a4"
    S_VIOLET="#bd93f9" S_MAGENTA="#ff79c6"
}

set_theme_nord() {
    WAYBAR_FILE="nord.css"
    BORDER_ACTIVE="rgba(136,192,208,221) rgba(180,142,173,170) 45deg"
    BORDER_INACTIVE="rgba(59,66,82,170)"
    FUZZEL_BG="2e3440ee"   FUZZEL_FG="eceff4ff"  FUZZEL_SEL="3b4252ff"
    FUZZEL_SEL_FG="eceff4ff" FUZZEL_SEL_MATCH="ebcb8bff" FUZZEL_BORDER="88c0d0aa"
    FUZZEL_PROMPT="88c0d0ff" FUZZEL_PH="4c566aff" FUZZEL_INPUT="eceff4ff"
    FUZZEL_MATCH="ebcb8bff"  FUZZEL_COUNTER="b48eadff"
    KITTY_FG="#eceff4" KITTY_BG="#242933"
    KITTY_C0="#3b4252" KITTY_C8="#4c566a"
    KITTY_C1="#bf616a" KITTY_C9="#bf616a"
    KITTY_C2="#a3be8c" KITTY_C10="#a3be8c"
    KITTY_C3="#ebcb8b" KITTY_C11="#ebcb8b"
    KITTY_C4="#81a1c1" KITTY_C12="#88c0d0"
    KITTY_C5="#b48ead" KITTY_C13="#b48ead"
    KITTY_C6="#88c0d0" KITTY_C14="#8fbcbb"
    KITTY_C7="#e5e9f0" KITTY_C15="#eceff4"
    KITTY_CUR="#eceff4" KITTY_CUR_TEXT="#2e3440"
    KITTY_SEL_FG="#eceff4" KITTY_SEL_BG="#434c5e"
    KITTY_TAB_AFG="#2e3440" KITTY_TAB_ABG="#88c0d0"
    KITTY_TAB_IFG="#4c566a" KITTY_TAB_IBG="#3b4252" KITTY_TAB_BAR="#242933"
    SWAYNC_BASE_R=46  SWAYNC_BASE_G=52  SWAYNC_BASE_B=64
    SWAYNC_SURF_R=59  SWAYNC_SURF_G=66  SWAYNC_SURF_B=82
    SWAYNC_MUT_R=76   SWAYNC_MUT_G=86   SWAYNC_MUT_B=106
    SWAYNC_TEXT="#eceff4"   SWAYNC_SUBTEXT="#d8dee9"
    SWAYNC_LOVE="#bf616a"   SWAYNC_ROSE="#b48ead"
    SWAYNC_FOAM="#88c0d0"   SWAYNC_PINE="#81a1c1"
    LOCK_BG_R=46   LOCK_BG_G=52   LOCK_BG_B=64
    LOCK_OUT1_R=136 LOCK_OUT1_G=192 LOCK_OUT1_B=208
    LOCK_OUT2_R=180 LOCK_OUT2_G=142 LOCK_OUT2_B=173
    LOCK_CHK1_R=143 LOCK_CHK1_G=188 LOCK_CHK1_B=187
    LOCK_CHK2_R=163 LOCK_CHK2_G=190 LOCK_CHK2_B=140
    LOCK_FAIL_R=191 LOCK_FAIL_G=97  LOCK_FAIL_B=106
    LOCK_FONT_R=236 LOCK_FONT_G=239 LOCK_FONT_B=244
    LOCK_TIME_R=236 LOCK_TIME_G=239 LOCK_TIME_B=244
    LOCK_DATE_R=136 LOCK_DATE_G=192 LOCK_DATE_B=208
    LOCK_WELC_R=180 LOCK_WELC_G=142 LOCK_WELC_B=173
    S_PALETTE="nord"
    S_BG="#2e3440" S_BGLIGHT="#3b4252" S_BGVISUAL="#434c5e"
    S_FG="#eceff4" S_FGDIM="#4c566a"
    S_RED="#bf616a" S_ORANGE="#d08770" S_YELLOW="#ebcb8b"
    S_GREEN="#a3be8c" S_CYAN="#8fbcbb" S_BLUE="#81a1c1"
    S_VIOLET="#b48ead" S_MAGENTA="#b48ead"
}

set_theme_obsidian() {
    WAYBAR_FILE="obsidian.css"
    BORDER_ACTIVE="rgba(201,160,64,221) rgba(152,120,200,170) 45deg"
    BORDER_INACTIVE="rgba(74,74,106,170)"
    FUZZEL_BG="0e0e16ee"   FUZZEL_FG="e8e2f8ff"  FUZZEL_SEL="1e1e36ff"
    FUZZEL_SEL_FG="e8e2f8ff" FUZZEL_SEL_MATCH="c9a040ff" FUZZEL_BORDER="9878c8aa"
    FUZZEL_PROMPT="c9a040ff" FUZZEL_PH="4a4a6aff" FUZZEL_INPUT="e8e2f8ff"
    FUZZEL_MATCH="c9a040ff"  FUZZEL_COUNTER="9878c8ff"
    KITTY_FG="#e8e2f8" KITTY_BG="#060610"
    KITTY_C0="#1e1e36" KITTY_C8="#4a4a6a"
    KITTY_C1="#d06080" KITTY_C9="#e07090"
    KITTY_C2="#7aab8a" KITTY_C10="#8abba0"
    KITTY_C3="#c9a040" KITTY_C11="#e0b850"
    KITTY_C4="#7aaab8" KITTY_C12="#8abcd0"
    KITTY_C5="#9878c8" KITTY_C13="#b090e0"
    KITTY_C6="#7aaab8" KITTY_C14="#90bcc8"
    KITTY_C7="#c8c0e0" KITTY_C15="#e8e2f8"
    KITTY_CUR="#c9a040" KITTY_CUR_TEXT="#0e0e16"
    KITTY_SEL_FG="#e8e2f8" KITTY_SEL_BG="#1e1e36"
    KITTY_TAB_AFG="#0e0e16" KITTY_TAB_ABG="#9878c8"
    KITTY_TAB_IFG="#4a4a6a" KITTY_TAB_IBG="#16162a" KITTY_TAB_BAR="#060610"
    SWAYNC_BASE_R=14  SWAYNC_BASE_G=14  SWAYNC_BASE_B=22
    SWAYNC_SURF_R=22  SWAYNC_SURF_G=22  SWAYNC_SURF_B=42
    SWAYNC_MUT_R=74   SWAYNC_MUT_G=74   SWAYNC_MUT_B=106
    SWAYNC_TEXT="#e8e2f8"   SWAYNC_SUBTEXT="#9898c8"
    SWAYNC_LOVE="#d06080"   SWAYNC_ROSE="#c08888"
    SWAYNC_FOAM="#7aaab8"   SWAYNC_PINE="#c9a040"
    LOCK_BG_R=14   LOCK_BG_G=14   LOCK_BG_B=22
    LOCK_OUT1_R=201 LOCK_OUT1_G=160 LOCK_OUT1_B=64
    LOCK_OUT2_R=152 LOCK_OUT2_G=120 LOCK_OUT2_B=200
    LOCK_CHK1_R=122 LOCK_CHK1_G=171 LOCK_CHK1_B=138
    LOCK_CHK2_R=122 LOCK_CHK2_G=170 LOCK_CHK2_B=184
    LOCK_FAIL_R=208 LOCK_FAIL_G=96  LOCK_FAIL_B=128
    LOCK_FONT_R=232 LOCK_FONT_G=226 LOCK_FONT_B=248
    LOCK_TIME_R=201 LOCK_TIME_G=160 LOCK_TIME_B=64
    LOCK_DATE_R=122 LOCK_DATE_G=170 LOCK_DATE_B=184
    LOCK_WELC_R=152 LOCK_WELC_G=120 LOCK_WELC_B=200
    S_PALETTE="obsidian"
    S_BG="#0e0e16" S_BGLIGHT="#16162a" S_BGVISUAL="#28285a"
    S_FG="#e8e2f8" S_FGDIM="#4a4a6a"
    S_RED="#d06080" S_ORANGE="#c9a040" S_YELLOW="#c9a040"
    S_GREEN="#7aab8a" S_CYAN="#7aaab8" S_BLUE="#7aaab8"
    S_VIOLET="#9878c8" S_MAGENTA="#c08888"
}

set_theme_aurora() {
    WAYBAR_FILE="aurora.css"
    BORDER_ACTIVE="rgba(0,200,240,221) rgba(96,80,240,170) 45deg"
    BORDER_INACTIVE="rgba(48,64,96,170)"
    FUZZEL_BG="080d1aee"   FUZZEL_FG="c8e0f8ff"  FUZZEL_SEL="182136ff"
    FUZZEL_SEL_FG="c8e0f8ff" FUZZEL_SEL_MATCH="f8c040ff" FUZZEL_BORDER="00c8f0aa"
    FUZZEL_PROMPT="00c8f0ff" FUZZEL_PH="304060ff" FUZZEL_INPUT="c8e0f8ff"
    FUZZEL_MATCH="00d878ff"  FUZZEL_COUNTER="6050f0ff"
    KITTY_FG="#c8e0f8" KITTY_BG="#040810"
    KITTY_C0="#101528" KITTY_C8="#304060"
    KITTY_C1="#e84080" KITTY_C9="#ff60a0"
    KITTY_C2="#00d878" KITTY_C10="#20f090"
    KITTY_C3="#f8c040" KITTY_C11="#ffd060"
    KITTY_C4="#4060d0" KITTY_C12="#00c8f0"
    KITTY_C5="#6050f0" KITTY_C13="#c060e8"
    KITTY_C6="#00c8f0" KITTY_C14="#40e8ff"
    KITTY_C7="#a0c8e8" KITTY_C15="#c8e0f8"
    KITTY_CUR="#00c8f0" KITTY_CUR_TEXT="#080d1a"
    KITTY_SEL_FG="#c8e0f8" KITTY_SEL_BG="#182136"
    KITTY_TAB_AFG="#080d1a" KITTY_TAB_ABG="#6050f0"
    KITTY_TAB_IFG="#486080" KITTY_TAB_IBG="#101528" KITTY_TAB_BAR="#040810"
    SWAYNC_BASE_R=8   SWAYNC_BASE_G=13  SWAYNC_BASE_B=26
    SWAYNC_SURF_R=16  SWAYNC_SURF_G=21  SWAYNC_SURF_B=40
    SWAYNC_MUT_R=48   SWAYNC_MUT_G=64   SWAYNC_MUT_B=96
    SWAYNC_TEXT="#c8e0f8"   SWAYNC_SUBTEXT="#6080b0"
    SWAYNC_LOVE="#e84080"   SWAYNC_ROSE="#c060e8"
    SWAYNC_FOAM="#00c8f0"   SWAYNC_PINE="#00d878"
    LOCK_BG_R=8    LOCK_BG_G=13   LOCK_BG_B=26
    LOCK_OUT1_R=0   LOCK_OUT1_G=200 LOCK_OUT1_B=240
    LOCK_OUT2_R=96  LOCK_OUT2_G=80  LOCK_OUT2_B=240
    LOCK_CHK1_R=0   LOCK_CHK1_G=216 LOCK_CHK1_B=120
    LOCK_CHK2_R=192 LOCK_CHK2_G=96  LOCK_CHK2_B=232
    LOCK_FAIL_R=232 LOCK_FAIL_G=64  LOCK_FAIL_B=128
    LOCK_FONT_R=200 LOCK_FONT_G=224 LOCK_FONT_B=248
    LOCK_TIME_R=0   LOCK_TIME_G=200 LOCK_TIME_B=240
    LOCK_DATE_R=0   LOCK_DATE_G=216 LOCK_DATE_B=120
    LOCK_WELC_R=96  LOCK_WELC_G=80  LOCK_WELC_B=240
    S_PALETTE="aurora"
    S_BG="#080d1a" S_BGLIGHT="#101528" S_BGVISUAL="#203050"
    S_FG="#c8e0f8" S_FGDIM="#304060"
    S_RED="#e84080" S_ORANGE="#f8c040" S_YELLOW="#f8c040"
    S_GREEN="#00d878" S_CYAN="#00c8f0" S_BLUE="#4060d0"
    S_VIOLET="#6050f0" S_MAGENTA="#c060e8"
}

set_theme_ember() {
    WAYBAR_FILE="ember.css"
    BORDER_ACTIVE="rgba(224,148,12,221) rgba(184,120,168,170) 45deg"
    BORDER_INACTIVE="rgba(96,64,48,170)"
    FUZZEL_BG="181008ee"   FUZZEL_FG="f0dcc8ff"  FUZZEL_SEL="2e2016ff"
    FUZZEL_SEL_FG="f0dcc8ff" FUZZEL_SEL_MATCH="e0940cff" FUZZEL_BORDER="e0940caa"
    FUZZEL_PROMPT="e0940cff" FUZZEL_PH="604030ff" FUZZEL_INPUT="f0dcc8ff"
    FUZZEL_MATCH="e04830ff"  FUZZEL_COUNTER="b878a8ff"
    KITTY_FG="#f0dcc8" KITTY_BG="#0e0804"
    KITTY_C0="#2e2016" KITTY_C8="#604030"
    KITTY_C1="#e04830" KITTY_C9="#f06040"
    KITTY_C2="#80a850" KITTY_C10="#98c060"
    KITTY_C3="#e0940c" KITTY_C11="#f8a820"
    KITTY_C4="#7bacd4" KITTY_C12="#90bce0"
    KITTY_C5="#b878a8" KITTY_C13="#d090c0"
    KITTY_C6="#60a890" KITTY_C14="#78c0a8"
    KITTY_C7="#d8c0a8" KITTY_C15="#f0dcc8"
    KITTY_CUR="#e0940c" KITTY_CUR_TEXT="#181008"
    KITTY_SEL_FG="#f0dcc8" KITTY_SEL_BG="#2e2016"
    KITTY_TAB_AFG="#181008" KITTY_TAB_ABG="#b878a8"
    KITTY_TAB_IFG="#604030" KITTY_TAB_IBG="#221810" KITTY_TAB_BAR="#0e0804"
    SWAYNC_BASE_R=24  SWAYNC_BASE_G=16  SWAYNC_BASE_B=8
    SWAYNC_SURF_R=34  SWAYNC_SURF_G=24  SWAYNC_SURF_B=16
    SWAYNC_MUT_R=96   SWAYNC_MUT_G=64   SWAYNC_MUT_B=48
    SWAYNC_TEXT="#f0dcc8"   SWAYNC_SUBTEXT="#b89070"
    SWAYNC_LOVE="#e04830"   SWAYNC_ROSE="#d08070"
    SWAYNC_FOAM="#60a890"   SWAYNC_PINE="#e0940c"
    LOCK_BG_R=24   LOCK_BG_G=16   LOCK_BG_B=8
    LOCK_OUT1_R=224 LOCK_OUT1_G=148 LOCK_OUT1_B=12
    LOCK_OUT2_R=184 LOCK_OUT2_G=120 LOCK_OUT2_B=168
    LOCK_CHK1_R=128 LOCK_CHK1_G=168 LOCK_CHK1_B=80
    LOCK_CHK2_R=96  LOCK_CHK2_G=168 LOCK_CHK2_B=144
    LOCK_FAIL_R=224 LOCK_FAIL_G=72  LOCK_FAIL_B=48
    LOCK_FONT_R=240 LOCK_FONT_G=220 LOCK_FONT_B=200
    LOCK_TIME_R=224 LOCK_TIME_G=148 LOCK_TIME_B=12
    LOCK_DATE_R=96  LOCK_DATE_G=168 LOCK_DATE_B=144
    LOCK_WELC_R=184 LOCK_WELC_G=120 LOCK_WELC_B=168
    S_PALETTE="ember"
    S_BG="#181008" S_BGLIGHT="#221810" S_BGVISUAL="#382818"
    S_FG="#f0dcc8" S_FGDIM="#604030"
    S_RED="#e04830" S_ORANGE="#e0940c" S_YELLOW="#e0940c"
    S_GREEN="#80a850" S_CYAN="#60a890" S_BLUE="#7bacd4"
    S_VIOLET="#b878a8" S_MAGENTA="#d08070"
}

set_theme_absolute-black() {
    WAYBAR_FILE="absolute-black.css"
    BORDER_ACTIVE="rgba(0,212,255,221) rgba(85,136,204,170) 45deg"
    BORDER_INACTIVE="rgba(28,28,28,170)"
    FUZZEL_BG="101010ee"   FUZZEL_FG="e2e2e2ff"  FUZZEL_SEL="1c1c1cff"
    FUZZEL_SEL_FG="e2e2e2ff" FUZZEL_SEL_MATCH="00d4ffff" FUZZEL_BORDER="00d4ff88"
    FUZZEL_PROMPT="00d4ffff" FUZZEL_PH="505050ff" FUZZEL_INPUT="e2e2e2ff"
    FUZZEL_MATCH="00d4ffff"  FUZZEL_COUNTER="5588ccff"
    KITTY_FG="#e2e2e2" KITTY_BG="#080808"
    KITTY_C0="#1c1c1c" KITTY_C8="#505050"
    KITTY_C1="#ff4455" KITTY_C9="#ff6677"
    KITTY_C2="#00d4aa" KITTY_C10="#20f0c0"
    KITTY_C3="#00d4ff" KITTY_C11="#40e8ff"
    KITTY_C4="#5588cc" KITTY_C12="#00d4ff"
    KITTY_C5="#8866cc" KITTY_C13="#aa88ee"
    KITTY_C6="#00aad4" KITTY_C14="#00d4ff"
    KITTY_C7="#b0b0b0" KITTY_C15="#e2e2e2"
    KITTY_CUR="#00d4ff" KITTY_CUR_TEXT="#080808"
    KITTY_SEL_FG="#e2e2e2" KITTY_SEL_BG="#1c1c1c"
    KITTY_TAB_AFG="#080808" KITTY_TAB_ABG="#00d4ff"
    KITTY_TAB_IFG="#505050" KITTY_TAB_IBG="#101010" KITTY_TAB_BAR="#080808"
    SWAYNC_BASE_R=8   SWAYNC_BASE_G=8   SWAYNC_BASE_B=8
    SWAYNC_SURF_R=16  SWAYNC_SURF_G=16  SWAYNC_SURF_B=16
    SWAYNC_MUT_R=56   SWAYNC_MUT_G=56   SWAYNC_MUT_B=56
    SWAYNC_TEXT="#e2e2e2"   SWAYNC_SUBTEXT="#808080"
    SWAYNC_LOVE="#ff4455"   SWAYNC_ROSE="#80e8ff"
    SWAYNC_FOAM="#00d4ff"   SWAYNC_PINE="#00aad4"
    LOCK_BG_R=8    LOCK_BG_G=8    LOCK_BG_B=8
    LOCK_OUT1_R=0   LOCK_OUT1_G=212 LOCK_OUT1_B=255
    LOCK_OUT2_R=85  LOCK_OUT2_G=136 LOCK_OUT2_B=204
    LOCK_CHK1_R=0   LOCK_CHK1_G=212 LOCK_CHK1_B=170
    LOCK_CHK2_R=0   LOCK_CHK2_G=170 LOCK_CHK2_B=212
    LOCK_FAIL_R=255 LOCK_FAIL_G=68  LOCK_FAIL_B=85
    LOCK_FONT_R=226 LOCK_FONT_G=226 LOCK_FONT_B=226
    LOCK_TIME_R=0   LOCK_TIME_G=212 LOCK_TIME_B=255
    LOCK_DATE_R=0   LOCK_DATE_G=170 LOCK_DATE_B=212
    LOCK_WELC_R=85  LOCK_WELC_G=136 LOCK_WELC_B=204
    S_PALETTE="void"
    S_BG="#080808" S_BGLIGHT="#1c1c1c" S_BGVISUAL="#383838"
    S_FG="#e2e2e2" S_FGDIM="#505050"
    S_RED="#ff4455" S_ORANGE="#00d4ff" S_YELLOW="#00d4ff"
    S_GREEN="#00d4aa" S_CYAN="#00d4ff" S_BLUE="#5588cc"
    S_VIOLET="#8866cc" S_MAGENTA="#80e8ff"
}

# ─── GET CURRENT THEME STRUCTURAL COLORS (for Starship sed) ──────────────────
get_current_starship_colors() {
    "set_theme_${current}"
    OLD_BG="$S_BG" OLD_BGLIGHT="$S_BGLIGHT" OLD_BGVISUAL="$S_BGVISUAL"
    OLD_FG="$S_FG" OLD_FGDIM="$S_FGDIM"
    OLD_RED="$S_RED" OLD_ORANGE="$S_ORANGE" OLD_YELLOW="$S_YELLOW"
    OLD_GREEN="$S_GREEN" OLD_CYAN="$S_CYAN" OLD_BLUE="$S_BLUE"
    OLD_VIOLET="$S_VIOLET" OLD_MAGENTA="$S_MAGENTA"
}

# ─── APPLY FUNCTIONS ──────────────────────────────────────────────────────────

apply_waybar() {
    sed -i "s|@import \".*\.css\";|@import \"$WAYBAR_FILE\";|" "$WAYBAR_CSS"
    sed -i "s|@define-color\|/\* Cambia entre.*\*/||g" "$WAYBAR_CSS" 2>/dev/null || true
}

apply_waybar_mango() {
    sed -i "s|@import \".*\.css\";|@import \"$WAYBAR_FILE\";|" "$WAYBAR_MANGO_CSS"
}

apply_hyprland() {
    sed -i \
        "s|col\.active_border = .*|col.active_border = $BORDER_ACTIVE|" \
        "$HYPR_CONF"
    sed -i \
        "s|col\.inactive_border = .*|col.inactive_border = $BORDER_INACTIVE|" \
        "$HYPR_CONF"
    # Apply in-memory immediately (no restart needed)
    hyprctl keyword general:col.active_border "$BORDER_ACTIVE" 2>/dev/null || true
    hyprctl keyword general:col.inactive_border "$BORDER_INACTIVE" 2>/dev/null || true
}

apply_fuzzel() {
    sed -i \
        "/^\[colors\]/,/^\[/ {
            s/^background=.*/background=$FUZZEL_BG/
            s/^text=.*/text=$FUZZEL_FG/
            s/^selection=.*/selection=$FUZZEL_SEL/
            s/^selection-text=.*/selection-text=$FUZZEL_SEL_FG/
            s/^selection-match=.*/selection-match=$FUZZEL_SEL_MATCH/
            s/^border=.*/border=$FUZZEL_BORDER/
            s/^prompt=.*/prompt=$FUZZEL_PROMPT/
            s/^placeholder=.*/placeholder=$FUZZEL_PH/
            s/^input=.*/input=$FUZZEL_INPUT/
            s/^match=.*/match=$FUZZEL_MATCH/
            s/^counter=.*/counter=$FUZZEL_COUNTER/
        }" "$FUZZEL_CONF"
}

apply_kitty() {
    cat > "$KITTY_CONF" << EOF
# $next theme
window_padding_width 10

# Special
foreground $KITTY_FG
background $KITTY_BG

# Black
color0  $KITTY_C0
color8  $KITTY_C8

# Red
color1  $KITTY_C1
color9  $KITTY_C9

# Green
color2  $KITTY_C2
color10 $KITTY_C10

# Yellow
color3  $KITTY_C3
color11 $KITTY_C11

# Blue
color4  $KITTY_C4
color12 $KITTY_C12

# Magenta
color5  $KITTY_C5
color13 $KITTY_C13

# Cyan
color6  $KITTY_C6
color14 $KITTY_C14

# White
color7  $KITTY_C7
color15 $KITTY_C15

# Cursor
cursor              $KITTY_CUR
cursor_text_color   $KITTY_CUR_TEXT

# Selection
selection_foreground $KITTY_SEL_FG
selection_background $KITTY_SEL_BG

# Tab bar
active_tab_foreground   $KITTY_TAB_AFG
active_tab_background   $KITTY_TAB_ABG
active_tab_font_style   bold
inactive_tab_foreground $KITTY_TAB_IFG
inactive_tab_background $KITTY_TAB_IBG
inactive_tab_font_style normal
tab_bar_background      $KITTY_TAB_BAR
tab_bar_margin_width    0.0
tab_bar_margin_height   6.0 2.0
EOF
}

apply_swaync() {
    cat > "$SWAYNC_CSS" << EOF
* {
  all: unset;
  font-family: FiraCode Nerd Font;
  transition: 0.3s;
  font-size: 1.1rem;
}

.floating-notifications.background .notification-row {
  padding: 0.75rem;
}

.floating-notifications.background .notification-row .notification-background {
  border-radius: 0.5rem;
  background-color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.7);
  color: $SWAYNC_TEXT;
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
}

.floating-notifications.background .notification-row .notification-background .notification {
  padding: 0.5rem;
  border-radius: 0.5rem;
}

.floating-notifications.background .notification-row .notification-background .notification.critical {
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.8);
}

.floating-notifications.background .notification-row .notification-background .notification .notification-content .summary {
  margin: 0.5rem;
  color: $SWAYNC_TEXT;
  font-weight: bold;
}

.floating-notifications.background .notification-row .notification-background .notification .notification-content .body {
  margin: 0.5rem;
  color: $SWAYNC_SUBTEXT;
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * {
  min-height: 2.5rem;
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action {
  border-radius: 0.5rem;
  color: $SWAYNC_TEXT;
  background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.8);
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
  background-color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.9);
}

.floating-notifications.background .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
  background-color: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.9);
}

.floating-notifications.background .notification-row .notification-background .close-button {
  margin: 0.5rem;
  padding: 0.25rem;
  border-radius: 0.5rem;
  color: $SWAYNC_TEXT;
  background-color: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.9);
}

.floating-notifications.background .notification-row .notification-background .close-button:hover {
  color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 1);
}

.floating-notifications.background .notification-row .notification-background .close-button:active {
  background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.9);
}

.control-center {
  border-radius: 0.5rem;
  margin: 0.75rem;
  background-color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.8);
  color: $SWAYNC_TEXT;
  padding: 0.75rem;
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
}

.control-center .widget-title {
  color: $SWAYNC_ROSE;
  font-weight: bold;
}

.control-center .widget-title button {
  border-radius: 0.5rem;
  color: $SWAYNC_TEXT;
  background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.8);
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
  padding: 0.5rem;
}

.control-center .widget-title button:hover {
  background-color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.9);
}

.control-center .widget-title button:active {
  background-color: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.9);
}

.control-center .notification-row .notification-background {
  border-radius: 0.5rem;
  margin: 0.5rem 0;
  background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.8);
  color: $SWAYNC_TEXT;
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
}

.control-center .notification-row .notification-background .notification {
  padding: 0.5rem;
  border-radius: 0.5rem;
}

.control-center .notification-row .notification-background .notification.critical {
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.8);
}

.control-center .notification-row .notification-background .notification .notification-content .summary {
  margin: 0.5rem;
  color: $SWAYNC_TEXT;
  font-weight: bold;
}

.control-center .notification-row .notification-background .notification .notification-content .body {
  margin: 0.5rem;
  color: $SWAYNC_SUBTEXT;
}

.control-center .notification-row .notification-background .notification > *:last-child > * {
  min-height: 2.5rem;
}

.control-center .notification-row .notification-background .notification > *:last-child > * .notification-action {
  border-radius: 0.5rem;
  color: $SWAYNC_TEXT;
  background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.8);
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
}

.control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:hover {
  background-color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.9);
}

.control-center .notification-row .notification-background .notification > *:last-child > * .notification-action:active {
  background-color: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.9);
}

.control-center .notification-row .notification-background .close-button {
  margin: 0.5rem;
  padding: 0.25rem;
  border-radius: 0.5rem;
  color: $SWAYNC_TEXT;
  background-color: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.9);
}

.control-center .notification-row .notification-background .close-button:hover {
  color: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 1);
}

.control-center .notification-row .notification-background .close-button:active {
  background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.9);
}

progressbar, progress, trough { border-radius: 0.5rem; }

.notification.critical progress { background-color: $SWAYNC_LOVE; }
.notification.low progress, .notification.normal progress { background-color: $SWAYNC_FOAM; }

trough { background-color: rgba($SWAYNC_SURF_R, $SWAYNC_SURF_G, $SWAYNC_SURF_B, 0.8); }
.control-center trough { background-color: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.8); }

.control-center-dnd { margin: 0.75rem 0; border-radius: 0.5rem; }
.control-center-dnd slider { background: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.9); border-radius: 0.5rem; }

.widget-dnd { color: $SWAYNC_SUBTEXT; }
.widget-dnd > switch {
  border-radius: 0.5rem;
  background: rgba($SWAYNC_BASE_R, $SWAYNC_BASE_G, $SWAYNC_BASE_B, 0.9);
  border: 0.5px solid rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.6);
}
.widget-dnd > switch:checked slider { background: $SWAYNC_PINE; }
.widget-dnd > switch slider {
  background: rgba($SWAYNC_MUT_R, $SWAYNC_MUT_G, $SWAYNC_MUT_B, 0.8);
  border-radius: 0.5rem;
  margin: 0.25rem;
}
EOF
}

apply_hyprlock() {
    cat > "$LOCK_CONF" << EOF
background {
    path = /home/shaddai/Backgrounds/dune2.jpg
    blur_passes = 2
    opacity = 0.8
    color = rgba($LOCK_BG_R,$LOCK_BG_G,$LOCK_BG_B,1.0)
}

input-field {
    size = 22%, 6%
    outline_thickness = 2
    inner_color = rgba($LOCK_BG_R,$LOCK_BG_G,$LOCK_BG_B,0.7)
    outer_color = rgba($LOCK_OUT1_R,$LOCK_OUT1_G,$LOCK_OUT1_B,0.5) rgba($LOCK_OUT2_R,$LOCK_OUT2_G,$LOCK_OUT2_B,0.5) 45deg
    check_color = rgba($LOCK_CHK1_R,$LOCK_CHK1_G,$LOCK_CHK1_B,0.5) rgba($LOCK_CHK2_R,$LOCK_CHK2_G,$LOCK_CHK2_B,0.5) 120deg
    fail_color = rgba($LOCK_FAIL_R,$LOCK_FAIL_G,$LOCK_FAIL_B,0.5) rgba($LOCK_OUT2_R,$LOCK_OUT2_G,$LOCK_OUT2_B,0.5) 40deg
    font_color = rgba($LOCK_FONT_R,$LOCK_FONT_G,$LOCK_FONT_B,1.0)
    fade_on_empty = false
    rounding = 20
    position = 0, -80
    halign = center
    valign = center
    placeholder_text = "Enter password…"
    placeholder_color = rgba($SWAYNC_MUT_R,$SWAYNC_MUT_G,$SWAYNC_MUT_B,0.8)
    font_family = "JetBrainsMono Nerd Font"
    fail_color = rgba($LOCK_FAIL_R,$LOCK_FAIL_G,$LOCK_FAIL_B,1.0)
    fail_text = "<i><span foreground='red'>  Error </span></i>"
    fail_transition = 300
}

label {
    text = "\$TIME12"
    font_size = 64
    color = rgba($LOCK_TIME_R,$LOCK_TIME_G,$LOCK_TIME_B,1.0)
    font_family = "JetBrainsMono Nerd Font"
    position = 0, 60
    halign = center
    valign = center
}

label {
    text = cmd[update:1000] date "+%Y-%m-%d"
    font_size = 24
    color = rgba($LOCK_DATE_R,$LOCK_DATE_G,$LOCK_DATE_B,1.0)
    font_family = "JetBrainsMono Nerd Font"
    position = 0, 120
    halign = center
    valign = center
}

label {
    text = "Welcome Shaddai"
    font_size = 22
    color = rgba($LOCK_WELC_R,$LOCK_WELC_G,$LOCK_WELC_B,1.0)
    font_family = "JetBrainsMono Nerd Font"
    position = 0, 180
    halign = center
    valign = center
}
EOF
}

apply_swaylock() {
    local BG=$(printf '%02x%02x%02xff' $LOCK_BG_R $LOCK_BG_G $LOCK_BG_B)
    local BG_T=$(printf '%02x%02x%02x80' $LOCK_BG_R $LOCK_BG_G $LOCK_BG_B)
    local OUT1=$(printf '%02x%02x%02xff' $LOCK_OUT1_R $LOCK_OUT1_G $LOCK_OUT1_B)
    local OUT2=$(printf '%02x%02x%02xff' $LOCK_OUT2_R $LOCK_OUT2_G $LOCK_OUT2_B)
    local CHK1=$(printf '%02x%02x%02xff' $LOCK_CHK1_R $LOCK_CHK1_G $LOCK_CHK1_B)
    local FAIL=$(printf '%02x%02x%02xff' $LOCK_FAIL_R $LOCK_FAIL_G $LOCK_FAIL_B)
    local FONT=$(printf '%02x%02x%02xff' $LOCK_FONT_R $LOCK_FONT_G $LOCK_FONT_B)
    local WELC=$(printf '%02x%02x%02xff' $LOCK_WELC_R $LOCK_WELC_G $LOCK_WELC_B)

    cat > "$SWAYLOCK_CONF" << EOF
# Generated by theme-switch.sh — $next
screenshots
effect-blur=8x5
effect-vignette=0.4:0.8
clock
timestr=%H:%M
datestr=%Y-%m-%d
font=JetBrainsMono Nerd Font
font-size=32
indicator-radius=100
indicator-thickness=8

color=${BG}

inside-color=${BG_T}
inside-ver-color=${BG_T}
inside-wrong-color=${BG_T}
inside-clear-color=${BG_T}

ring-color=${OUT1}
ring-ver-color=${CHK1}
ring-wrong-color=${FAIL}
ring-clear-color=${OUT2}

key-hl-color=${WELC}
bs-hl-color=${FAIL}
separator-color=00000000

text-color=${FONT}
text-ver-color=${FONT}
text-wrong-color=${FAIL}
text-clear-color=${FONT}

line-color=00000000
line-ver-color=00000000
line-wrong-color=00000000
line-clear-color=00000000
EOF
}

apply_starship() {
    # Replace palette name
    sed -i "s/^palette = '.*'/palette = '$S_PALETTE'/" "$STARSHIP_CONF"
    # Replace palette section name
    sed -i "s/^\[palettes\.[a-z_]*\]$/[palettes.$S_PALETTE]/" "$STARSHIP_CONF"
    # Update palette values
    sed -i "s|^bg_dark.*|bg_dark   = '${S_BG}'|" "$STARSHIP_CONF"
    sed -i "s|^bg        =.*|bg        = '${S_BG}'|" "$STARSHIP_CONF"
    sed -i "s|^bg_light.*|bg_light  = '${S_BGLIGHT}'|" "$STARSHIP_CONF"
    sed -i "s|^bg_visual.*|bg_visual = '${S_BGVISUAL}'|" "$STARSHIP_CONF"
    sed -i "s|^fg        =.*|fg        = '${S_FG}'|" "$STARSHIP_CONF"
    sed -i "s|^fg_dim.*|fg_dim    = '${S_FGDIM}'|" "$STARSHIP_CONF"
    sed -i "s|^fg_reverse.*|fg_reverse = '${S_BG}'|" "$STARSHIP_CONF"
    sed -i "s|^red       =.*|red       = '${S_RED}'|" "$STARSHIP_CONF"
    sed -i "s|^orange.*|orange    = '${S_ORANGE}'|" "$STARSHIP_CONF"
    sed -i "s|^yellow.*|yellow    = '${S_YELLOW}'|" "$STARSHIP_CONF"
    sed -i "s|^green.*|green     = '${S_GREEN}'|" "$STARSHIP_CONF"
    sed -i "s|^cyan.*|cyan      = '${S_CYAN}'|" "$STARSHIP_CONF"
    sed -i "s|^blue.*|blue      = '${S_BLUE}'|" "$STARSHIP_CONF"
    sed -i "s|^violet.*|violet    = '${S_VIOLET}'|" "$STARSHIP_CONF"
    sed -i "s|^magenta.*|magenta   = '${S_MAGENTA}'|" "$STARSHIP_CONF"
    # Replace structural colors in format strings (old → new)
    sed -i \
        "s/${OLD_BG//\#/\\#}/${S_BG//\#/\\#}/g;
         s/${OLD_BGLIGHT//\#/\\#}/${S_BGLIGHT//\#/\\#}/g;
         s/${OLD_BGVISUAL//\#/\\#}/${S_BGVISUAL//\#/\\#}/g;
         s/${OLD_FG//\#/\\#}/${S_FG//\#/\\#}/g;
         s/${OLD_RED//\#/\\#}/${S_RED//\#/\\#}/g;
         s/${OLD_ORANGE//\#/\\#}/${S_ORANGE//\#/\\#}/g;
         s/${OLD_YELLOW//\#/\\#}/${S_YELLOW//\#/\\#}/g;
         s/${OLD_GREEN//\#/\\#}/${S_GREEN//\#/\\#}/g;
         s/${OLD_CYAN//\#/\\#}/${S_CYAN//\#/\\#}/g;
         s/${OLD_BLUE//\#/\\#}/${S_BLUE//\#/\\#}/g;
         s/${OLD_VIOLET//\#/\\#}/${S_VIOLET//\#/\\#}/g" \
        "$STARSHIP_CONF"
}

# ─── RELOAD APPS ──────────────────────────────────────────────────────────────

reload_apps() {
    pkill -SIGUSR2 waybar 2>/dev/null || true
    swaync-client --reload-config 2>/dev/null || true
    sleep 0.3
    pkill -SIGRTMIN+8 waybar 2>/dev/null || true
}

# ─── MAIN ─────────────────────────────────────────────────────────────────────

# Load current theme colors (for Starship sed replacements)
get_current_starship_colors

# Load next theme colors
"set_theme_${next}"

# Apply to all apps
apply_waybar
apply_waybar_mango
apply_hyprland
apply_fuzzel
apply_kitty
apply_swaync
apply_hyprlock
apply_swaylock
apply_starship

# Save state
echo "$next" > "$STATE_FILE"

# Reload apps
reload_apps

echo "✓ Theme applied: $next"
