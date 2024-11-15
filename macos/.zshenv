# Runs before .zshrctive and non-interactive shells.
# Aliases defined here are usable in nvim, where as values in .zshrc are not.
alias lg=lazygit
alias ls="ls -a"
alias q=exit
alias snooze=pmset sleepnow
# alias c.="code -r ." # Go away
alias v.="nvim . --listen /tmp/nvim-server-\$TMUX_PANE.pipe"
alias vim="nvim --listen /tmp/nvim-server-\$TMUX_PANE.pipe"
alias google-chrome='open -a "Google Chrome"'
alias chmod-exec='chmod -R ugo=rw,a+X,ug+x'
alias :q=exit
alias yy=pbcopy
alias pp=pbpaste
alias lsf='ls | fzf'
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias zhrc="vim ~/.zshrc && source ~/.zshrc" # Just because
alias hello="echo hi"
alias init="/Users/llaz/git/init/zig-out/bin/init -c '/Users/llaz/git/init/config/'"
alias swatch="/Users/llaz/git/swatch/zig-out/bin/zig-exe"
alias sw="/Users/llaz/git/swatch/zig-out/bin/zig-exe"
alias ldd="otool -L"

git config --global user.name "Laurynas Lazauskas"
git config --global user.email "8823448+lawrence-laz@users.noreply.github.com"
. "$HOME/.cargo/env"

