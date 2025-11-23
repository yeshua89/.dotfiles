# Cómo Usar Claude Code al 1000% de Eficiencia

## 🎯 Filosofía: Habla Natural, Yo Ejecuto

**No necesitas ser específico, habla como hablarías con un colega:**

### ❌ Antes (tedioso):
```bash
# Tú ejecutas comandos paso a paso
find . -name "*.js" -type f
grep -r "function login" .
cat src/auth.js
vim src/auth.js
```

### ✅ Ahora (eficiente):
```
"busca todos los archivos JS que tengan la función login y muéstramelos"
```
**Yo hago todo:** busco, leo, analizo y te muestro el resultado.

---

## 🚀 Comandos Ultra-Rápidos (Nuevos Aliases)

### Búsqueda Web Instantánea
```bash
s "nginx exploit 2024"        # Búsqueda general (todos los motores)
cve "postgresql"              # Solo CVEs/exploits (Exploit-DB)
gh "neovim plugins"           # Solo GitHub
so "fastify vs express"       # Stack Overflow
aw "pacman hooks"             # Arch Wiki
w "linux kernel"              # Wikipedia
ddg "privacy tools"           # DuckDuckGo
go "specific technical query" # Google (para resultados técnicos profundos)
```

### Claude Management
```bash
cs                            # Sync configuración a git (auto-commit + push)
cc                            # Verificar que todo funciona
```

### SearXNG Control
```bash
xs                            # Start SearXNG
xr                            # Restart SearXNG
xl                            # Ver logs en tiempo real
```

### Security/Hacking
```bash
nq 192.168.1.1               # Nmap quick scan
ps 192.168.1.1               # Full port scan (todos los puertos)
revshell 10.0.0.5 4444       # Generar reverse shells
```

### Utils Rápidos
```bash
j                             # Pretty print JSON (pipe it)
b64 "text"                    # Encode base64
b64d "encoded"                # Decode base64
serve                         # HTTP server puerto 8000
```

---

## 💬 Cómo Hablarme para Máxima Eficiencia

### 1️⃣ **Tareas de Búsqueda/Análisis**

**Búsqueda en Codebase:**
```
"busca todos los usos de la función connectDB"
"muéstrame todos los archivos que importan express"
"encuentra dónde se define la clase User"
```

**Análisis de Código:**
```
"explícame qué hace este archivo src/auth.js"
"hay algún problema de seguridad en este código?"
"por qué este endpoint es lento?"
```

**Búsqueda Web (yo uso SearXNG):**
```
"busca vulnerabilidades de nginx 1.18"
"últimas CVEs de postgresql"
"documentación oficial de fastify"
```

### 2️⃣ **Tareas de Modificación**

**Edición de Código:**
```
"agrega validación de email en este endpoint"
"refactoriza esta función para que sea más legible"
"corrige este bug: [descripción]"
```

**Creación de Archivos:**
```
"crea un middleware de autenticación JWT"
"necesito un docker-compose para postgres + redis"
"hazme un script que haga backup de la DB"
```

### 3️⃣ **Tareas de DevOps/Sistema**

**Git:**
```
"crea un commit con estos cambios"
"muéstrame el diff del último commit"
"crea una PR para esta feature"
```

**Docker:**
```
"levanta los contenedores"
"muéstrame los logs de postgres"
"reconstruye la imagen de node"
```

**Sistema:**
```
"qué procesos están usando más RAM?"
"hay algún puerto en escucha sospechoso?"
"muéstrame el uso de disco"
```

### 4️⃣ **Tareas de Seguridad/Hacking**

**Reconocimiento:**
```
"escanea la red 192.168.1.0/24"
"busca exploits para apache 2.4.49"
"analiza estos logs de nginx para encontrar ataques"
```

**Análisis de Vulnerabilidades:**
```
"revisa este código y dime si tiene SQL injection"
"hay XSS en este endpoint?"
"analiza esta config de nginx"
```

---

## ⚡ Trucos Pro para Velocidad

### Uso de Paralelización
**Yo ejecuto 5 agentes en paralelo. Aprovéchalo:**

❌ **Ineficiente (uno por uno):**
```
"busca el archivo config.js"
[esperas respuesta]
"ahora léelo"
[esperas respuesta]
"busca en google cómo se usa esta librería"
```

✅ **Eficiente (todo de una):**
```
"busca config.js, léelo y búscame en google
documentación de las librerías que usa"
```
**Resultado:** 3 tareas en el tiempo de 1.

### Contexto Implícito
**Yo recuerdo la conversación, no repitas:**

❌ **Redundante:**
```
"lee src/auth.js"
[muestro el archivo]
"ahora edita src/auth.js y agrega..."
```

✅ **Directo:**
```
"lee src/auth.js"
[muestro el archivo]
"agrega validación de email en la línea 45"
```
Ya sé de qué archivo hablas.

### Búsqueda Privada Integrada
**Yo busco por ti en SearXNG (privado, local):**

En lugar de:
1. Abrir navegador
2. Buscar en Google
3. Leer resultados
4. Volver a la terminal

Haz:
```
"busca vulnerabilidades de express 4.17"
```
Yo busco, analizo y te doy resumen.

---

## 🧠 Mi Configuración Actual (Por Qué Soy Eficiente)

### MCP Servers Activos
- **fetch**: Puedo hacer búsquedas web por ti
- **filesystem**: Acceso directo a archivos (más rápido que bash)

### Rendimiento
- **5 agentes paralelos**: Hago 5 cosas a la vez
- **Cache habilitado**: Si repites algo, respondo instantáneo
- **Prefetch**: Anticipo lo que necesitarás

### SearXNG (Tu Metabuscador Privado)
- **DuckDuckGo + Google + GitHub + Stack Overflow + Exploit-DB**
- 100% local, sin tracking
- Yo lo uso automáticamente cuando busco info

---

## 📋 Workflows Completos Reales

### Workflow 1: Feature Nueva
```
Tú: "necesito agregar login con JWT en mi API"

Yo:
1. Busco en tu codebase estructura actual
2. Busco best practices de JWT (SearXNG)
3. Creo middleware de autenticación
4. Creo endpoint /login
5. Agrego validaciones
6. Creo tests
7. Actualizo documentación

Todo en una conversación.
```

### Workflow 2: Bug Hunting
```
Tú: "el endpoint /users es lento"

Yo:
1. Leo el código del endpoint
2. Analizo queries a DB
3. Busco N+1 queries
4. Reviso índices en DB
5. Sugiero optimizaciones
6. Implemento fix
7. Verifico performance
```

### Workflow 3: Security Audit
```
Tú: "revisa seguridad de mi API"

Yo:
1. Analizo todos los endpoints
2. Busco SQLi, XSS, CSRF
3. Reviso autenticación/autorización
4. Chequeo rate limiting
5. Reviso headers de seguridad
6. Busco CVEs en dependencias (npm audit)
7. Genero reporte con fixes
```

### Workflow 4: Setup Nuevo Proyecto
```
Tú: "quiero crear API REST con fastify + postgres"

Yo:
1. Creo estructura de proyecto
2. Setup package.json con deps
3. Creo docker-compose.yml
4. Config de DB con migrations
5. Endpoints base + middleware
6. Logging y error handling
7. README con setup instructions
```

---

## 🎓 Tips Avanzados

### 1. Comandos Encadenados
```
"busca todos los TODO en el código, créame issues en GitHub
para cada uno, y genera un roadmap en markdown"
```

### 2. Uso de tu .zshrc
**Ya tienes funciones brutales, úsalas CON Claude:**
```
Tú: "vf"  # (tu función fuzzy find + edit)
[seleccionas archivo]
"este archivo tiene un bug en la línea 34, corrígelo"
```

### 3. Integración con tus Tools
**Ya tienes: lazygit, lazydocker, btop, etc.**
```
"abre lazydocker y dime qué contenedor está usando más recursos,
luego optimiza su config"
```

### 4. Quick Notes
**Yo puedo ser tu segundo cerebro:**
```
Tú durante el día:
"recuérdame: mañana tengo que actualizar la librería X"
"recuérdame: bug en el endpoint Y, revisar logs"

Al otro día:
"qué me dijiste que recordara?"
```

### 5. Context Switching Rápido
```
"estoy trabajando en feature-auth branch, muéstrame qué cambié"
[muestro diff]
"ok, cambia a main y hazme una hotfix para el bug Z"
[cambio branch y fixeo]
"vuelve a feature-auth y continúa"
```

---

## 🔥 Casos de Uso Real (Backend/Security)

### Bug de Producción (urgente)
```
Tú: "hay error 500 en /api/users, logs adjuntos"

Yo en 30 segundos:
1. Leo logs
2. Identifico stack trace
3. Busco código afectado
4. Encuentro causa (null pointer)
5. Creo fix
6. Creo commit
7. Subo a PR
```

### Exploit Development
```
Tú: "encontré un buffer overflow en este binario"

Yo:
1. Analizo el binario (si me lo pasas)
2. Busco exploits similares
3. Genero payload
4. Creo script de exploit
5. Documentado paso a paso
```

### API Security Review
```
Tú: "audita seguridad de estos 15 endpoints"

Yo en paralelo:
1. Analizo todos a la vez (5 agentes)
2. Detecto vulnerabilidades
3. Busco CVEs en deps
4. Genero reporte con severity
5. Proveo fixes para c/u
```

---

## 🚨 Lo Que NO Debes Hacer

❌ Usar comandos cuando puedes hablar:
```
Mal:  "ejecuta grep -r 'function' ."
Bien: "busca todas las funciones"
```

❌ Hacer paso a paso cuando puedes hacer todo:
```
Mal:  "busca archivo" → "léelo" → "edita"
Bien: "busca archivo X, léelo y agrega validación"
```

❌ Buscar en Google manualmente:
```
Mal:  Abrir navegador y buscar
Bien: "busca vulnerabilidades de..."
```

❌ Olvidar que tengo contexto:
```
Mal:  Repetir paths/nombres cada mensaje
Bien: Referirte a "ese archivo" o "la función que vimos"
```

---

## 📊 Resumen: Tu Setup Ahora

**Terminal → ZSH (brutal) → Claude Code (yo) → SearXNG (privado)**

Tienes:
- ✓ 5 agentes paralelos
- ✓ Búsqueda web privada integrada
- ✓ Aliases ultra-cortos
- ✓ Funciones fzf brutal en .zshrc
- ✓ Backup automático con git
- ✓ Todo portable en dotfiles

**Resultado:**
Trabajas 5x más rápido que antes.
Yo hago el trabajo pesado.
Tú te enfocas en pensar, no en ejecutar.

---

**Empieza ahora:**
"muéstrame mi proyecto más reciente y hazme un análisis de seguridad"
