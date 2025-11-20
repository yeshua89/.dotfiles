# ============================================================================
# ZSH Configuration - Optimized for performance and productivity
# ============================================================================

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

# Autosuggestions - Load with turbo mode
zinit ice wait lucid atload"_zsh_autosuggest_start"
zinit light zsh-users/zsh-autosuggestions

# Completions
zinit ice wait lucid blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# History substring search - Navigate history with up/down arrows
zinit ice wait lucid atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down"
zinit light zsh-users/zsh-history-substring-search

# FZF integration for better tab completion
zinit ice wait lucid
zinit light Aloxaf/fzf-tab

# Auto-close brackets and quotes
zinit ice wait lucid
zinit light hlissner/zsh-autopair

# Remind you to use aliases you've defined
zinit ice wait lucid
zinit light MichaelAquilina/zsh-you-should-use

# Colorize man pages
zinit ice wait lucid
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

# Web search plugin
zinit ice wait lucid
zinit light sineto/web-search

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
# Note: compinit is handled by zinit on line 24
# Completion styling
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

# FZF-Tab configuration
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'lsd --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'lsd --color=always $realpath'

# ----------------------------------------------------------------------------
# Aliases - Organized by category
# ----------------------------------------------------------------------------

# Bat (better cat)
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

# Lsd (better ls)
alias ls='lsd --group-dirs=first'
alias l='lsd --group-dirs=first'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias lt='lsd --tree --group-dirs=first'

# Editors
alias v='nvim'
alias vim='nvim'
alias vi='nvim'
alias code='codium'
alias codin='code-insiders'

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

# VPN
alias vpn='protonvpn'

# Claude
alias cl='claude'

# Auth0
alias auth='auth0'

# Web search
alias ws='web_search'

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

# Disk usage
alias df='df -h'
alias du='du -h'

# Network
alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'

# Package manager shortcuts (Arch Linux)
alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rns'

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

# Search for a file and open with nvim
vf() {
    local file
    file=$(fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}')
    [ -n "$file" ] && nvim "$file"
}

# Search directory and cd with fzf and zoxide
zf() {
    local dir
    dir=$(zoxide query -l | fzf --preview 'lsd --color=always {}') && cd "$dir"
}

# ----------------------------------------------------------------------------
# Environment Variables
# ----------------------------------------------------------------------------

# Load sensitive environment variables from .env file
[ -f ~/.env ] && source ~/.env

# LS_COLORS for better file colors
export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=33:so=01;35:bd=33;01:cd=33;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"

# Default editor
export EDITOR='nvim'
export VISUAL='nvim'

# FZF default options
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border --inline-info \
  --color=fg:#c0caf5,bg:#1a1b26,hl:#7aa2f7 \
  --color=fg+:#c0caf5,bg+:#1f2335,hl+:#7dcfff \
  --color=info:#7aa2f7,prompt:#7dcfff,pointer:#7dcfff \
  --color=marker:#9ece6a,spinner:#9ece6a,header:#9ece6a"

# Use fd for better fzf performance (if installed)
if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
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

# ============================================================================
# End of configuration
# ============================================================================
