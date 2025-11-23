# Claude Code - Configuración Personalizada

Configuración optimizada de Claude Code para máxima eficiencia.

## Características Configuradas

### 1. MCP Servers
- **fetch**: Búsquedas web y peticiones HTTP
- **filesystem**: Acceso directo al sistema de archivos

### 2. SearXNG (Metabuscador Privado)
- **URL**: http://localhost:8888
- **Motores habilitados**:
  - DuckDuckGo (principal, privacidad)
  - Google (ocasional, mejores resultados técnicos)
  - GitHub, Stack Overflow
  - Exploit-DB (seguridad)
  - Arch Wiki
  - Startpage (proxy Google con privacidad)

### 3. Configuración de Rendimiento
- **Agentes concurrentes**: 5 máximo
- **Ejecución paralela**: Habilitada
- **Cache**: Habilitada (1GB)
- **Auto-retry**: Habilitado

## Uso Diario

### Búsquedas Web
```bash
# Búsqueda directa desde terminal
searxng-search "postgresql CVE 2024"

# Búsqueda con formato específico
searxng-search "nginx exploit" json
```

### Backup de Configuración
```bash
# Crear backup
claude-backup backup

# Restaurar último backup
claude-backup restore

# Restaurar backup específico
claude-backup restore ~/cloud-backup/claude/claude-config-20241122_123456.tar.gz

# Sincronizar con Proton Drive
claude-backup sync
```

## Restauración Post-Formateo

### Método 1: Backup Automático (RECOMENDADO)

**Antes de formatear:**
```bash
# 1. Crear backup
claude-backup backup

# 2. Verificar que el backup se creó
ls -lh ~/cloud-backup/claude/

# 3. (Opcional) Copiar a USB/Proton Drive manualmente
cp ~/cloud-backup/claude/claude-config-latest.tar.gz /ruta/segura/
```

**Después de formatear:**
```bash
# 1. Instalar dependencias base
sudo pacman -S docker docker-compose nodejs npm

# 2. Habilitar Docker
sudo systemctl enable --now docker
sudo usermod -aG docker $USER
# Cerrar sesión y volver a entrar

# 3. Instalar Claude Code
npm install -g @anthropic-ai/claude-code

# 4. Restaurar configuración
# Copiar backup de vuelta si está en USB/Proton Drive
claude-backup restore /ruta/al/backup.tar.gz

# 5. Verificar que SearXNG esté corriendo
docker ps | grep searxng

# 6. Listo!
```

### Método 2: Configuración Manual

Si no tienes backup, reinstala paso a paso:

```bash
# 1. Instalar dependencias
sudo pacman -S docker docker-compose nodejs npm

# 2. Crear estructura de directorios
mkdir -p ~/.config/claude
mkdir -p ~/.local/bin
mkdir -p ~/searxng

# 3. Clonar/descargar archivos de configuración
# (Los archivos están en ~/.config/claude/)

# 4. Levantar SearXNG
cd ~/searxng
docker-compose up -d

# 5. Verificar funcionamiento
curl http://localhost:8888
```

## Archivos Importantes

```
~/.config/claude/
├── config.json          # Configuración MCP servers
├── settings.json        # Ajustes de rendimiento
└── README.md           # Esta documentación

~/searxng/
├── docker-compose.yml   # Configuración Docker
└── searxng/
    └── settings.yml    # Configuración SearXNG

~/.local/bin/
├── searxng-search      # Script de búsqueda
└── claude-backup       # Script de backup/restore
```

## Estructura del Backup

El backup incluye:
- Configuración completa de Claude Code (`~/.config/claude/`)
- SearXNG completo (`~/searxng/`)
- Scripts personalizados (`~/.local/bin/*`)

**Tamaño aproximado**: ~50MB
**Compresión**: tar.gz
**Ubicación**: `~/cloud-backup/claude/`

## Automatización de Backups

### Backup Automático con Cron

Agrega a tu crontab (`crontab -e`):

```bash
# Backup diario de Claude Code a las 2 AM
0 2 * * * /home/shaddai/.local/bin/claude-backup backup > /dev/null 2>&1

# Backup semanal con sincronización a Proton Drive (domingo 3 AM)
0 3 * * 0 /home/shaddai/.local/bin/claude-backup backup && /home/shaddai/.local/bin/claude-backup sync
```

### Backup con Systemd Timer (alternativa más moderna)

Crea el servicio:
```bash
# ~/.config/systemd/user/claude-backup.service
[Unit]
Description=Claude Code Configuration Backup

[Service]
Type=oneshot
ExecStart=/home/shaddai/.local/bin/claude-backup backup

# ~/.config/systemd/user/claude-backup.timer
[Unit]
Description=Claude Code Backup Timer

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target
```

Habilitar:
```bash
systemctl --user enable --now claude-backup.timer
```

## Integración con Proton Drive

Si usas Proton Drive:

1. **Monta Proton Drive** (vía rclone o cliente oficial)
2. **Configura la variable de entorno**:
   ```bash
   # En ~/.zshrc o ~/.bashrc
   export PROTON_DRIVE_PATH="$HOME/ProtonDrive"
   ```
3. **Los backups se sincronizarán automáticamente** a Proton Drive

## Comandos Útiles

```bash
# Ver estado de SearXNG
docker ps | grep searxng
docker logs searxng

# Reiniciar SearXNG
cd ~/searxng && docker-compose restart

# Actualizar SearXNG
cd ~/searxng
docker-compose pull
docker-compose up -d

# Ver backups disponibles
ls -lht ~/cloud-backup/claude/

# Probar búsqueda
searxng-search "test query"
```

## Troubleshooting

### SearXNG no responde
```bash
# Verificar que el contenedor está corriendo
docker ps

# Ver logs
docker logs searxng

# Reiniciar
cd ~/searxng && docker-compose restart
```

### MCP Servers no funcionan
```bash
# Verificar configuración
cat ~/.config/claude/config.json

# Reinstalar MCP servers
npx -y @modelcontextprotocol/server-fetch
npx -y @modelcontextprotocol/server-filesystem /home/shaddai
```

### Backup falla
```bash
# Verificar que el directorio existe
mkdir -p ~/cloud-backup/claude

# Ejecutar con verbose
bash -x ~/.local/bin/claude-backup backup
```

## Notas de Seguridad

- SearXNG corre en **localhost:8888** (no expuesto externamente)
- Todos los datos de búsqueda permanecen **locales**
- Sin tracking, sin logs de búsqueda
- Compatible con filosofía de **privacidad de Proton**

## Próximos Pasos

Para mejorar aún más tu setup:

1. **Configurar rclone** para sync automático con Proton Drive
2. **Agregar más MCP servers** según necesidades (postgres, etc.)
3. **Crear hooks personalizados** para automatizar tareas comunes
4. **Integrar con tus dotfiles** existentes

---

**Última actualización**: 2024-11-22
**Mantenedor**: shaddai
