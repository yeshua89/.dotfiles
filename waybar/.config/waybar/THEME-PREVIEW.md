# 🎨 Vista Previa de Temas

## Absolute Black - Ultra Dark Theme

### Filosofía
El tema más oscuro y elegante basado en negro absoluto (#000000) con una paleta monocromática sofisticada. Diseñado para ambientes profesionales y trabajo nocturno sin fatiga visual.

### Paleta de Colores

#### Fondos (Capas de Profundidad)
```
#000000 → Negro absoluto (base)
#0a0a0a → Negro elevado (módulos)
#141414 → Gris oscuro (hover)
#0f0f0f → Separador sutil
#1a1a1a → Profundidad media
#252525 → Contraste alto
```

#### Textos (Jerarquía Tipográfica)
```
#e0e0e0 → Blanco suave (texto principal)
#808080 → Gris medio (secundario)
#505050 → Gris oscuro (terciario)
```

#### Acentos (Minimalista con Propósito)
```
#ffffff → Blanco puro (activo/primario)
#c8c8c8 → Gris claro (reloj/importante)
#a0a0a0 → Gris medio (info)
#b8b8b8 → Gris suave (acento)
#d4af37 → Oro elegante (warning)
#ff4444 → Rojo profundo (crítico)
```

### Características Visuales

✨ **Ultra-dark sin fatiga**
- Negro absoluto como base
- Contraste controlado para reducir eye strain
- Escala de grises cuidadosamente calibrada

🎯 **Profesional y elegante**
- Sin colores llamativos innecesarios
- Acentos de color solo cuando importan
- Tipografía clara y legible

💫 **Efectos sutiles**
- Separadores apenas visibles
- Transiciones suaves
- Bordes semi-transparentes para depth

### Módulos y Colores

| Módulo | Color | Significado |
|--------|-------|-------------|
| Workspaces activo | `#ffffff` | Blanco puro - máxima visibilidad |
| CPU normal | `#ffffff` | Blanco - info clara |
| CPU warning | `#d4af37` | Oro - precaución |
| CPU critical | `#ff4444` | Rojo - alerta |
| Memoria | `#b8b8b8` | Gris suave |
| Temperatura | `#a0a0a0` | Gris medio |
| Battery | `#a0a0a0` | Gris medio |
| Battery charging | `#ffffff` | Blanco - estado positivo |
| Battery critical | `#ff4444` | Rojo - urgente |
| Clock | `#c8c8c8` | Gris claro - destacado |
| Network | `#d4af37` | Oro - conectividad |
| Bluetooth | `#b8b8b8` | Gris suave |
| Volume | `#ffffff` | Blanco - control principal |

---

## Tokyo Night - Vibrant Theme

### Filosofía
Tema vibrante inspirado en la noche de Tokio. Colores saturados y contrastantes para un ambiente energético.

### Paleta Principal
```
#1a1b26 → Base oscura
#16161E → Surface (módulos)
#c0caf5 → Texto principal (azul claro)
#7dcfff → Foam (cyan brillante)
#7aa2f7 → Pine (azul)
#bb9af7 → Rose/Iris (morado)
#f7768e → Love (rojo/rosa)
#e0af68 → Gold (amarillo/naranja)
```

### Mejor para
- Coding sessions
- Ambiente productivo
- Alta visibilidad
- Personalidad vibrante

---

## Rosé Pine - Soft Theme

### Filosofía
Paleta pastel suave inspirada en tonos naturales. Ideal para largas sesiones sin cansancio visual.

### Características
- Tonos pastel suaves
- Contraste moderado
- Ambiente relajado
- Estética natural

### Mejor para
- Diseño gráfico
- Escritura/documentación
- Trabajo prolongado
- Confort visual máximo

---

## Comparación Visual

```
┌─────────────────────────────────────────────────────────┐
│ TOKYO NIGHT                                             │
│ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓   │
│ Energía: ████████░░ 80%                                 │
│ Contraste: ██████████ 100%                              │
│ Suavidad: ████░░░░░░ 40%                                │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ ABSOLUTE BLACK                                          │
│ ░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░   │
│ Energía: ███░░░░░░░ 30%                                 │
│ Contraste: ████████░░ 80%                               │
│ Suavidad: ██████████ 100%                               │
└─────────────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────────────┐
│ ROSÉ PINE                                               │
│ ░░░░▓▓▓▓░░░░▓▓▓▓░░░░▓▓▓▓░░░░▓▓▓▓░░░░▓▓▓▓░░░░▓▓▓▓░░░░   │
│ Energía: █████░░░░░ 50%                                 │
│ Contraste: ██████░░░░ 60%                               │
│ Suavidad: ████████░░ 80%                                │
└─────────────────────────────────────────────────────────┘
```

## Recomendaciones de Uso

### Hora del Día
- **Mañana**: Tokyo Night (energía)
- **Tarde**: Rosé Pine (confort)
- **Noche**: Absolute Black (sin fatiga)

### Tipo de Trabajo
- **Coding**: Tokyo Night
- **Diseño**: Rosé Pine
- **Escritura**: Absolute Black
- **Presentaciones**: Absolute Black (profesional)

### Mood
- **Productivo**: Tokyo Night
- **Relajado**: Rosé Pine
- **Concentrado**: Absolute Black
- **Creativo**: Rosé Pine

---

💡 **Tip**: Usa el script theme-switcher para cambiar rápidamente según tu necesidad del momento.

```bash
# Cambiar según la hora
~/.config/waybar/scripts/theme-switcher.sh rotate
```
