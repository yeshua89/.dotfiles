# ============================================================================
# ZSH Configuration - Optimized for performance and productivity
# ============================================================================

# ----------------------------------------------------------------------------
# PATH Configuration
# ----------------------------------------------------------------------------
export PATH="$HOME/.local/bin:$PATH"

# ----------------------------------------------------------------------------
# Zinit Plugin Manager Setup
# ----------------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not installed
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source zinit
source "${ZINIT_HOME}/zinit.zsh"

# ----------------------------------------------------------------------------
# Zinit Plugins - Using turbo mode for faster startup
# ----------------------------------------------------------------------------

# Syntax highlighting - Load after other plugins for better performance
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# Autosuggestions - Load with turbo mode and custom config
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Autosuggestions configuration
ZSH_AUTOSUGGEST_STRATEGY=(history)
ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
ZSH_AUTOSUGGEST_USE_ASYNC=1
ZSH_AUTOSUGGEST_MANUAL_REBIND=1
ZSH_AUTOSUGGEST_CLEAR_WIDGETS+=(bracketed-paste)

# Completions
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# History substring search - Navigate history with up/down arrows
zinit ice wait lucid atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

# FZF integration - Disabled due to path corruption bugs
# zinit ice wait lucid
# zinit light Aloxaf/fzf-tab

# Auto-close brackets and quotes
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# Remind you to use aliases you've defined
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

# Colorize man pages
zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Web search plugin - Redundant with SearXNG
# zinit ice wait lucid
# zinit light sineto/web-search

# OMZ library for better compatibility
zinit snippet OMZ::lib/clipboard.zsh
zinit snippet OMZ::lib/git.zsh

# ----------------------------------------------------------------------------
# History Configuration
# ----------------------------------------------------------------------------
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory          # Append to history file
setopt sharehistory           # Share history between sessions
setopt hist_ignore_space      # Ignore commands starting with space
setopt hist_ignore_all_dups   # Remove older duplicate entries
setopt hist_save_no_dups      # Don't save duplicates
setopt hist_ignore_dups       # Ignore consecutive duplicates
setopt hist_find_no_dups      # Don't show duplicates when searching

# ----------------------------------------------------------------------------
# Completion System - Optimized for speed
# ----------------------------------------------------------------------------
# Completion styling (compinit handled by zinit)
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' menu no
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true

# Colorize completions using default `ls` colors
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Process completion colors
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# FZF-Tab configuration - Disabled (plugin not loaded)
# # General settings
# zstyle ':fzf-tab:*' switch-group '<' '>'

# # Disable for cd and z to avoid bugs
# # zstyle ':fzf-tab:complete:cd:*' disabled yes
# # zstyle ':fzf-tab:complete:__zoxide_z:*' disabled yes
# # zstyle ':fzf-tab:complete:z:*' disabled yes

# # Preview for kill command
# zstyle ':fzf-tab:complete:kill:argument-rest' fzf-preview 'ps --pid=$word -o cmd --no-headers -w -w'
# zstyle ':fzf-tab:complete:kill:argument-rest' fzf-flags '--preview-window=down:3:wrap'

# # Preview for systemctl
# zstyle ':fzf-tab:complete:systemctl-*:*' fzf-preview 'SYSTEMD_COLORS=1 systemctl status $word'

# # Preview for git commands with delta
# zstyle ':fzf-tab:complete:git-(add|diff|restore):*' fzf-preview 'git diff --color=always $word | delta'
# zstyle ':fzf-tab:complete:git-show:*' fzf-preview 'git show --color=always $word | delta'
# zstyle ':fzf-tab:complete:git-log:*' fzf-preview 'git log --color=always --oneline --graph --decorate $word'
# zstyle ':fzf-tab:complete:git-checkout:*' fzf-preview 'git log --color=always --oneline --graph --decorate $word'

# # Preview for environment variables
# zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'

# # Preview for man pages
# zstyle ':fzf-tab:complete:(\\|)man:*' fzf-preview 'man $word | bat --language=man --plain --color=always'

# # Preview for packages
# zstyle ':fzf-tab:complete:(pacman|yay|paru):*' fzf-preview 'pacman -Si $word 2>/dev/null || pacman -Qi $word 2>/dev/null'

# ----------------------------------------------------------------------------
# Aliases - Organized by category
# ----------------------------------------------------------------------------

# Bat (better cat)
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

# Eza (better ls) - Configured conditionally below
# alias ls='eza --icons --group-directories-first'
# alias ll='eza -lh --icons --group-directories-first'
# alias la='eza -a --icons --group-directories-first'
# alias lla='eza -lha --icons --group-directories-first'
# alias lt='eza --tree --icons --group-directories-first'

# Editors
alias v='nvim'
alias vim='nvim'
alias vi='nvim'
alias code='codium'

# Git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gaa='git add .'
alias gc='git commit -m'
alias gca='git commit -am'
alias gp='git push origin main'
alias gpl='git pull'
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate'
alias gco='git checkout'
alias gb='git branch'

# Lazy tools
alias lg='lazygit'
alias ld='lazydocker'

# GitLab
alias glab='glab'

# Proton VPN
alias vpn='protonvpn'

# Proton Pass-cli
alias pass='pass-cli'

# Claude
alias cl='claude'

# Auth0
alias auth='auth0'

# Web search - Use SearXNG aliases instead
# alias ws='web_search'

# System
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

# Quick directory access (customize to your needs)
alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias desk='cd ~/Desktop'

# Safety aliases
alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

# Disk usage - Overridden by modern tools
# alias df='df -h'
# alias du='du -h'

# Network
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'

# Package manager shortcuts (Arch Linux)
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rns'

# Modern tool aliases (if installed)
command -v eza &>/dev/null && alias ls='eza --icons --group-directories-first' && alias ll='eza -lh --icons --group-directories-first' && alias la='eza -a --icons --group-directories-first' && alias lla='eza -lha --icons --group-directories-first' && alias lt='eza --tree --icons --group-directories-first'
command -v dust &>/dev/null && alias du='dust'
command -v duf &>/dev/null && alias df='duf'
command -v procs &>/dev/null && alias ps='procs'
command -v btm &>/dev/null && alias top='btm'
command -v sd &>/dev/null && alias sed='sd'

# Git function shortcuts
alias gch='gcof'
alias gchr='gcor'
alias gst='gstash'

# Utility function shortcuts
alias hf='fh'
alias rf='rgf'
alias pv='preview'
alias mon='monitor'

# Docker shortcuts (if docker is installed)
command -v docker &>/dev/null && alias dps='docker ps' && alias dpsa='docker ps -a' && alias di='docker images' && alias dc='dce'

# Modern tools shortcuts
alias du='diskusage'
alias dsk='disks'
alias bm='bench'
alias cstat='codestats'
alias pf='psef'
alias tree='dtree'

# ----------------------------------------------------------------------------
# Functions
# ----------------------------------------------------------------------------

# Secure file deletion
rmk() {
    scrub -p dod "$1"
    shred -zun 10 -v "$1"
}

# Extract various archive types
extract() {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"    ;;
            *.tar.gz)    tar xzf "$1"    ;;
            *.bz2)       bunzip2 "$1"    ;;
            *.rar)       unrar x "$1"    ;;
            *.gz)        gunzip "$1"     ;;
            *.tar)       tar xf "$1"     ;;
            *.tbz2)      tar xjf "$1"    ;;
            *.tgz)       tar xzf "$1"    ;;
            *.zip)       unzip "$1"      ;;
            *.Z)         uncompress "$1" ;;
            *.7z)        7z x "$1"       ;;
            *)           echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# Create directory and cd into it
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Quick backup of a file
backup() {
    cp "$1"{,.bak-$(date +%Y%m%d-%H%M%S)}
}

# Search for a file and open with nvim (BRUTAL VERSION)
vf() {
    local file
    file=$(fzf --preview 'bat --color=always --style=full --line-range=:500 {}' \
               --preview-window='right:60%:wrap' \
               --header='📝 Select file to edit' \
               --border=rounded \
               --height=90%)
    [ -n "$file" ] && nvim "$file"
}

# Search directory and cd with fzf and zoxide (BRUTAL VERSION)
zf() {
    local dir
    dir=$(zoxide query -l | fzf --preview 'eza --color=always --icons=always --tree --level=2 {}' \
                                 --preview-window='right:60%:wrap' \
                                 --header='📁 Jump to directory' \
                                 --border=rounded \
                                 --height=90%)
    [ -n "$dir" ] && cd "$dir"
}

# Interactive git branch checkout (BRUTAL VERSION)
gcof() {
    local branch
    branch=$(git branch --all | grep -v HEAD |
             sed 's/^[* ]*//' | sed 's#remotes/origin/##' |
             sort -u |
             fzf --preview 'git log --oneline --graph --color=always --date=short --pretty="format:%C(auto)%h %C(blue)%an %C(green)%ar %C(auto)%s" {} | head -50' \
                 --preview-window='right:70%:wrap' \
                 --header='🌿 Checkout branch (Ctrl-Y to copy name)' \
                 --border=rounded \
                 --height=90% \
                 --bind='ctrl-y:execute-silent(echo -n {} | xclip -selection clipboard)+abort')
    [ -n "$branch" ] && git checkout "$branch"
}

# Interactive process killer (BRUTAL VERSION)
kp() {
    local pid signal=${1:-9}
    pid=$(\ps -ef | \sed 1d | \
          fzf -m --header="☠️  Select process to kill (Signal: $signal, TAB for multi)" \
              --preview 'echo {}' \
              --preview-window=down:3:wrap \
              --border=rounded \
              --height=50% | \
          awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "$pid" | xargs kill -${signal}
        echo "✓ Killed process(es) with signal $signal: $pid"
    fi
}

# Find and cd into directory (works with or without fd)
fd-cd() {
    local dir
    if command -v fd &>/dev/null; then
        dir=$(fd --type d --hidden --follow --exclude .git |
              fzf --preview 'eza --color=always --icons=always --tree --level=2 {}' \
                  --header='Find and cd to directory' \
                  --border=rounded \
                  --height=70%)
    else
        dir=$(find . -type d -name '.git' -prune -o -type d -print 2>/dev/null |
              fzf --preview 'eza --color=always --icons=always --tree --level=2 {}' \
                  --header='Find and cd to directory' \
                  --border=rounded \
                  --height=70%)
    fi
    [ -n "$dir" ] && cd "$dir"
}

# Git interactive add (BRUTAL VERSION)
gaf() {
    local files
    files=$(git status --short | \
            fzf -m --preview 'git diff --color=always {2} | delta' \
                --preview-window='right:70%:wrap' \
                --header='✨ Select files to stage (TAB for multi, Ctrl-A for all)' \
                --border=rounded \
                --height=90% \
                --bind='ctrl-a:select-all' \
                --bind='ctrl-d:deselect-all' \
                --bind='ctrl-t:toggle-all' | \
            awk '{print $2}')
    if [ -n "$files" ]; then
        echo "$files" | xargs git add
        echo ""
        echo "✓ Staged files:"
        echo "$files" | sed 's/^/  ✓ /'
        echo ""
        git status --short
    fi
}

# Search code with ripgrep + fzf (BRUTAL)
rgf() {
    local selected
    selected=$(rg --color=always --line-number --no-heading --smart-case "${*:-}" |
               fzf --ansi \
                   --delimiter : \
                   --preview 'bat --color=always --highlight-line {2} {1}' \
                   --preview-window 'up,60%,border-rounded,+{2}+3/3,~3' \
                   --header='🔍 Search in code' \
                   --border=rounded \
                   --height=90%)
    [ -n "$selected" ] && nvim "+$(echo $selected | cut -d: -f2)" "$(echo $selected | cut -d: -f1)"
}

# Interactive history search (BRUTAL)
fh() {
    local cmd
    cmd=$(history | fzf --tac --no-sort \
                        --preview 'echo {}' \
                        --preview-window=down:3:wrap \
                        --header='📜 Command history (Enter to execute, Ctrl-Y to copy)' \
                        --border=rounded \
                        --height=50% \
                        --bind='ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort' | \
          sed 's/^ *[0-9]* *//')
    [ -n "$cmd" ] && print -z "$cmd"
}

# Git stash interactive (BRUTAL)
gstash() {
    local stash
    stash=$(git stash list | \
            fzf --preview 'git stash show -p $(echo {} | cut -d: -f1) | delta' \
                --preview-window='right:70%:wrap' \
                --header='📦 Select stash (Enter to apply, Ctrl-D to drop)' \
                --border=rounded \
                --height=90% \
                --bind='ctrl-d:execute(git stash drop $(echo {} | cut -d: -f1))+reload(git stash list)')
    [ -n "$stash" ] && git stash pop "$(echo $stash | cut -d: -f1)"
}

# Quick file preview (BRUTAL)
preview() {
    local file="$1"
    if [ -z "$file" ]; then
        file=$(fzf --preview 'bat --color=always --style=full {}' \
                   --preview-window='right:70%:wrap' \
                   --header='👁️  Preview file' \
                   --border=rounded \
                   --height=90%)
    fi
    [ -n "$file" ] && bat --paging=always "$file"
}

# Git checkout recent branches (BRUTAL)
gcor() {
    local branch
    branch=$(git reflog | \
             grep 'checkout:' | \
             sed 's/.* to //' | \
             awk '!seen[$0]++' | \
             head -20 | \
             fzf --preview 'git log --oneline --graph --color=always --date=short {} | head -50' \
                 --preview-window='right:70%:wrap' \
                 --header='🔄 Recent branches' \
                 --border=rounded \
                 --height=70%)
    [ -n "$branch" ] && git checkout "$branch"
}

# Docker container selector (if docker is installed)
dce() {
    local container
    container=$(docker ps -a --format '{{.Names}}\t{{.Status}}\t{{.Image}}' | \
                fzf --header='🐳 Select container (Enter to exec bash)' \
                    --preview 'docker logs --tail 100 $(echo {} | cut -f1)' \
                    --preview-window='right:60%:wrap' \
                    --border=rounded \
                    --height=70%)
    [ -n "$container" ] && docker exec -it "$(echo $container | cut -f1)" bash
}

# System resource monitor shortcut
monitor() {
    if command -v btm &>/dev/null; then
        btm
    elif command -v htop &>/dev/null; then
        htop
    else
        top
    fi
}

# Disk usage analyzer with dust
diskusage() {
    local dir="${1:-.}"
    if command -v dust &>/dev/null; then
        dust -r "$dir"
    else
        du -h "$dir" | sort -hr | head -20
    fi
}

# Compare disk usage between directories
diskcompare() {
    if command -v dust &>/dev/null; then
        echo "=== Directory 1: ${1:-.} ==="
        dust -r -d 1 "${1:-.}"
        echo ""
        echo "=== Directory 2: ${2:-.} ==="
        dust -r -d 1 "${2:-.}"
    fi
}

# Quick benchmark with hyperfine
bench() {
    if command -v hyperfine &>/dev/null; then
        hyperfine --warmup 3 "$@"
    else
        echo "Install hyperfine: sudo pacman -S hyperfine"
    fi
}

# Code statistics with tokei
codestats() {
    if command -v tokei &>/dev/null; then
        tokei "${1:-.}" --sort lines
    else
        echo "Install tokei: sudo pacman -S tokei"
    fi
}

# Interactive process selector with procs + fzf
psef() {
    if command -v procs &>/dev/null; then
        local pid
        pid=$(procs | tail -n +2 | \
              fzf --header='🔍 Select process (Enter to kill)' \
                  --preview 'echo {}' \
                  --preview-window=down:3:wrap \
                  --border=rounded \
                  --height=70% | \
              awk '{print $1}')
        if [ -n "$pid" ]; then
            echo "Kill process $pid? (y/n)"
            read -q && kill -15 "$pid" && echo "\n✓ Process $pid terminated"
        fi
    else
        kp
    fi
}

# Quick file find and preview
ff() {
    local file
    if command -v fd &>/dev/null; then
        file=$(fd --type f --hidden --follow --exclude .git |
               fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}' \
                   --preview-window='right:60%:wrap' \
                   --header='🔍 Find file' \
                   --border=rounded \
                   --height=80%)
    else
        file=$(find . -type f -not -path '*/\.git/*' 2>/dev/null |
               fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}' \
                   --preview-window='right:60%:wrap' \
                   --header='🔍 Find file' \
                   --border=rounded \
                   --height=80%)
    fi
    [ -n "$file" ] && echo "$file"
}

# Directory size with eza tree
dtree() {
    local depth="${1:-2}"
    if command -v eza &>/dev/null; then
        eza --tree --level="$depth" --icons --git-ignore
    else
        tree -L "$depth" -I '.git'
    fi
}

# Advanced eza with git status
lsg() {
    if command -v eza &>/dev/null; then
        eza --long --git --icons --group-directories-first --header
    else
        ls -lah
    fi
}

# Show all files including hidden, sorted by size
lss() {
    if command -v eza &>/dev/null; then
        eza --long --all --sort=size --reverse --icons --group-directories-first
    else
        ls -lhS
    fi
}

# Show files sorted by modification time
lst() {
    if command -v eza &>/dev/null; then
        eza --long --all --sort=modified --reverse --icons --group-directories-first
    else
        ls -lht
    fi
}

# Disk info with duf
disks() {
    if command -v duf &>/dev/null; then
        duf
    else
        df -h
    fi
}

# Quick help with tldr
help() {
    if command -v tldr &>/dev/null; then
        tldr "$@"
    else
        man "$@"
    fi
}

# ----------------------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------------------

# Load sensitive environment variables from .env file
[ -f ~/.env ] && source ~/.env

# LS_COLORS for better file colors
export LS_COLORS="rs=0:di=34:ln=4;36:mh=00:pi=33:so=01;35:bd=33;01:cd=33;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"

# Default editor
export EDITOR='nvim'
export VISUAL='nvim'

# FZF default options - ULTIMATE SETUP
export FZF_DEFAULT_OPTS="--height 60% --layout=reverse --border=rounded --inline-info \
  --preview-window=right:50%:wrap \
  --bind='ctrl-/:toggle-preview' \
  --bind='ctrl-u:preview-half-page-up' \
  --bind='ctrl-d:preview-half-page-down' \
  --bind='ctrl-f:preview-page-down' \
  --bind='ctrl-b:preview-page-up' \
  --bind='ctrl-a:select-all' \
  --bind='ctrl-t:toggle-all' \
  --bind='ctrl-y:execute-silent(echo -n {+} | xclip -selection clipboard)' \
  --bind='alt-up:preview-up' \
  --bind='alt-down:preview-down' \
  --color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7 \
  --color=fg+:#c0caf5,bg+:#1f2335,hl+:#7dcfff \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a \
  --color=border:#565f89,preview-bg:#1a1b26 \
  --pointer='▶' --marker='✓' --prompt='❯ ' \
  --info=inline"

# Use fd or ripgrep for better fzf performance
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=never'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --color=never'
elif command -v rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# ----------------------------------------------------------------------------
# Key Bindings
# ----------------------------------------------------------------------------

# Better line navigation
bindkey "^[[H" beginning-of-line      # Home
bindkey "^[[F" end-of-line            # End
bindkey "^[[3~" delete-char           # Delete
bindkey "^[[1;3C" forward-word        # Alt+Right
bindkey "^[[1;3D" backward-word       # Alt+Left

# Ctrl+Z to foreground last suspended process
foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey '^Z' foreground-current-job

# Ctrl+F to open file finder (vf function)
open-file-finder() {
    zle -I
    vf
    zle reset-prompt
}
zle -N open-file-finder
bindkey '^F' open-file-finder

# Ctrl+G to open directory finder (zf function)
open-dir-finder() {
    zle -I
    zf
    zle reset-prompt
}
zle -N open-dir-finder
bindkey '^G' open-dir-finder

# Ctrl+R for fzf history search (built-in with fzf)
# This is automatically configured by fzf --zsh

# Alt+C for cd finder (built-in with fzf)
# This is automatically configured by fzf --zsh

# ----------------------------------------------------------------------------
# Shell Options
# ----------------------------------------------------------------------------

setopt auto_cd              # Auto cd when typing just a path
setopt auto_pushd           # Push directories onto stack
setopt pushd_ignore_dups    # Don't push duplicates
setopt pushdminus           # Swap +/- for pushd
setopt correct              # Spelling correction
setopt interactive_comments # Allow comments in interactive shell
setopt multios              # Enable multiple redirections
setopt prompt_subst         # Enable prompt substitution

# ----------------------------------------------------------------------------
# Tool Initializations - Load at the end for best performance
# ----------------------------------------------------------------------------

# FZF
source <(fzf --zsh)

# Starship prompt
eval "$(starship init zsh)"

# Fnm (Fast Node Manager)
eval "$(fnm env --use-on-cd --shell zsh)"

# Zoxide (better cd)
eval "$(zoxide init zsh)"

# ----------------------------------------------------------------------------
# Optional: Uncomment to enable
# ----------------------------------------------------------------------------

# Vi mode (uncomment if you prefer vi keybindings)
# bindkey -v

# Auto-update check reminder (runs once a week)
# if [[ ! -f ~/.zsh_update_check ]] || [[ $(find ~/.zsh_update_check -mtime +7) ]]; then
#     echo "Run 'zinit update' to update plugins"
#     touch ~/.zsh_update_check
# fi

# ----------------------------------------------------------------------------
# Claude Code Integration
# ----------------------------------------------------------------------------
[ -f ~/.config/claude/aliases.zsh ] && source ~/.config/claude/aliases.zsh

# ============================================================================
# End of configuration
# ============================================================================
