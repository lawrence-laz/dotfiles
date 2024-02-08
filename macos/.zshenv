# Runs before .zshrc and in both interactive and non-interactive shells.
alias lg=lazygit
alias ls="ls -a"
alias q=exit
alias snooze=pmset sleepnow
alias c.="code -r ."
alias v.="nvim . --listen /tmp/nvim-server-\$TMUX_PANE.pipe"
alias vim="nvim --listen /tmp/nvim-server-\$TMUX_PANE.pipe"
alias google-chrome='open -a "Google Chrome"'
alias chmod-exec='chmod -R ugo=rw,a+X,ug+x'
alias :q=exit
alias yy=pbcopy
alias pp=pbpaste
alias lsf='ls | fzf'

git config --global user.name "Laurynas Lazauskas"
git config --global user.email "8823448+lawrence-laz@users.noreply.github.com"
. "$HOME/.cargo/env"

