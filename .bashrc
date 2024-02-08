# TODO: stuff to add to provision scripts:
# dotnet tool install -g dotnet-script
# sudo gpasswd -a <user_name> video <- for controlling brightness without sudo?
#  /usr/lib/udev/rules.d/90-brightnessctl.rules

# DRI3 is required by some apps (ex. google-chrome)
# To check which DRI is in use, run:
# xdpyinfo | grep DRI
# To change run:
# sudoedit /etc/X11/xorg.conf.d/20-intel.conf
# and add:
# Option      "DRI"      "3"

# =====================
# Commands
# =====================
# `nmcli dev wifi`        Show available wifi
# `nmcli`                 Show all network stuff (including vpn)
# `br`                    File navigation tree by Canop/broot
# `bc`			  Basic Calculator
# `lsof -p 8080`          Show process using this port
# `locate *.desktop`      Search all files with given pattern from index
# `sudo updatedb`         Update search index
# `rg <phrase> <path>`    Search for phrase in file contents
# `entr`                  Run command when fiven files have changes (see man entr for examples)
# `df -h`                 Show mounted file systems and their info
# `dd if=/dev/zero of=/media/fasthdd/swapfile.img bs=1024 count=1M`     Create swap file
# `mkswap /media/fasthdd/swapfile.img`
# Add this line to /etc/fstab
# /media/fasthdd/swapfile.img swap swap sw 0 0
# swapon /media/fasthdd/swapfile.img
# `pavucontrol`           Pulse audio settings
# `ffmpeg -ss <start_seconds> -t <duration_seconds> -i "input.mp3" -c:a copy "output.mp3"`    Slice media file
# `ffmpeg -i input.flac -ab 320k -map_metadata 0 -id3v2_version 3 output.mp3`                 Convert .flac to .mp3
# `ffmpeg -i input.flv -vcodec libx264 -acodec aac output.mp4`				      Convert to protable .mp4
# `ffmpeg -framerate 1 -i portrait\ \(3\).jpg -c:v libx264 -r 30 -pix_fmt yuv420p output.mp4` Convert .jpg to .mp4
#
#
# SSH:
# ssh-keygen -t rsa
# cat ~/.ssh/id_rsa.pub | ssh user@123.45.56.78 "mkdir -p ~/.ssh && cat >>  ~/.ssh/authorized_keys"
# ssh-add
#
# :sort u 		Unique/distinct lines

# =====================
# Keyboard shortcuts
# =====================
# <C-r> History lookup by dvorka/hstr


# Append to lbrary path for libdl.so
# LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/snap/gnome-3-38-2004/119/usr/lib/x86_64-linux-gnul"

# Path variable configured in:
# ~/.bash_profile

# =====================
# Packages
# =====================
# go install github.com/open-pomodoro/openpomodoro-cli/cmd/pomodoro@latest

# Enable dotnet sdk location trace
# export COREHOST_TRACE=1

unset PROMPT_COMMAND

echo "------------------------"
echo "'pomodoro start' to start a work session"
echo "'notes' to open your notes"
echo "------------------------"

# Load tool specific configuration
for f in ~/git/dotfiles/**/config.sh; do 
    ls $f
    source $f
done



# Include dotfiles in commands like `mv`
shopt -s dotglob

# source ~/.screenlayout/laptop.sh

if ! pgrep -x "ssh-agent" > /dev/null
then
    eval "$(ssh-agent)" > /dev/null
    ssh-add -q ~/.ssh/github_key_old
fi

# setxkbmap -layout us,lt -model pc104 -option 'grp:win_space_toggle'

# Personal aliases
alias deepsleep='sudo systemctl hibernate'
alias loadssh='eval "$(ssh-agent)" > /dev/null && ssh-add -q ~/.ssh/github_key_old'
alias sudo='sudo -E -s'
alias open='xdg-open'
alias lg='loadssh && lazygit'
alias lsf='ls | fzf'
alias lazygitconf='vim /home/llaz/.config/jesseduffield/lazygit/config.yml'
alias qr='zbarimg'
alias vim='nvim --listen ~/tmp/nvim-server.pipe'
alias bim='nvim --listen ~/tmp/nvim-server.pipe' # eh, I do this often enough to justify this alias
alias v.='nvim --listen ~/tmp/nvim-server.pipe .' # eh, I do this often enough to justify this alias
alias vim.='nvim --listen ~/tmp/nvim-server.pipe .' # eh, I do this often enough to justify this alias
alias vim,.='nvim --listen ~/tmp/nvim-server.pipe .' # eh, I do this often enough to justify this alias
alias vim.,='nvim --listen ~/tmp/nvim-server.pipe .' # eh, I do this often enough to justify this alias
alias vim,='nvim --listen ~/tmp/nvim-server.pipe .' # eh, I do this often enough to justify this alias
alias bell='paplay ~/.config/bell.wav'
alias sneeze='paplay ~/.config/sneeze.wav'
alias inspire='mpg123 `ls -dA ~/inspire/* | shuf -n 1`'
alias vimrc='vim ~/git/dotfiles/nvim/'
alias vimconf='vim ~/.config/nvim'
alias vimf='vim `findf'
alias vimplug='vim ~/.config/nvim/lua/plugins.lua'
alias bashrc='vim ~/.bashrc && source ~/.bashrc'
alias bash_profile='vim ~/.bash_profile && source ~/.bash_profile'
alias inputrc='vim ~/.inputrc'
alias i3conf='cd ~/.config && vim ~/.config/i3/config && cd -'
alias i3save='i3-save-tree --workspace 1 > ~/.i3/workspace-1.json'
alias tmuxconf='vim ~/.tmux.conf'
alias kittyconf='vim ~/.config/kitty/kitty.conf && killall -s SIGUSR1 kitty'
alias kittyreload='killall -s SIGUSR1 kitty'
alias picomconf='vim ~/.config/picom.conf'
alias chmod-exec='chmod -R ugo=r,a+X,ug+x'
alias todo='vim ~/notes/todo.md'
alias notes='vim ~/notes/root.md'
alias htop='htop -d 1'
alias shutdown='shutdown -h now'
alias ubuntu-version='lsb_release -a && cat /etc/regolith/version'
alias kernel-version='uname -r'
alias historyfzf='history -w /dev/stdout | sort --unique | fzf'
alias where='type -a'
alias snooze='systemctl suspend'
alias firstword=' head -n1 | cut -d " " -f1'
alias :q='exit'
alias kpass='keepassxc-cli'
alias ff='broot'
alias cd!='cd_mkdir'
alias journal='vim ~/notes/journal.md'
alias dnbradio='mplayer -playlist https://dnbradio.com/hi.pls'
alias pomo='pomodoro'
alias cs='csharprepl'
#tlp = power battery manager

function say2() {
    if [[ -z "$1" ]]; then
        :
    else
        tts --text "$1" --out_path /tmp/speech.wav && paplay /tmp/speech.wav
    fi
}

function sakyk() {
    if [[ -z "$1" ]]; then
        :
    else
        tts --text "$1" --model_name "tts_models/lt/cv/vits" --out_path /tmp/speech.wav && paplay /tmp/speech.wav
    fi
}

function restartbluetooth() {
    rfkill block bluetooth
    rfkill unblock bluetooth
    systemctl stop bluetooth.service
    systemctl start bluetooth.service
}

export MGFXC_WINE_PATH=/home/llaz/.winemonogame

# Keypress repeat delay in ms and repeat rate in hz
xset r rate 200 30

alias findfcd='cd `findf | xargs dirname`'

function cdf() {
    if [[ -z "$1" ]]; then
        cd `find . -maxdepth 3 -type d 2>/dev/null | fzf`
    else
        cd `find . -maxdepth 3 -type d 2>/dev/null | fzf -q $1`
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
function debounce () {
	if [[ ! -f ./executing ]]
       	then
		touch ./executing
		eval "$@"
		result=$?
		(sleep 2s && rm -f ./executing &)
		return $result
	fi
}
export -f debounce

function silent_background () {
	{ 2>&3 "$@"& } 3>&2 2>-
	disown &>/dev/null
}

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# Run tmux on start
function run_tmux_on_start () {

	if [[ "$TERM_PROGRAM" == "vscode" ]]; then
		return
	fi

	if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
		tmux attach || exec tmux new-session
	fi
}
run_tmux_on_start

# Don't put duplicate lines or lines starting with space in the history.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=-1
HISTFILESIZE=-1

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # alias ls='ls --color=auto -a'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias ls='ls -a'
alias l='ls -CF'
alias lstree='exa --long --tree --level=3 --icons'

# Configures "alert" alias for playing sound and sending notification after long running tasks
# Example:
#   sleep 10; alert
alias alert='spd-say "command executed" && notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# TODO: Remove?
# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Count lines of code for a given git repo url
function cloc-git() {
  git clone --depth 1 "$1" temp-linecount-repo &&
  printf "('temp-linecount-repo' will be deleted automatically)\n\n\n" &&
  cloc temp-linecount-repo &&
  rm -rf temp-linecount-repo
}

# Disable dotnet cli Microsoft telemetry
export DOTNET_CLI_TELEMETRY_OPTOU=true 

# Configures `hstr` - a bash history searcher
# https://github.com/dvorka/hstr
alias hh=hstr                    # hh to be alias for hstr
export HSTR_CONFIG=hicolor       # get more colors
shopt -s histappend              # append new history items to .bash_history
export HISTCONTROL=ignorespace   # leading space hides commands from history
export HISTFILESIZE=10000        # increase history file size (default is 500)
export HISTSIZE=${HISTFILESIZE}  # increase history size (default is 500)
# ensure synchronization between bash memory and history file
export PROMPT_COMMAND="history -a; history -n; ${PROMPT_COMMAND}"
export EDITOR="nvim --server ~/tmp/nvim-server.pipe"
export SUDO_EDITOR="nvim"
# if this is interactive shell, then bind hstr to Ctrl-r (for Vi mode check doc)
if [[ $- =~ .*i.* ]]; then bind '"\C-r": "\C-a hstr -- \C-j"'; fi
# if this is interactive shell, then bind 'kill last command' to Ctrl-x k
if [[ $- =~ .*i.* ]]; then bind '"\C-xk": "\C-a hstr -k \C-j"'; fi

# Configures `br` - a file tree explorer
# https://github.com/Canop/broot
source /home/llaz/.config/broot/launcher/bash/br
. "$HOME/.cargo/env"

# Autocomplete for dotnet
function _dotnet_bash_complete()
{
  local cur="${COMP_WORDS[COMP_CWORD]}" IFS=$'\n'
  local candidates

  read -d '' -ra candidates < <(dotnet complete --position "${COMP_POINT}" "${COMP_LINE}" 2>/dev/null)

  read -d '' -ra COMPREPLY < <(compgen -W "${candidates[*]:-}" -- "$cur")
}

complete -f -F _dotnet_bash_complete dotnet
