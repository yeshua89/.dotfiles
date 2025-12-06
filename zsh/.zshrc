# PATH Configuration
export PATH="$HOME/.local/bin:$PATH"

# Zinit Plugin Manager Setup
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit if not installed
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "${ZINIT_HOME}/zinit.zsh"

# Suppress Zinit output
ZINIT[COMPINIT_OPTS]=-C
ZINIT[OPTIMIZE_OUT_DISK_ACCESSES]=1

# Zinit Plugins
zinit ice wait lucid atinit"ZINIT[COMPINIT_OPTS]=-C; zicompinit; zicdreplay" silent
zinit light zdharma-continuum/fast-syntax-highlighting

export ZSH_AUTOSUGGEST_STRATEGY=history
export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
export ZSH_AUTOSUGGEST_USE_ASYNC=1
export ZSH_AUTOSUGGEST_MANUAL_REBIND=1

zinit ice wait lucid atload"_zsh_autosuggest_start" silent
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid blockf atpull'zinit creinstall -q .' silent
zinit light zsh-users/zsh-completions

zinit ice wait lucid atload"bindkey '^[[A' history-substring-search-up; bindkey '^[[B' history-substring-search-down" silent
zinit light zsh-users/zsh-history-substring-search

zinit ice wait lucid silent
zinit light hlissner/zsh-autopair

zinit ice wait lucid silent
zinit light MichaelAquilina/zsh-you-should-use

zinit ice wait lucid silent
zinit snippet OMZ::plugins/colored-man-pages/colored-man-pages.plugin.zsh

zinit ice silent
zinit snippet OMZ::lib/clipboard.zsh

zinit ice silent
zinit snippet OMZ::lib/git.zsh

# History Configuration
HISTSIZE=10000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase

setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion System
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$HOME/.zsh/cache"
zstyle ':completion:*' menu no
zstyle ':completion:*' complete-options true
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' special-dirs true

eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# Aliases
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

alias v='nvim'
alias vim='nvim'
alias vi='nvim'
alias code='codium'

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

alias lg='lazygit'
alias ld='lazydocker'
alias y='yazi'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias -- -='cd -'

alias dl='cd ~/Downloads'
alias docs='cd ~/Documents'
alias desk='cd ~/Desktop'

alias cp='cp -iv'
alias mv='mv -iv'
alias rm='rm -iv'
alias mkdir='mkdir -pv'

alias myip='curl -s ifconfig.me'
alias ports='netstat -tulanp'

alias update='sudo pacman -Syu'
alias install='sudo pacman -S'
alias search='pacman -Ss'
alias remove='sudo pacman -Rns'

alias clc='claude'
alias pass='pass-cli'

# Conditional modern tool aliases
command -v eza &>/dev/null && alias ls='eza --icons --group-directories-first' && alias ll='eza -lh --icons --group-directories-first' && alias la='eza -a --icons --group-directories-first' && alias lla='eza -lha --icons --group-directories-first' && alias lt='eza --tree --icons --group-directories-first'
command -v dust &>/dev/null && alias dust='dust'
command -v duf &>/dev/null && alias df='duf'
command -v procs &>/dev/null && alias ps='procs'
command -v btm &>/dev/null && alias top='btm'
command -v sd &>/dev/null && alias sed='sd'
command -v docker &>/dev/null && alias dps='docker ps' && alias dpsa='docker ps -a' && alias di='docker images' && alias dc='dce'

# Function shortcuts
alias gch='gcof'
alias gchr='gcor'
alias gst='gstash'
alias hf='fh'
alias rf='rgf'
alias pv='preview'
alias mon='monitor'
alias du='diskusage'
alias dsk='disks'
alias bm='bench'
alias cstat='codestats'
alias pf='psef'
alias tree='dtree'

# Functions
rmk() {
    scrub -p dod "$1"
    shred -zun 10 -v "$1"
}

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

mkcd() {
    mkdir -p "$1" && cd "$1"
}

backup() {
    cp "$1"{,.bak-$(date +%Y%m%d-%H%M%S)}
}

vf() {
    local file
    file=$(fzf --preview 'bat --color=always --style=full --line-range=:500 {}' \
               --preview-window='right:60%:wrap' \
               --header='Select file to edit' \
               --border=rounded \
               --height=90%)
    [ -n "$file" ] && nvim "$file"
}

zf() {
    local dir
    dir=$(zoxide query -l | fzf --preview 'eza --color=always --icons=always --tree --level=2 {}' \
                                 --preview-window='right:60%:wrap' \
                                 --header='Jump to directory' \
                                 --border=rounded \
                                 --height=90%)
    [ -n "$dir" ] && cd "$dir"
}

gcof() {
    local branch
    branch=$(git branch --all | grep -v HEAD |
             \sed 's/^[* ]*//' | \sed 's#remotes/origin/##' |
             sort -u |
             fzf --preview 'git log --oneline --graph --color=always --date=short --pretty="format:%C(auto)%h %C(blue)%an %C(green)%ar %C(auto)%s" {} | head -50' \
                 --preview-window='right:70%:wrap' \
                 --header='Checkout branch (Ctrl-Y to copy)' \
                 --border=rounded \
                 --height=90% \
                 --bind='ctrl-y:execute-silent(echo -n {} | xclip -selection clipboard)+abort')
    [ -n "$branch" ] && git checkout "$branch"
}

kp() {
    local pid signal=${1:-9}
    pid=$(\ps -ef | \sed 1d | \
          fzf -m --header="Select process to kill (Signal: $signal, TAB for multi)" \
              --preview 'echo {}' \
              --preview-window=down:3:wrap \
              --border=rounded \
              --height=50% | \
          awk '{print $2}')
    if [ -n "$pid" ]; then
        echo "$pid" | xargs kill -${signal}
        echo "Killed process(es): $pid"
    fi
}

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

gaf() {
    local files
    files=$(git status --short | \
            fzf -m --preview 'git diff --color=always {2} | delta' \
                --preview-window='right:70%:wrap' \
                --header='Select files to stage (TAB for multi)' \
                --border=rounded \
                --height=90% \
                --bind='ctrl-a:select-all' \
                --bind='ctrl-d:deselect-all' \
                --bind='ctrl-t:toggle-all' | \
            awk '{print $2}')
    if [ -n "$files" ]; then
        echo "$files" | xargs git add
        echo "\nStaged files:"
        echo "$files" | \sed 's/^/  /'
        echo ""
        git status --short
    fi
}

rgf() {
    local selected
    selected=$(rg --color=always --line-number --no-heading --smart-case "${*:-}" |
               fzf --ansi \
                   --delimiter : \
                   --preview 'bat --color=always --highlight-line {2} {1}' \
                   --preview-window 'up,60%,border-rounded,+{2}+3/3,~3' \
                   --header='Search in code' \
                   --border=rounded \
                   --height=90%)
    [ -n "$selected" ] && nvim "+$(echo $selected | cut -d: -f2)" "$(echo $selected | cut -d: -f1)"
}

fh() {
    local cmd
    cmd=$(history | fzf --tac --no-sort \
                        --preview 'echo {}' \
                        --preview-window=down:3:wrap \
                        --header='Command history (Enter to execute, Ctrl-Y to copy)' \
                        --border=rounded \
                        --height=50% \
                        --bind='ctrl-y:execute-silent(echo -n {2..} | xclip -selection clipboard)+abort' | \
          \sed 's/^ *[0-9]* *//')
    [ -n "$cmd" ] && print -z "$cmd"
}

gstash() {
    local stash
    stash=$(git stash list | \
            fzf --preview 'git stash show -p $(echo {} | cut -d: -f1) | delta' \
                --preview-window='right:70%:wrap' \
                --header='Select stash (Enter to apply, Ctrl-D to drop)' \
                --border=rounded \
                --height=90% \
                --bind='ctrl-d:execute(git stash drop $(echo {} | cut -d: -f1))+reload(git stash list)')
    [ -n "$stash" ] && git stash pop "$(echo $stash | cut -d: -f1)"
}

preview() {
    local file="$1"
    if [ -z "$file" ]; then
        file=$(fzf --preview 'bat --color=always --style=full {}' \
                   --preview-window='right:70%:wrap' \
                   --header='Preview file' \
                   --border=rounded \
                   --height=90%)
    fi
    [ -n "$file" ] && bat --paging=always "$file"
}

gcor() {
    local branch
    branch=$(git reflog | \
             grep 'checkout:' | \
             \sed 's/.* to //' | \
             awk '!seen[$0]++' | \
             head -20 | \
             fzf --preview 'git log --oneline --graph --color=always --date=short {} | head -50' \
                 --preview-window='right:70%:wrap' \
                 --header='Recent branches' \
                 --border=rounded \
                 --height=70%)
    [ -n "$branch" ] && git checkout "$branch"
}

dce() {
    local container
    container=$(docker ps -a --format '{{.Names}}\t{{.Status}}\t{{.Image}}' | \
                fzf --header='Select container (Enter to exec bash)' \
                    --preview 'docker logs --tail 100 $(echo {} | cut -f1)' \
                    --preview-window='right:60%:wrap' \
                    --border=rounded \
                    --height=70%)
    [ -n "$container" ] && docker exec -it "$(echo $container | cut -f1)" bash
}

monitor() {
    if command -v btm &>/dev/null; then
        btm
    elif command -v htop &>/dev/null; then
        htop
    else
        top
    fi
}

diskusage() {
    local dir="${1:-.}"
    if command -v dust &>/dev/null; then
        dust -r "$dir"
    else
        du -h "$dir" | sort -hr | head -20
    fi
}

diskcompare() {
    if command -v dust &>/dev/null; then
        echo "=== Directory 1: ${1:-.} ==="
        dust -r -d 1 "${1:-.}"
        echo ""
        echo "=== Directory 2: ${2:-.} ==="
        dust -r -d 1 "${2:-.}"
    fi
}

bench() {
    if command -v hyperfine &>/dev/null; then
        hyperfine --warmup 3 "$@"
    else
        echo "Install hyperfine: sudo pacman -S hyperfine"
    fi
}

codestats() {
    if command -v tokei &>/dev/null; then
        tokei "${1:-.}" --sort lines
    else
        echo "Install tokei: sudo pacman -S tokei"
    fi
}

psef() {
    if command -v procs &>/dev/null; then
        local pid
        pid=$(procs | tail -n +2 | \
              fzf --header='Select process (Enter to kill)' \
                  --preview 'echo {}' \
                  --preview-window=down:3:wrap \
                  --border=rounded \
                  --height=70% | \
              awk '{print $1}')
        if [ -n "$pid" ]; then
            echo "Kill process $pid? (y/n)"
            read -q && kill -15 "$pid" && echo "\nProcess $pid terminated"
        fi
    else
        kp
    fi
}

ff() {
    local file
    if command -v fd &>/dev/null; then
        file=$(fd --type f --hidden --follow --exclude .git |
               fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}' \
                   --preview-window='right:60%:wrap' \
                   --header='Find file' \
                   --border=rounded \
                   --height=80%)
    else
        file=$(find . -type f -not -path '*/\.git/*' 2>/dev/null |
               fzf --preview 'bat --color=always --style=numbers --line-range=:100 {}' \
                   --preview-window='right:60%:wrap' \
                   --header='Find file' \
                   --border=rounded \
                   --height=80%)
    fi
    [ -n "$file" ] && echo "$file"
}

dtree() {
    local depth="${1:-2}"
    if command -v eza &>/dev/null; then
        eza --tree --level="$depth" --icons --git-ignore
    else
        tree -L "$depth" -I '.git'
    fi
}

lsg() {
    if command -v eza &>/dev/null; then
        eza --long --git --icons --group-directories-first --header
    else
        ls -lah
    fi
}

lss() {
    if command -v eza &>/dev/null; then
        eza --long --all --sort=size --reverse --icons --group-directories-first
    else
        ls -lhS
    fi
}

lst() {
    if command -v eza &>/dev/null; then
        eza --long --all --sort=modified --reverse --icons --group-directories-first
    else
        ls -lht
    fi
}

disks() {
    if command -v duf &>/dev/null; then
        duf
    else
        df -h
    fi
}

help() {
    if command -v tldr &>/dev/null; then
        tldr "$@"
    else
        man "$@"
    fi
}

# Environment Variables
[ -f ~/.env ] && source ~/.env

export LS_COLORS="rs=0:di=01;37:ln=01;04;90:mh=00:pi=33:so=01;35:bd=33;01:cd=33;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32"
export EDITOR='nvim'
export VISUAL='nvim'

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

if command -v fd &> /dev/null; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git --color=never'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git --color=never'
elif command -v rg &> /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Key Bindings
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word

foreground-current-job() { fg; }
zle -N foreground-current-job
bindkey '^Z' foreground-current-job

open-file-finder() {
    zle -I
    vf
    zle reset-prompt
}
zle -N open-file-finder
bindkey '^F' open-file-finder

open-dir-finder() {
    zle -I
    zf
    zle reset-prompt
}
zle -N open-dir-finder
bindkey '^G' open-dir-finder

# Shell Options
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt correct
setopt interactive_comments
setopt multios
setopt prompt_subst

# Tool Initializations
source <(fzf --zsh)
eval "$(starship init zsh)"
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"

# Claude Code Integration
[ -f ~/.config/claude/aliases.zsh ] && source ~/.config/claude/aliases.zsh
