# Runs for interactive shell only (does not run inside vim for example).

# TODO: Install autojump
# TODO: Install harpoon equivalent
# TODO: alt + arrows in remote desktop
# TODO: alt+shift+arrows in remote desktop
# TODO: Add a function to convert .mov to .gif: ffmpeg -i in.mov -pix_fmt rgb8 -r 10 zig-test-runner.gif && gifsicle -O3 zig-test-runner.gif -o zig-test-runner.gif
# pbcopy / pbpaste	- 	Interact with clipboard via command line

PROMPT='%/ %# '

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
