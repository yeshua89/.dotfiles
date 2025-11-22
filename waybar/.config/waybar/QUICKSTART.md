# 🚀 Quickstart - Waybar Mejorada

## Aplicar los Cambios

### Método 1: Reiniciar Waybar (Recomendado)
```bash
~/.config/waybar/scripts/reload.sh
```

### Método 2: Manual
```bash
killall waybar && waybar &
```

### Método 3: Signal (sin reiniciar)
```bash
pkill -SIGUSR2 waybar
```

## Cambiar al Tema Ultra-Dark (Absolute Black)

**Opción 1: Con script**
```bash
~/.config/waybar/scripts/theme-switcher.sh black
```

**Opción 2: Manual**
Edita `~/.config/waybar/style.css` línea 3:
```css
/* Cambia esta línea: */
@import "tokyo-night.css";

/* Por esta: */
@import "absolute-black.css";
```

Luego reinicia Waybar.

## Activar Glassmorphism (Efecto Vidrio)

Edita `~/.config/waybar/style.css` y **descomenta** las líneas 23-29:
```css
/* ESTO: */
/*
window#waybar {
    background: rgba(22, 22, 30, 0.85);
    backdrop-filter: blur(10px);
    ...
}
*/

/* CAMBIA A ESTO (sin los comentarios): */
window#waybar {
    background: rgba(22, 22, 30, 0.85);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}
```

## Módulos Incluidos

### Compactos y Eficientes
- **CPU**: `` + porcentaje de uso
- **Memoria**: `` + porcentaje usado
- **Temperatura**: `` + temperatura en °C
- **Updates**: `` + número de actualizaciones

### Características
- Tooltips detallados (pasa el mouse sobre cualquier módulo)
- Colores adaptativos (amarillo = warning, rojo = crítico)
- Animaciones de pulso en estados críticos

## Scripts Disponibles

### Cambiar Temas
```bash
# Rotar entre temas
~/.config/waybar/scripts/theme-switcher.sh rotate

# Menú interactivo
~/.config/waybar/scripts/theme-switcher.sh menu

# Tema específico
~/.config/waybar/scripts/theme-switcher.sh tokyo
~/.config/waybar/scripts/theme-switcher.sh black
~/.config/waybar/scripts/theme-switcher.sh rose
```

### Verificar Actualizaciones
```bash
~/.config/waybar/scripts/check-updates.sh
```

### Ver Clima
```bash
# Ubicación automática
~/.config/waybar/scripts/weather.sh

# Ciudad específica
~/.config/waybar/scripts/weather.sh "New York"
```

### Estado VPN
```bash
~/.config/waybar/scripts/vpn-status.sh
```

## Personalización Rápida

### Cambiar Tamaño de Fuente
`style.css` línea 11:
```css
font-size: 13px; /* Cambia este valor */
```

### Reordenar Módulos
`config.jsonc` - Reorganiza los arrays:
```json
"modules-right": [
  "tray",
  "custom/updates",
  "cpu",      // ← Mueve estos como quieras
  "memory",   // ←
  "temperature", // ←
  "pulseaudio",
  ...
]
```

### Ocultar Módulos
`config.jsonc` - Comenta o elimina del array:
```json
"modules-right": [
  "tray",
  // "custom/updates",  ← Comentado = no se muestra
  "cpu",
  ...
]
```

## Atajos Recomendados para Hyprland

Agrega a `~/.config/hypr/hyprland.conf`:
```conf
# Recargar Waybar
bind = SUPER SHIFT, W, exec, ~/.config/waybar/scripts/reload.sh

# Cambiar tema
bind = SUPER SHIFT, T, exec, ~/.config/waybar/scripts/theme-switcher.sh rotate
```

## Solución de Problemas

### Waybar no inicia
```bash
# Ver errores detallados
waybar -l debug

# Verificar sintaxis JSON
jq . ~/.config/waybar/config.jsonc
```

### Scripts no funcionan
```bash
# Dar permisos
chmod +x ~/.config/waybar/scripts/*.sh

# Probar script individual
~/.config/waybar/scripts/check-updates.sh
```

### Iconos no se ven
```bash
# Instalar Nerd Fonts
sudo pacman -S ttf-firacode-nerd ttf-nerd-fonts-symbols
```

### CPU/Memoria no se muestra
Asegúrate de tener los permisos necesarios:
```bash
# Verifica que funcione
cat /proc/stat
cat /proc/meminfo
```

## Comparación de Temas

| Tema | Estilo | Mejor para |
|------|--------|------------|
| **Tokyo Night** | Vibrante, colorido | Uso diario, coding |
| **Absolute Black** | Ultra-dark, elegante | Trabajo nocturno, minimalista |
| **Rosé Pine** | Pastel, suave | Diseño, confort visual |

## Tips Pro

1. **Usa tooltips**: Pasa el mouse sobre módulos para ver info detallada
2. **Experimenta con temas**: Cambia según la hora del día
3. **Menos es más**: No agregues módulos que no uses
4. **Aprovecha los scripts**: Son personalizables y extensibles
5. **Lee ADVANCED-STYLES.css**: Muchos efectos opcionales

---

**¿Necesitas más módulos?**
→ Revisa `config-optional-modules.jsonc`

**¿Quieres más estilos?**
→ Revisa `ADVANCED-STYLES.css`

**¿Documentación completa?**
→ Lee `README.md`

---

Disfruta tu Waybar mejorada! 🎉
