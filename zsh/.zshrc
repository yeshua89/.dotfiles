# Created by newuser for 5.9
# Set the directory we want to share to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/load zinit
source "${ZINIT_HOME}/zinit.zsh"
# source ~/.okta-completion.zsh

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light marlonrichert/zsh-autocomplete
zinit light Aloxaf/fzf-tab
zinit light sineto/web-search
zinit light hlissner/zsh-autopair

# Custom Aliases

# Bat
alias cat='bat'
alias catn='bat --style=plain'
alias catnp='bat --style=plain --paging=never'

# Lsd 
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

# Vim and VsCode and Windsurf
alias nv='nvim'
alias code='code'
alias codin='code-insiders'
alias surf='windsurf'

# Web-Search
alias ws='web_search'

# Auth0
alias auth='auth0'

# Git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin main'
alias gpl='git pull'
alias gs='git status'

# Lazy Git 
alias lg='lazygit'

# GitLab
alias gl='glab'

# Lazy Docker
alias ld='lazydocker'

# Use modern completion system
autoload -Uz compinit;
compinit

zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _expand _complete _correct _approximate
zstyle ':completion:*' format 'Completing %d'
zstyle ':completion:*' group-name ''
# zstyle ':completion:*' menu select=2
zstyle ':completion:*' menu no
eval "$(dircolors -b)"
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:' matcher-list '' 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]= r:|=* l:|=*'
# zstyle ':completion:*' menu select=long
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath' 

# zstyle ':fzf-tab:complete:z:*' fzf-preview 'ls --color $realpath'

zstyle ':completion:::kill::processes' list-colors '=(#b) #([0-9]#)=0=01;31'
zstyle ':completion::kill:' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
source <(fzf --zsh)

# Función para usar fzf con zoxide
# z() {
#     local dir
#     dir=$(zoxide query -l | fzf) && cd "$dir"
# }

# History 
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUO=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups

function rmk(){
	scrub -p dod $1
	shred -zun 10 -v $1
}

# Crear carpetas para Hack
# function mkt(){
#     mkdir {nmap,content,exploits,scripts}
# }

# Funccion para listar y copiar puertos abiertos
# Extract nmap information
# function extractPorts(){
#     ports="$(cat $1 | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')"
#     ip_address="$(cat $1 | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)"
#     echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
#     echo -e "\t[*] IP Address: $ip_address"  >> extractPorts.tmp
#     echo -e "\t[*] Open ports: $ports\n"  >> extractPorts.tmp
#     echo $ports | tr -d '\n' | xclip -sel clip
#     echo -e "[*] Ports copied to clipboard\n"  >> extractPorts.tmp
#     cat extractPorts.tmp; rm extractPorts.tmp
# }

# Set Victim Target
# function settarget(){
#     ip_address=$1
#     machine_name=$2
#     echo "$ip_address $machine_name" > /home/hacker/.config/bin/target
# }

# Clear Victim Target
# function cleartarget(){
#     echo '' > /home/hacker/.config/bin/target
# }

# Colors Lsd
export LS_COLORS="rs=0:di=34:ln=36:mh=00:pi=33:so=35:bd=33;01:cd=33;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=32"

# Starship
eval "$(starship init zsh)"

# Fnm
eval "$(fnm env --use-on-cd --shell zsh)"

# Zoxide
eval "$(zoxide init zsh)"

# Apis-keys
export GEMINI_API_KEY="AIzaSyAhfOVtQQbZF5lj740n5V2eSnMqmEQqexw"
 
bindkey "^[[H" beginning-of-line
bindkey "^[[F" end-of-line
bindkey "^[[3~" delete-char
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
