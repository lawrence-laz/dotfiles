#!/usr/bin/env bash
# Doesn't support whitespaces in path :(
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(( 
        echo "$HOME/notes"; \
        find ~/git -maxdepth 4 -type d -o -type d -name "*" ; \
        find ~ -maxdepth 5 -path ~/gdrive -prune -path ~/git -prune -type d -o -type d -name "*"
    ) | uniq -u | fzf | sed 's/ /\\ /g'    )
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _ | tr ' ' '_' | tr '\\' '_')
tmux_running=$(pgrep tmux)

echo $selected
echo $selected_name

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "tmux new-session -s $selected_name -c $selected"
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "tmux new-session -ds $selected_name -c $selected"
    tmux new-session -ds $selected_name -c $selected
fi

tmux switch-client -t $selected_name

