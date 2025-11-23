# Claude Code - Quick Reference

## 🤖 Agentes Especializados

Ver documentación completa: `cat ~/.config/claude/AGENTS.md`

```bash
# Auto-activación (detecta palabras clave)
claude "optimiza mi docker-compose"     # → devops-expert
claude "configura waybar"               # → hyprland-expert
claude "ayuda con git rebase"           # → git-expert

# Invocación manual
claude "@arch-expert ¿cómo actualizar el kernel?"
claude "@security-expert analiza este código para XSS"
claude "@python-expert crea un script de backup"
```

**Agentes disponibles**: arch-expert, hyprland-expert, devops-expert, security-expert,
web-dev-expert, shell-expert, python-expert, git-expert, neovim-expert, db-expert

## Búsqueda Web (SearXNG)

```bash
s "query"              # Búsqueda rápida
search "query"         # Alias de s
sx ddg "query"         # Buscar con DuckDuckGo específicamente
sx go "query"          # Buscar con Google
sx gh "query"          # Buscar en GitHub
```

### Búsquedas Temáticas

```bash
cve "software"         # Buscar CVEs/exploits
ghsearch "repo"        # Buscar en GitHub
so "question"          # Stack Overflow
aw "arch query"        # Arch Wiki
```

### Búsquedas Avanzadas

```bash
searchfzf "query"      # Búsqueda con preview y selección interactiva
cdocs "python"         # Buscar documentación (abre primer resultado)
vuln "nginx"           # Buscar vulnerabilidades
o "query"              # Open first result
```

## Gestión de Backups

```bash
cb                     # Alias de claude-backup
cbackup                # Crear backup ahora
crestore               # Restaurar último backup
claude-backup sync     # Sincronizar con Proton Drive
```

## SearXNG Management

```bash
searxng-start          # Iniciar SearXNG
searxng-stop           # Detener SearXNG
searxng-restart        # Reiniciar SearXNG
searxng-status         # Ver estado del servicio
searxng-logs           # Ver logs en tiempo real
```

## Security & Hacking

```bash
nq 192.168.1.1         # Nmap quick scan (-sV -sC)
portscan 192.168.1.1   # Full port scan
revshell <ip> <port>   # Generar reverse shells (ético)
```

## Sistema

```bash
cpu                    # Top 10 procesos por CPU
mem                    # Top 10 procesos por memoria
ports-listening        # Ver puertos en escucha
```

## ProtonVPN

```bash
vpn                    # ProtonVPN CLI (alias de protonvpn)
vpnc                   # Conectar (protonvpn connect)
vpnd                   # Desconectar
vpni                   # Ver info de cuenta
```

## Docker (complementos)

```bash
d                      # Alias de docker
dlog <container>       # Ver logs
dex <container>        # Exec bash en contenedor
```

## Herramientas Útiles

```bash
json                   # Pretty print JSON (alias de jq)
b64 "text"             # Encode base64
b64d "encoded"         # Decode base64
serve                  # HTTP server puerto 8000
```

## Verificación del Sistema

```bash
claude-check           # Verificar toda la configuración
```

## Directorios Importantes

```
~/.config/claude/              # Configuración de Claude Code
~/searxng/                     # SearXNG
~/cloud-backup/claude/         # Backups
~/.local/bin/                  # Scripts personalizados
```

## Tips

1. **Recargar aliases sin reiniciar terminal:**
   ```bash
   source ~/.zshrc
   ```

2. **Ver todos los comandos disponibles:**
   ```bash
   cat ~/.config/claude/aliases.zsh
   ```

3. **Ver documentación completa:**
   ```bash
   cat ~/.config/claude/README.md
   ```

4. **Backup rápido antes de cambios importantes:**
   ```bash
   cbackup
   ```

5. **Verificar que todo funciona:**
   ```bash
   claude-check
   ```

## Restauración Post-Formateo (Resumen)

```bash
# 1. Instalar base
sudo pacman -S docker docker-compose nodejs npm

# 2. Habilitar Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER

# 3. Restaurar desde backup
claude-backup restore /path/to/backup.tar.gz

# 4. Verificar
claude-check
```

## Teclas de Acceso Rápido (si aplican)

Las que ya tienes en tu .zshrc:
- `Ctrl+F`: File finder (fzf)
- `Ctrl+G`: Directory finder (zoxide + fzf)
- `Ctrl+R`: History search (fzf)
- `Ctrl+Z`: Foreground last suspended job

---

**Última actualización**: 2024-11-22
