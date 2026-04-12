/* =========================================================
 * dwl config.h — basado en la config de Hyprland de Shaddai
 * =========================================================
 * INSTRUCCIONES:
 *   Copia este archivo al directorio fuente de dwl como config.h
 *   antes de compilar con: make && sudo make install
 *
 * PATCHES RECOMENDADOS para funcionalidad completa:
 *   - vanitygaps   → gaps entre ventanas
 *   - autostart    → ejecutar autostart.sh al inicio
 *   - focusdir     → navegación por dirección (←→↑↓)
 *   - attachbottom → nuevas ventanas al fondo del stack
 * ========================================================= */

/* --- Apariencia ----------------------------------------- */

/* COLOR(RRGGBBAA) en hex */
#define COLOR(hex) { \
    ((hex >> 24) & 0xFF) / 255.0f, \
    ((hex >> 16) & 0xFF) / 255.0f, \
    ((hex >> 8)  & 0xFF) / 255.0f, \
    (hex & 0xFF) / 255.0f \
}

static const int sloppyfocus               = 1;   /* focus sigue al ratón */
static const int bypass_surface_visibility = 0;
static const unsigned int borderpx         = 2;   /* borde en píxeles */

/* Hyprland: active  rgba(0,212,255,221) → #00d4ffdd */
/* Hyprland: inactive rgba(28,28,28,170) → #1c1c1caa */
static const float bordercolor[]  = COLOR(0x1c1c1cff); /* inactivo */
static const float focuscolor[]   = COLOR(0x00d4ffdd); /* activo (cian) */
static const float urgentcolor[]  = COLOR(0xff5555ff); /* urgente */
static const float fullscreen_bg[] = { 0.07f, 0.07f, 0.07f, 1.0f };

/* --- Gaps (requiere patch vanitygaps) ------------------- */
static const unsigned int gappih  = 5;   /* gap horizontal interior */
static const unsigned int gappiv  = 5;   /* gap vertical interior */
static const unsigned int gappoh  = 10;  /* gap horizontal exterior */
static const unsigned int gappov  = 10;  /* gap vertical exterior */
static const int smartgaps        = 1;   /* sin gaps si hay 1 sola ventana */

/* --- Tags ----------------------------------------------- */
/* DWL usa 9 tags (bitmask). El workspace 10 de Hyprland se descarta. */
#define TAGCOUNT (9)

/* --- Logging -------------------------------------------- */
static int log_level = WLR_ERROR;

/* --- Reglas de ventanas --------------------------------- */
/*   app_id               title   tags  isfloating  monitor */
static const Rule rules[] = {
    { "pavucontrol",        NULL,  0,    1,          -1 },
    { "nm-connection-editor", NULL, 0,  1,          -1 },
    { "org.gnome.Calculator", NULL, 0,  1,          -1 },
    { "imv",                NULL,  0,    1,          -1 },
    { "mpv",                NULL,  0,    1,          -1 },
    { "vlc",                NULL,  0,    1,          -1 },
    { "eog",                NULL,  0,    1,          -1 },
    /* Diálogos de archivo flotantes — no hay regla por título en dwl base,
       pero con el patch "title rules" se puede agregar: */
    /* { NULL, "Open File",   0,    1,          -1 }, */
    /* { NULL, "Save File",   0,    1,          -1 }, */
};

/* --- Layouts -------------------------------------------- */
static const Layout layouts[] = {
    /* símbolo   función     */
    { "[]=",    tile    },   /* 0: tiling (default) */
    { "[M]",    monocle },   /* 1: monocle (equivale a fullscreen layout) */
    { "><>",    NULL    },   /* 2: floating */
};

/* --- Monitor -------------------------------------------- */
/*   name     mfact  nmaster  scale  layout           rotate/reflect               x   y  */
static const MonitorRule monrules[] = {
    { "eDP-1", 0.60f, 1,      1,     &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
    { NULL,    0.55f, 1,      1,     &layouts[0], WL_OUTPUT_TRANSFORM_NORMAL, -1, -1 },
};

/* --- Teclado -------------------------------------------- */
static const struct xkb_rule_names xkb_rules = {
    .layout  = "us",
    .options = NULL,
};
static const int repeat_rate  = 25;
static const int repeat_delay = 600;

/* --- Touchpad ------------------------------------------- */
static const int tap_to_click           = 1;
static const int tap_and_drag           = 1;
static const int drag_lock              = 0;
static const int natural_scrolling      = 1;  /* scroll natural */
static const int disable_while_typing   = 1;
static const int left_handed            = 0;
static const int middle_button_emulation = 0;
static const enum libinput_config_scroll_method scroll_method =
    LIBINPUT_CONFIG_SCROLL_2FG;
static const enum libinput_config_click_method click_method =
    LIBINPUT_CONFIG_CLICK_METHOD_CLICKFINGER;  /* clickfinger como en Hyprland */
static const uint32_t send_events_mode =
    LIBINPUT_CONFIG_SEND_EVENTS_ENABLED;
static const enum libinput_config_accel_profile accel_profile =
    LIBINPUT_CONFIG_ACCEL_PROFILE_ADAPTIVE;    /* adaptive como en Hyprland */
static const double accel_speed = 0.0;
static const enum libinput_config_tap_button_map button_map =
    LIBINPUT_CONFIG_TAP_MAP_LRM;

/* --- Keybindings ---------------------------------------- */
/* SUPER = tecla Windows */
#define MODKEY WLR_MODIFIER_LOGO

/* TAGKEYS genera 4 binds por tag:
   SUPER+N        → ver tag N
   SUPER+Ctrl+N   → toggle vista tag N
   SUPER+Shift+N  → mover ventana a tag N
   SUPER+Ctrl+Shift+N → toggle tag en ventana */
#define TAGKEYS(KEY, SKEY, TAG) \
    { MODKEY,                              KEY,  view,      {.ui = 1 << TAG} }, \
    { MODKEY|WLR_MODIFIER_CTRL,            KEY,  toggleview,{.ui = 1 << TAG} }, \
    { MODKEY|WLR_MODIFIER_SHIFT,           SKEY, tag,       {.ui = 1 << TAG} }, \
    { MODKEY|WLR_MODIFIER_CTRL|WLR_MODIFIER_SHIFT, SKEY, toggletag, {.ui = 1 << TAG} }

#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

/* --- Comandos ------------------------------------------- */
static const char *termcmd[]   = { "kitty", NULL };
static const char *menucmd[]   = { "fuzzel", NULL };
static const char *browsercmd[] = { "qutebrowser", NULL };
/* hyprlock funciona standalone sin Hyprland */
static const char *lockcmd[]   = { "hyprlock", NULL };

static const Key keys[] = {
    /* SUPER + tecla           → acción              argumento */

    /* --- Aplicaciones --- */
    { MODKEY,                    XKB_KEY_Return,     spawn,          {.v = termcmd}   },
    { MODKEY,                    XKB_KEY_d,          spawn,          {.v = menucmd}   },
    { MODKEY,                    XKB_KEY_e,          spawn,          {.v = browsercmd} },

    /* Equivalentes a los exec de Hyprland */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_L,          spawn,          {.v = lockcmd}   },
    { MODKEY,                    XKB_KEY_n,          spawn,          SHCMD("swaync-client -t -sw") },
    { MODKEY,                    XKB_KEY_c,          spawn,          SHCMD("cliphist list | fuzzel --dmenu | cliphist decode | wl-copy") },

    /* --- Capturas de pantalla (grim+slurp en lugar de hyprshot) --- */
    /* PrintScr         → captura región al portapapeles */
    { 0,                         XKB_KEY_Print,      spawn,          SHCMD("grim -g \"$(slurp)\" - | wl-copy") },
    /* Ctrl+PrintScr    → captura pantalla completa a ~/Screenshots/ */
    { WLR_MODIFIER_CTRL,         XKB_KEY_Print,      spawn,          SHCMD("grim ~/Screenshots/$(date +%Y%m%d_%H%M%S).png") },
    /* Shift+PrintScr   → captura ventana activa */
    { WLR_MODIFIER_SHIFT,        XKB_KEY_Print,      spawn,          SHCMD("grim -g \"$(slurp -s 00000000)\" - | wl-copy") },

    /* --- Gestión de ventanas --- */
    { MODKEY,                    XKB_KEY_q,          killclient,     {0}              },
    { MODKEY,                    XKB_KEY_v,          togglefloating, {0}              },
    { MODKEY,                    XKB_KEY_f,          togglefullscreen, {0}            },
    { MODKEY,                    XKB_KEY_m,          zoom,           {0}              }, /* promueve al master */

    /* --- Navegación (j/k = siguiente/anterior en stack) --- */
    { MODKEY,                    XKB_KEY_j,          focusstack,     {.i = +1}        },
    { MODKEY,                    XKB_KEY_k,          focusstack,     {.i = -1}        },
    /* Con patch focusdir, usar en lugar de focusstack: */
    /* { MODKEY, XKB_KEY_Left,  focusdir, {.i = DIR_LEFT}  }, */
    /* { MODKEY, XKB_KEY_Right, focusdir, {.i = DIR_RIGHT} }, */
    /* { MODKEY, XKB_KEY_Up,    focusdir, {.i = DIR_UP}    }, */
    /* { MODKEY, XKB_KEY_Down,  focusdir, {.i = DIR_DOWN}  }, */

    /* --- Redimensión del master (h/l = encoger/agrandar) --- */
    { MODKEY,                    XKB_KEY_h,          setmfact,       {.f = -0.05}     },
    { MODKEY,                    XKB_KEY_l,          setmfact,       {.f = +0.05}     },

    /* --- Número de ventanas en master --- */
    { MODKEY,                    XKB_KEY_i,          incnmaster,     {.i = +1}        },
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_D,          incnmaster,     {.i = -1}        },

    /* --- Layouts --- */
    { MODKEY,                    XKB_KEY_t,          setlayout,      {.v = &layouts[0]} }, /* tile */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_M,          setlayout,      {.v = &layouts[1]} }, /* monocle */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_space,      setlayout,      {.v = &layouts[2]} }, /* float */
    { MODKEY,                    XKB_KEY_space,      setlayout,      {0}              }, /* toggle anterior */

    /* --- Workspaces (tags) --- */
    { MODKEY,                    XKB_KEY_Tab,        view,           {0}              }, /* workspace anterior */
    { MODKEY,                    XKB_KEY_0,          view,           {.ui = ~0}       }, /* ver todos */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_parenright, tag,            {.ui = ~0}       }, /* mover a todos */

    /* SUPER+1..9 */
    TAGKEYS(XKB_KEY_1, XKB_KEY_exclam,      0),
    TAGKEYS(XKB_KEY_2, XKB_KEY_at,          1),
    TAGKEYS(XKB_KEY_3, XKB_KEY_numbersign,  2),
    TAGKEYS(XKB_KEY_4, XKB_KEY_dollar,      3),
    TAGKEYS(XKB_KEY_5, XKB_KEY_percent,     4),
    TAGKEYS(XKB_KEY_6, XKB_KEY_asciicircum, 5),
    TAGKEYS(XKB_KEY_7, XKB_KEY_ampersand,   6),
    TAGKEYS(XKB_KEY_8, XKB_KEY_asterisk,    7),
    TAGKEYS(XKB_KEY_9, XKB_KEY_parenleft,   8),

    /* --- Monitor secundario (si lo tienes) --- */
    { MODKEY,                    XKB_KEY_comma,      focusmon,       {.i = WLR_DIRECTION_LEFT}  },
    { MODKEY,                    XKB_KEY_period,     focusmon,       {.i = WLR_DIRECTION_RIGHT} },
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_less,       tagmon,         {.i = WLR_DIRECTION_LEFT}  },
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_greater,    tagmon,         {.i = WLR_DIRECTION_RIGHT} },

    /* --- Salir --- */
    { MODKEY|WLR_MODIFIER_SHIFT, XKB_KEY_Q,          quit,           {0}              },

    /* --- Multimedia / hardware keys --- */
    { 0, XKB_KEY_XF86AudioRaiseVolume,  spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+")        },
    { 0, XKB_KEY_XF86AudioLowerVolume,  spawn, SHCMD("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")        },
    { 0, XKB_KEY_XF86AudioMute,         spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")       },
    { 0, XKB_KEY_XF86AudioMicMute,      spawn, SHCMD("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")     },
    { 0, XKB_KEY_XF86MonBrightnessUp,   spawn, SHCMD("brightnessctl s 10%+")                             },
    { 0, XKB_KEY_XF86MonBrightnessDown, spawn, SHCMD("brightnessctl s 10%-")                             },
    { 0, XKB_KEY_XF86AudioNext,         spawn, SHCMD("playerctl next")                                   },
    { 0, XKB_KEY_XF86AudioPrev,         spawn, SHCMD("playerctl previous")                               },
    { 0, XKB_KEY_XF86AudioPlay,         spawn, SHCMD("playerctl play-pause")                             },
    { 0, XKB_KEY_XF86AudioPause,        spawn, SHCMD("playerctl play-pause")                             },
};

/* --- Botones del ratón ----------------------------------
   SUPER + clic izq = mover ventana
   SUPER + clic der = redimensionar
   SUPER + clic med = toggle float */
static const Button buttons[] = {
    { MODKEY, BTN_LEFT,   moveresize,     {.ui = CurMove}   },
    { MODKEY, BTN_MIDDLE, togglefloating, {0}               },
    { MODKEY, BTN_RIGHT,  moveresize,     {.ui = CurResize} },
};
