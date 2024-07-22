if status is-interactive
    # Commands to run in interactive sessions can go here
end

function fish_greeting
  # No mostrar mensaje de bienvenida
end

function rmk
    if test -f "$1"
        set confirm (fish_prompt --yesno "Eliminar '$1'? (y/N)")
        if test "$confirm" = "y"
            # Eliminación segura con rm -rf
            rm -rf "$1"
            echo "Eliminado '$1' correctamente"
        else
            echo "Eliminación cancelada."
        end
    else
        echo "El archivo '$1' no existe."
    end
end

function mkt
    # Crea directorios con mkdir -p
    mkdir -p {nmap,content,exploits,scripts}
end

# Exportar LS_COLORS para lsd
set -x LS_COLORS "rs=0:di=34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

# if status is-interactive
#     and not set -q TMUX
#     exec tmux
# end

# Comment if you want to use Tmux
#if set -q ZELLIJ
#else
#    zellij
#end


#Alias lsd
alias cat='bat --style=plain'
alias catn='bat'
alias catnp='bat --style=plain --paging=never'
alias ll='lsd -lh --group-dirs=first'
alias la='lsd -a --group-dirs=first'
alias l='lsd --group-dirs=first'
alias lla='lsd -lha --group-dirs=first'
alias ls='lsd --group-dirs=first'

# Vim and VsCode
alias vim='nvim'
alias code='code'

# Git
alias gcl='git clone --depth 1'
alias gi='git init'
alias ga='git add'
alias gc='git commit -m'
alias gp='git push origin main'
alias gst='git status'

# Web-Search
alias ws='web-search'

# Sail
alias sail='./vendor/bin/sail'

# Created dir 
alias mkd='mkdir'

# Ver-Imgenes
alias ish='kitty +kitten icat'

# Load the fzf key bindings file
source ~/.config/fish/functions/fzf_key_bindings.fish

function extractPorts
    set ports (cat $argv[1] | grep -oP '\d{1,5}/open' | awk '{print $1}' FS='/' | xargs | tr ' ' ',')
    set ip_address (cat $argv[1] | grep -oP '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}' | sort -u | head -n 1)
    echo -e "\n[*] Extracting information...\n" > extractPorts.tmp
    echo -e "\t[*] IP Address: $ip_address" >> extractPorts.tmp
    echo -e "\t[*] Open ports: $ports\n" >> extractPorts.tmp
    echo $ports | tr -d '\n' | xclip -sel clip
    echo -e "[*] Ports copied to clipboard\n" >> extractPorts.tmp
    cat extractPorts.tmp; rm extractPorts.tmp
end

starship init fish | source
set -gx VOLTA_HOME "$HOME/.volta"
set -gx PATH "$VOLTA_HOME/bin" $PATH
set -gx fish_config theme save "Catppuccin Mocha"

# bun
set --export BUN_INSTALL "$HOME/.local/share/reflex/bun"
set --export PATH $BUN_INSTALL/bin $PATH
