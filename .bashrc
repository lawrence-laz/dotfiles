############
# Commands #
############
# `nmcli dev wifi`            Show available wifi
# `nmcli`                     Show all network stuff (including vpn)
# `bc`                        Basic Calculator
# `lsof -p 8080`              Show process using this port
# `pgrep chromium`            Get pids by name
# `locate *.desktop`          Search all files with given pattern from index
# `sudo updatedb`             Update search index
# `rg <phrase> <path>`        Search for phrase in file contents
# `entr`                      Run command when fiven files have changes (see man entr for examples)
# `df -h`                     Show mounted file systems and their info
# `pavucontrol`               Pulse audio settings
# `coredumpctl list`          List core dumps
# `lscpu --all --extended`    List CPU and cores
# `man ascii`                 Print ascii table
#
# `xdg-mime default app.desktop application/x-web-browser`                              Set default program to open files with
# `tldr xdg-mime`                                                                       More examples
# `cat file | openssl dgst -sha256 -binary | base64 | xargs -I {} echo "sha256-{}"`     File hash
# `pgrep chromium | xargs -I {} taskset --pid --cpu-list 8-11 {}`                       Run chromium on efficiency cores only
#
#
#################
# Paths         #
#################
# /usr/share/applications/          Program .desktop files to be used for xdg-open and xdg-mime
# ~/.local/share/applications/
#
#
#
###################
# Install font    #
###################
# mkdir -p ~/.local/share/fonts/mulish
# cp ~/Downloads/robofont.ttf ~/.local/share/fonts/robofont
# fc-cache -v
# fc-list
#
###################
# Setting up swap #
###################
# `dd if=/dev/zero of=/media/fasthdd/swapfile.img bs=1024 count=1M`
# `mkswap /media/fasthdd/swapfile.img`
# `/media/fasthdd/swapfile.img swap swap sw 0 0` <- Add this line to /etc/fstab
# `swapon /media/fasthdd/swapfile.img`
#
##########
# FFMPEG #
##########
# `ffmpeg -ss <start_seconds> -t <duration_seconds> -i "input.mp3" -c:a copy "output.mp3"`    Slice media file
# `ffmpeg -i input.flac -ab 320k -map_metadata 0 -id3v2_version 3 output.mp3`                 Convert .flac to .mp3
# `ffmpeg -i input.flv -vcodec libx264 -acodec aac output.mp4`				      Convert to protable .mp4
# `ffmpeg -framerate 1 -i portrait\ \(3\).jpg -c:v libx264 -r 30 -pix_fmt yuv420p output.mp4` Convert .jpg to .mp4
#
#######
# SSH #
#######
# ssh-keygen -t rsa
# cat ~/.ssh/id_rsa.pub | ssh user@123.45.56.78 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
# ssh-add
#
######################
# Keyboard shortcuts #
######################
# <C-r> History lookup by dvorka/hstr

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH
export PATH="/home/llaz/zig/sdk:$PATH"

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

if [ -f ~/.bashrc2 ]; then
    . ~/.bashrc2
fi

# Get the aliases
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

unset PROMPT_COMMAND

swaymsg output "*" bg "#000000" solid_color # Set background to all black.

echo "> write > notes > dry"
echo "---------------------"

# Include dotfiles in commands like `mv`
shopt -s dotglob

# Make sure ssh agent is running
if ! pgrep -x "ssh-agent" >/dev/null; then
    eval "$(ssh-agent)" >/dev/null
fi

function restartbluetooth() {
    rfkill block bluetooth
    rfkill unblock bluetooth
    systemctl stop bluetooth.service
    systemctl start bluetooth.service
}

function cdf() {
    if [[ -z "$1" ]]; then
        cd $(find . -maxdepth 3 -type d 2>/dev/null | fzf)
    else
        cd $(find . -maxdepth 3 -type d 2>/dev/null | fzf -q $1)
    fi
}

# mvout - moves source directory contents to parent and destroys source directory
# mvout [SOURCE]
function mvout() {

    if [[ -z "$1" ]]; then
        SOURCE=$(pwd)
        cd ..
    else
        SOURCE=$1
    fi

    if [ ! -d "$SOURCE" ]; then
        echo 'Given path does not exist'
        return 1
    fi

    cp -r "$SOURCE"/* "$SOURCE"/..
    if [ $? -eq 0 ]; then
        rm -rf "$SOURCE"
    else
        echo 'Unable to copy out contents from source directory'
    fi
}

# cd! - changes directory and creates missing intermediate directories any
# cd! PATH
function cd_mkdir() {

    if [[ -z "$1" ]]; then
        echo 'Missing PATH argument'
        return 1
    else
        DEST=$1
    fi

    mkdir -p "$DEST"
    cd "$DEST"
}

# sizeof - prints file size in easy to understand format
# sizeof FILE_PATH
function sizeof() {
    if [[ -z "$1" ]]; then
        echo 'Missing FILE_PATH argument'
        return 1
    else
        FILE_PATH=$1
    fi

    stat -c %s "$FILE_PATH" | numfmt --to=iec
}

function findf() {

    if [[ -z "$1" ]]; then
        selected=$(find ~ -maxdepth 10 -path ~/gdrive -prune -type d -o -type f -name "*" | fzf)
    else
        selected=$(find $1 -maxdepth 10 -path ~/gdrive -prune -type d -o -type f -name "*" | fzf)
    fi

    if [[ -z $selected ]]; then
        return
    fi

    echo $selected
}

# Debouncing same command in short interval of time?
function debounce() {
    if [[ ! -f ./executing ]]; then
        touch ./executing
        eval "$@"
        result=$?
        (sleep 2s && rm -f ./executing &)
        return $result
    fi
}
export -f debounce

function silent_background() {
    { 2>&3 "$@" & } 3>&2 2>-
    disown &>/dev/null
}

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# # Run tmux on start
# function run_tmux_on_start() {
#
#     if [[ "$TERM_PROGRAM" == "vscode" ]]; then
#         return
#     fi
#
#     if command -v tmux &>/dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
#         tmux attach || exec tmux new-session
#     fi
# }
# run_tmux_on_start

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto -a'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# Count lines of code for a given git repo url
function cloc-git() {
    git clone --depth 1 "$1" temp-linecount-repo &&
        printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" &&
        cloc temp-linecount-repo &&
        rm -rf temp-linecount-repo
}

export DOTNET_CLI_TELEMETRY_OPTOU=true # Disable dotnet cli Microsoft telemetry.
export EDITOR="nvim"
export SUDO_EDITOR="nvim"

# Autocomplete for dotnet
function _dotnet_bash_complete() {
    local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n'
    local candidates

    read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

    read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

complete -f -F _dotnet_bash_complete dotnet

######################
# HSTR configuration #
######################
export HSTR_CONFIG=hicolor      # Get more colors.
shopt -s histappend             # Append new history items to .bash_history, do not overwrite.
export HISTCONTROL=ignoreboth   # Leading space hides commands from history and duplicates are removed.
export HISTFILESIZE=-1          # Unlimited history file size.
export HISTSIZE=${HISTFILESIZE} #
# Ensure synchronization between bash memory and history file.
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
function hstrnotiocsti {
    { READLINE_LINE="$({ </dev/tty hstr ${READLINE_LINE}; } 2>&1 1>&3 3>&-)"; } 3>&1
    READLINE_POINT=${#READLINE_LINE}
}
# If this is interactive shell, then bind hstr to <C-r> (for Vi mode check docs)
if [[ $- =~ .*i.* ]]; then bind -x '"\C-r": "hstrnotiocsti"'; fi
export HSTR_TIOCSTI=n

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
