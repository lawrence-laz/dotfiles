PROMPT='%/ %# '

# Start tmux on load
if [ "$TMUX" = "" ]; then exec tmux; fi

# Functions
up-directory() {
   builtin cd ..  && zle reset-prompt
}
zle -N up-directory

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
