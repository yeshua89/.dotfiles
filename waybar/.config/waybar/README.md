# Waybar - La Mejor Configuración del Mundo Mundial

Configuración ultra-mejorada de Waybar para Hyprland con múltiples temas, módulos avanzados y scripts útiles.

## Características

### Temas Disponibles
1. **Tokyo Night** - Tema vibrante y colorido (actual)
2. **Absolute Black** - Tema ultra-dark elegante con escala de grises
3. **Rosé Pine** - Tema pastel suave

### Módulos Incluidos
- **Sistema**: CPU, Memoria, Temperatura (compactos)
- **Multimedia**: MPRIS (control de medios)
- **Red**: WiFi, Bluetooth, VPN
- **Hardware**: Batería, Brillo, Audio
- **Utilidades**: Updates, Tray, Idle Inhibitor, Power Profiles
- **Hyprland**: Workspaces, Window, Scratchpad, Submap

### Scripts Personalizados
- `check-updates.sh` - Verifica actualizaciones de Arch/AUR
- `weather.sh` - Muestra el clima actual
- `vpn-status.sh` - Estado de conexión VPN
- `theme-switcher.sh` - Cambio dinámico de temas

## Uso

### Cambiar de Tema

**Método 1: Rotar temas**
```bash
~/.config/waybar/scripts/theme-switcher.sh rotate
```

**Método 2: Menú interactivo**
```bash
~/.config/waybar/scripts/theme-switcher.sh menu
```

**Método 3: Tema específico**
```bash
~/.config/waybar/scripts/theme-switcher.sh tokyo    # Tokyo Night
~/.config/waybar/scripts/theme-switcher.sh black    # Absolute Black
~/.config/waybar/scripts/theme-switcher.sh rose     # Rosé Pine
```

**Método 4: Manual**
Edita `style.css` y cambia la línea:
```css
@import "tokyo-night.css";
```
Por:
```css
@import "absolute-black.css";
```

### Activar Glassmorphism (Efecto Vidrio)

Edita `style.css` y descomenta el bloque:
```css
window#waybar {
    background: rgba(22, 22, 30, 0.85);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}
```

### Añadir Módulos Opcionales

Revisa `config-optional-modules.jsonc` para módulos adicionales como:
- Clima
- VPN
- Notificaciones
- Spotify
- Espacio en disco
- GPU stats
- Y más...

Copia los que necesites a tu `config.jsonc`.

## Personalización

### Ajustar Tamaño de Fuente
En `style.css`:
```css
* {
    font-size: 13px; /* Cambia este valor */
}
```

### Modificar Altura de la Barra
En `config.jsonc`:
```json
"height": 30, // Cambia este valor
```

### Reordenar Módulos
Edita los arrays en `config.jsonc`:
```json
"modules-left": [...],
"modules-center": [...],
"modules-right": [...]
```

## Atajos de Teclado Recomendados

Agrega a tu configuración de Hyprland:
```conf
# Cambiar tema de Waybar
bind = SUPER SHIFT, T, exec, ~/.config/waybar/scripts/theme-switcher.sh rotate

# Reiniciar Waybar
bind = SUPER SHIFT, W, exec, killall waybar && waybar &
```

## Dependencias

Asegúrate de tener instalado:
```bash
# Básicas
sudo pacman -S waybar ttf-firacode-nerd

# Para scripts
sudo pacman -S playerctl brightnessctl networkmanager

# Opcionales
yay -S checkupdates
```

## Efectos y Animaciones

La configuración incluye:
- ✨ Transiciones suaves en hover
- 🎯 Efecto de elevación al pasar el mouse
- 💫 Animaciones de pulso para alertas críticas
- 🌟 Glow effect en módulos con advertencias
- 🎨 Separadores visuales elegantes
- 🖱️ Efecto de click/scale en módulos interactivos

## Troubleshooting

**Waybar no inicia:**
```bash
waybar -l debug
```

**Los scripts no funcionan:**
```bash
chmod +x ~/.config/waybar/scripts/*.sh
```

**Los iconos no se ven:**
Instala Nerd Fonts:
```bash
sudo pacman -S ttf-nerd-fonts-symbols ttf-font-awesome
```

## Tips Pro

1. **Mantén la barra limpia**: Menos es más. Usa tooltips para información detallada.
2. **Usa colores con propósito**: Rojo para crítico, amarillo para advertencias, azul para info.
3. **Aprovecha los scripts**: Automatiza y personaliza según tus necesidades.
4. **Experimenta con temas**: Cambia según la hora del día o tu estado de ánimo.

---

Creado con por Claude Code
