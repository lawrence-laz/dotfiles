# Runs for interactive shell only (does not run inside vim for example).

# TODO: Install autojump
# TODO: Install harpoon equivalent
# TODO: alt + arrows in remote desktop
# TODO: alt+shift+arrows in remote desktop
# TODO: Add a function to convert .mov to .gif: ffmpeg -i in.mov -pix_fmt rgb8 -r 10 zig-test-runner.gif && gifsicle -O3 zig-test-runner.gif -o zig-test-runner.gif
# pbcopy / pbpaste	- 	Interact with clipboard via command line

PROMPT='%/ %# '

# Auto switch ruby bersion
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
chruby ruby-3.1.3

# Edit cmd line in vim using 'vv'
autoload -Uz edit-command-line
zle -N edit-command-line
bindkey -M vicmd 'vv' edit-command-line
# Vim mode
set -o vi

# Start tmux on load
#if [ "$TMUX" = "" ]; then exec tmux; fi

# Add brew installed packages to path
eval $(/opt/homebrew/bin/brew shellenv)

# Functions
up-directory() {
   builtin cd ..  && zle reset-prompt
}
zle -N up-directory

cdf() {
    if [[ -z "$1" ]]; then
        cd `find . -maxdepth 3 -type d 2>/dev/null | fzf`
    else
        cd `find . -maxdepth 3 -type d 2>/dev/null | fzf -q $1`
    fi
}

# Copy files from source to dest, where each is entered via fzf
cpf() {
	SOURCES=$(find / -maxdepth 5 2>/dev/null | fzf --multi) 
	TARGET=$((echo "."; find / -maxdepth 6 2>/dev/null) | uniq -u | fzf)
	while read -r line ; do
		echo "cp $line $TARGET"
		cp "$line" "$TARGET"
	done <<< "$SOURCES"
}

# Open current tmux pane in nvim for convenient copying
tmux2vim() {
	tmux capture-pane -pS - | awk NF | nvim '+ normal G$' -c ':set nonumber'
}

# Move files from source to dest, where each is entered via fzf
mvf() {
	SOURCES=$(find / -maxdepth 5 2>/dev/null | fzf --multi) 
	TARGET=$((echo "."; find / -maxdepth 5 2>/dev/null) | uniq -u | fzf)
	while read -r line ; do
		echo "mv $line $TARGET"
		mv "$line" "$TARGET"
	done <<< "$SOURCES"
}

# yes_or_no "Do you want to proceed?" && do_something
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
        esac
    done
}

# mvout - moves source directory contents to parent and destroys source directory
# mvout [SOURCE]
mvout() {

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


# Start skhd if not running
[[ $(ps aux | grep skhd) =~ "bin/skhd" ]] || skhd --start-service

# Key bindings
bindkey "\e[A" history-beginning-search-backward # Arrow up
bindkey "\e[B" history-beginning-search-forward  # Arrow down
bindkey "\e[1;3A" up-directory # Alt + up
# bindkey "\e[1;3D" cd -\n # ???

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS

# Aliases
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias zhrc="vim ~/.zshrc && source ~/.zshrc" # Just because
alias hello="echo hi"

source /Users/llaz/.config/broot/launcher/bash/br
