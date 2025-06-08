shopt -s expand_aliases

alias open='xdg-open'
alias lsf='ls | fzf'
alias readqr='zbarimg'
alias v.='nvim .'
alias chmod-exec='chmod -R ugo=r,a+X,ug+x'
alias htop='htop -d 10'
alias shutdown='shutdown -h now'
alias kernel-version='uname -r'
alias firstword=' head -n1 | cut -d " " -f1'
alias :q='exit'
alias cd!='cd_mkdir'
alias lstree='exa --long --tree --level=3 --icons'
# Configures "alert" alias for playing sound and sending notification after long running tasks
# Example:
#   sleep 10; alert
alias alert='spd-say "command executed" && notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
alias powerusage="awk '{print \$1*1e-6 \" W\"}' /sys/devices/platform/soc/2a2400000.smc/macsmc-power/power_supply/macsmc-battery/power_now"
alias edithistory="history -a && nvim ~/.bash_history"
alias init="/home/llaz/git/init/zig-out/bin/init -c /home/llaz/git/init/config"
alias lg="lazygit"
alias yy="wl-copy"
