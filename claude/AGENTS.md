# Claude Code - Agentes Especializados

## 🤖 Agentes Disponibles

### 1. **arch-expert** - Experto en Arch Linux
**Especialidad**: Gestión de paquetes, systemd, troubleshooting de Arch
**Auto-trigger**: `pacman`, `aur`, `arch linux`, `makepkg`, `systemd`

**Ejemplos de uso**:
```bash
claude "¿Cómo optimizar pacman para descargas más rápidas?"
claude "Ayúdame a resolver conflictos de dependencias en AUR"
claude "¿Cómo configurar systemd para que searxng inicie automáticamente?"
```

---

### 2. **hyprland-expert** - Experto en Hyprland & Wayland
**Especialidad**: Configuración de Hyprland, waybar, plugins, wayland tools
**Auto-trigger**: `hyprland`, `waybar`, `wayland`, `swaync`, `hyprpm`

**Ejemplos de uso**:
```bash
claude "Configura waybar para mostrar el uso de CPU y RAM"
claude "¿Cómo agregar un nuevo workspace en Hyprland?"
claude "Ayúdame a configurar hyprlock con un tema personalizado"
```

---

### 3. **devops-expert** - Experto en DevOps & Docker
**Especialidad**: Docker, docker-compose, CI/CD, automatización
**Auto-trigger**: `docker`, `docker-compose`, `dockerfile`, `ci/cd`, `container`

**Ejemplos de uso**:
```bash
claude "Crea un docker-compose para PostgreSQL + Redis + Nginx"
claude "Optimiza mi Dockerfile para reducir el tamaño de la imagen"
claude "Configura GitHub Actions para deploy automático"
```

---

### 4. **security-expert** - Experto en Seguridad
**Especialidad**: Pentesting, análisis de vulnerabilidades, hardening
**Auto-trigger**: `security`, `pentest`, `cve`, `exploit`, `vulnerability`

**Ejemplos de uso**:
```bash
claude "¿Cómo hacer hardening de mi servidor Arch Linux?"
claude "Analiza esta aplicación web para vulnerabilidades OWASP"
claude "Búscame CVEs recientes para Nginx"
```

⚠️ **IMPORTANTE**: Solo uso ético - pentesting autorizado, CTF, investigación

---

### 5. **web-dev-expert** - Desarrollador Full Stack
**Especialidad**: React, Next.js, Astro, Bun, TypeScript, Node.js
**Auto-trigger**: `react`, `typescript`, `node`, `next.js`, `astro`, `bun`, `web development`, `frontend`

**Tecnologías 2025**:
- **Astro 4+** (40% más rápido, Islands Architecture, ideal para SEO)
- **Bun** (4x más rápido que Node.js, all-in-one toolkit)
- **Next.js 14+** (App Router, Server Components)
- **Vitest** (5x más rápido que Jest)

**Ejemplos de uso**:
```bash
claude "Crea un sitio con Astro optimizado para SEO"
claude "Convierte mi API de Node.js a Bun para mejor performance"
claude "Diseña un componente React con TypeScript y Tailwind"
claude "Compara Astro vs Next.js para un blog"
```

---

### 6. **shell-expert** - Experto en Shell & CLI
**Especialidad**: Bash/Zsh scripting, herramientas CLI modernas
**Auto-trigger**: `bash`, `zsh`, `script`, `shell`, `cli`

**Ejemplos de uso**:
```bash
claude "Escribe un script que haga backup automático de mis dotfiles"
claude "¿Cómo puedo mejorar mi .zshrc para mejor performance?"
claude "Crea un script fzf para buscar y abrir archivos rápidamente"
```

---

### 7. **python-expert** - Experto en Python
**Especialidad**: Python moderno, frameworks web, ML, data science, automatización
**Auto-trigger**: `python`, `fastapi`, `django`, `pandas`, `numpy`, `asyncio`, `pytest`, `litestar`, `sanic`

**Frameworks Web Modernos**:
- **FastAPI** (21,000+ req/s, async-first, auto-docs)
- **Litestar** (más rápido que FastAPI, msgspec)
- **Sanic** (ideal para real-time apps)
- **Django 5+** (full-stack, perfecto para CMS/e-commerce)

**Performance Tools**:
- **polars** (10x más rápido que pandas)
- **uv** (package manager 10-100x más rápido que pip)
- **ruff** (linter ultra-rápido)

**Ejemplos de uso**:
```bash
claude "Crea una API con FastAPI y async PostgreSQL"
claude "Compara FastAPI vs Litestar para microservicios"
claude "Migra mi proyecto de pandas a polars"
claude "Diseña un backend Django 5 para e-commerce"
claude "Crea un scraper con Playwright (mejor que Selenium)"
```

---

### 8. **git-expert** - Experto en Git
**Especialidad**: Git workflows, branching, troubleshooting
**Auto-trigger**: `git`, `github`, `gitlab`, `merge`, `rebase`, `commit`

**Ejemplos de uso**:
```bash
claude "¿Cómo deshago el último commit sin perder cambios?"
claude "Explícame git rebase interactive"
claude "Ayúdame a resolver este merge conflict"
```

---

### 9. **neovim-expert** - Experto en Neovim
**Especialidad**: Configuración Neovim, plugins, Lua
**Auto-trigger**: `neovim`, `nvim`, `vim`, `lua`, `lazy.nvim`

**Ejemplos de uso**:
```bash
claude "Configura Telescope con fuzzy finding mejorado"
claude "¿Cómo configuro LSP para TypeScript en Neovim?"
claude "Agrega soporte para copilot en mi config de Neovim"
```

---

### 10. **db-expert** - Experto en Bases de Datos
**Especialidad**: PostgreSQL, SQL optimization, MongoDB
**Auto-trigger**: `postgresql`, `sql`, `database`, `mongodb`, `prisma`

**Ejemplos de uso**:
```bash
claude "Optimiza esta query PostgreSQL que es muy lenta"
claude "Diseña el schema para una app de e-commerce"
claude "Configura replicación master-slave en PostgreSQL"
```

---

## 🚀 Cómo Usar los Agentes

### Auto-trigger (Automático)
Los agentes se activan automáticamente cuando detectan palabras clave:

```bash
claude "Ayúdame con docker-compose"  # → Activa devops-expert
claude "Configura waybar"            # → Activa hyprland-expert
claude "Optimiza esta query SQL"     # → Activa db-expert
```

### Invocación Manual
Puedes invocar un agente específico con `@agente`:

```bash
claude "@arch-expert ¿cómo actualizo el kernel?"
claude "@security-expert analiza este código para XSS"
claude "@python-expert crea un script de backup"
```

### Combinación de Agentes
Los agentes pueden trabajar juntos en tareas complejas:

```bash
claude "Crea un docker-compose para PostgreSQL y una API en Node.js con TypeScript"
# → Activa: devops-expert + web-dev-expert + db-expert
```

---

## ⚙️ Configuración

Los agentes están configurados en:
```
~/.config/claude/agents.json
```

### Settings Globales:
- **defaultModel**: `sonnet` (balanceo entre velocidad y calidad)
- **enableAutoTrigger**: `true` (activación automática)
- **maxConcurrentAgents**: `3` (máximo 3 agentes simultáneos)
- **agentTimeout**: `180000ms` (3 minutos)

### Modelos por Agente:
- **Sonnet**: La mayoría (balance perfecto)
- **Haiku**: `git-expert` (tareas simples, más rápido)
- **Opus**: Ninguno por defecto (puedes cambiar para tareas complejas)

---

## 📝 Tips de Uso

1. **Sé específico**: Mientras más contexto des, mejores resultados
   ```bash
   # ❌ Malo
   claude "ayuda con docker"

   # ✅ Bueno
   claude "crea un docker-compose con PostgreSQL 16, Redis 7, y nginx como reverse proxy"
   ```

2. **Usa el contexto del proyecto**: Los agentes tienen acceso a tus archivos
   ```bash
   cd ~/mi-proyecto
   claude "revisa mi docker-compose.yml y optimízalo"
   ```

3. **Combina con herramientas**: Los agentes pueden usar bash, grep, etc.
   ```bash
   claude "busca todos los TODOs en mi código Python y créame issues"
   ```

4. **Aprovecha el auto-trigger**: No necesitas especificar el agente
   ```bash
   claude "ayúdame a configurar Hyprland con 10 workspaces"
   # → hyprland-expert se activa automáticamente
   ```

---

## 🔧 Personalización

### Agregar un Nuevo Agente

Edita `~/.config/claude/agents.json`:

```json
{
  "agents": {
    "mi-agente": {
      "name": "Mi Agente Custom",
      "description": "Descripción corta",
      "systemPrompt": "Tu prompt personalizado aquí...",
      "tools": ["bash", "read", "write"],
      "autoTrigger": ["palabra1", "palabra2"],
      "model": "sonnet"
    }
  }
}
```

### Modificar un Agente Existente

1. Edita el archivo `agents.json`
2. Cambia el `systemPrompt`, `autoTrigger`, o `model`
3. Guarda y el cambio es inmediato (no necesitas reiniciar)

### Desactivar Auto-trigger

En `agents.json`, cambia:
```json
"globalSettings": {
  "enableAutoTrigger": false
}
```

---

## 📊 Estadísticas y Logs

Ver qué agentes se están usando:
```bash
claude-check agents  # Ver estadísticas de uso
```

Ver logs de agentes:
```bash
journalctl --user -u claude-code -f
```

---

## 🆘 Troubleshooting

### El agente no se activa automáticamente
- Verifica que `enableAutoTrigger: true` en `globalSettings`
- Asegúrate de usar las palabras clave del `autoTrigger`
- Prueba invocándolo manualmente con `@nombre-agente`

### El agente da respuestas incorrectas
- Revisa el `systemPrompt` del agente
- Considera cambiar el modelo a `opus` para tareas complejas
- Proporciona más contexto en tu pregunta

### Múltiples agentes conflictivos
- Reduce `maxConcurrentAgents` a 1 o 2
- Invoca manualmente el agente específico que necesitas

---

## 🎯 Próximos Pasos

1. **Prueba cada agente**: Familiarízate con sus capacidades
2. **Personaliza**: Ajusta los prompts a tu estilo de trabajo
3. **Crea tus propios agentes**: Para áreas específicas de tu trabajo
4. **Integra con workflows**: Combina con hooks y scripts

---

**Creado**: 2025-11-23
**Última actualización**: 2025-11-23 (finales de 2025)
**Versión**: 1.0.0
