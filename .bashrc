#
# ~/.bashrc - Arch Linux + BlackArch Pentester Edition
#

# 1. Interactive check
[[ $- != *i* ]] && return

# 2. OPSEC & History Management
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=20000
export HISTFILESIZE=50000
export HISTFILE=/dev/shm/.bash_history
shopt -s histappend
PROMPT_COMMAND="history -a;$PROMPT_COMMAND"

alias exit="xclip -selection clipboard /dev/null 2>/dev/null; exit"

# 3. Target Tracking & Color Prompt
set-target() {
    export TARGET="$1"
    echo -e "\033[1;32m[+] Target locked: $TARGET\033[00m"
}

unset-target() {
    unset TARGET
    echo -e "\033[1;31m[-] Target cleared.\033[00m"
}

alias target='echo "Current Target: ${TARGET:-None Set}"'

PS1='${TARGET:+\[\033[1;31m\][T:$TARGET] }\[\033[1;32m\]\u@\h\[\033[00m\]:\[\033[1;34m\]\w\[\033[00m\]\n\$ '

# 4. Aliases & Defaults
alias ls='ls --color=auto --group-directories-first'
alias ll='ls -la'
alias la='ls -A'
alias grep='grep --color=auto'

alias c='clear'
alias h='history'
alias ports='sudo ss -tulpn || sudo netstat -tulpn'
alias df='df -h'
alias du='du -h -d 1'
alias free='free -h'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# 5. Arch & BlackArch Shortcuts
alias pacup='sudo pacman -Syu'
alias pacin='sudo pacman -S'
alias pacrem='sudo pacman -Rns'
alias pacsearch='pacman -Ss'
alias pacinfo='pacman -Si'
alias pacfiles='pacman -Ql'
alias pacclean='sudo pacman -Sc'

alias ba-categories='pacman -Sg | grep blackarch'
alias ba-search='pacman -Ss blackarch'

function ba-category {
    if [ -z "$1" ]; then
        echo "Usage: ba-category <category-name> (e.g., blackarch-web, blackarch-recon)"
        return 1
    fi
    pacman -Sg "$1"
}

# 6. Helper Functions
function myip {
    local ip
    ip=$(curl -sS --max-time 5 ifconfig.me)
    if [ -n "$ip" ]; then
        echo -e "\033[1;32m[*] Public IP:\033[0m $ip"
    else
        echo -e "\033[1;31m[-] Unable to fetch public IP.\033[0m"
    fi
}

function mkcd {
    mkdir -p "$1" && cd "$1" || return
}

function mksrv {
    local port="${1:-8000}"
    echo -e "\033[1;34m[*] Hosting $(pwd) on port $port...\033[00m"
    python3 -m http.server "$port"
}

function mkengagement {
    if [ -z "$1" ]; then
        echo "Usage: mkengagement <target_name>"
        return 1
    fi
    mkdir -p "$1"/{scans,loot,exploits,proofs}
    cd "$1" || return
    echo -e "\033[1;32m[+] Created engagement directory structure in: $(pwd)\033[00m"
}

function extract {
    if [ -f "$1" ]; then
        case "$1" in
            *.tar.bz2)   tar xjf "$1"     ;;
            *.tar.gz)    tar xzf "$1"     ;;
            *.bz2)       bunzip2 "$1"     ;;
            *.rar)       unrar x "$1"     ;;
            *.gz)        gunzip "$1"      ;;
            *.tar)       tar xvf "$1"     ;;
            *.tbz2)      tar xjf "$1"     ;;
            *.tgz)       tar xzf "$1"     ;;
            *.zip)       unzip "$1"       ;;
            *.7z)        7z x "$1"        ;;
            *)           echo "'$1' cannot be extracted via function extract" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# 7. Help Menu
pentest-help() {
    cat << 'EOF'

================================================================================
                    PENTEST & SYSTEM COMMAND CHEATSHEET                         
================================================================================

[ TARGET TRACKING ]
  set-target <IP>      Set active target (e.g., set-target 10.10.11.100)
  unset-target         Clear active target from prompt
  target               Print current target IP

[ RECON & WORKFLOW ]
  mkengagement <dir>   Create engagement folder tree (scans, loot, exploits, proofs)
  mksrv [port]         Host current directory over HTTP (default port: 8000)
  myip                 Safely fetch current public IP address
  ports                List listening local ports and associated PIDs

[ NAVIGATION & FILES ]
  mkcd <dir>           Create directory and cd into it immediately
  extract <file>       Smart extractor for tar, gz, zip, 7z, rar, bz2
  .. / ... / ....      Navigate 1, 2, or 3 directories up
  c / h                Clear terminal / View history

[ PACMAN & BLACKARCH SHORTCUTS ]
  pacup                Full system upgrade (pacman -Syu)
  pacin <pkg>          Install package (pacman -S)
  pacrem <pkg>         Remove package + dependencies (pacman -Rns)
  pacsearch <query>    Search default Arch repos (pacman -Ss)
  pacinfo <pkg>        View detailed package info (pacman -Si)
  pacfiles <pkg>       List files installed by package (pacman -Ql)
  pacclean             Clean uninstalled pacman cache (pacman -Sc)

  ba-search <query>    Search BlackArch repository specifically
  ba-categories        List all BlackArch categories
  ba-category <cat>    List tools inside a specific BlackArch category

[ BASH HISTORY TRICKS (OPSEC) ]
  <space>command       Run command WITHOUT saving it to history
  !$                   Reuse last argument of the previous command
  !!                   Repeat the entire previous command
  !n                   Re-run line 'n' from command history
  CTRL + R             Reverse history search (type to find past commands)
  CTRL + G             Exit reverse search mode

[ BASH SHORTCUTS & LINE EDITING ]
  CTRL + A / CTRL + E  Move cursor to beginning / end of line
  CTRL + U             Cut line from cursor back to start
  CTRL + K             Cut line from cursor forward to end
  CTRL + W             Cut word immediately behind cursor
  CTRL + Y             Paste (yank) last cut text
  CTRL + L             Clear terminal screen (leaves current command intact)

[ JOB & PROCESS CONTROL ]
  CTRL + C             Kill current foreground process
  CTRL + Z             Suspend current process (send to background)
  bg                   Resume suspended process in background
  fg                   Bring background process back to foreground
  jobs                 List all active background/suspended jobs

================================================================================
EOF
}
