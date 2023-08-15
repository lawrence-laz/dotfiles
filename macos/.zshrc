# TODO: Install autojump
# TODO: Install harpoon equivalent
# TODO: alt + arrows in remote desktop
# TODO: alt+shift+arrows in remote desktop

PROMPT='%/ %# '

# Start tmux on load
#if [ "$TMUX" = "" ]; then exec tmux; fi

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
alias lg=lazygit
alias ls="ls -a"
alias q=exit
alias snooze=pmset sleepnow
alias c.="code -r ."
alias v.="nvim ."

source /Users/llaz/.config/broot/launcher/bash/br
