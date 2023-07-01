#!/usr/bin/env bash

if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(find ~ -maxdepth 5 -path ~/gdrive -prune -type d -o -type f -name "*" | fzf)
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_name=$(basename "$selected" | tr . _ | tr ' ' _)
selected_directory=$(dirname "$selected")
tmux_running=$(pgrep tmux)
echo "selected name $selected_name"
if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "selected directory is: $selected_directory"
    # tmux new-session -s $selected_name "echo \"selected directory is: $selected_directory\" && tmux attach"
    # tmux new-session -s $selected_name -c $selected_directory "/usr/bin/bash nvim \"$selected\" && tmux attach"
    tmux new-session -s $selected_name -c $selected
    exit 0
fi

if ! tmux has-session -t=$selected_name 2> /dev/null; then
    echo "Selected directory is: $selected_directory"
    # tmux new-session -d -s $selected_name -c $selected_directory "/usr/bin/bash nvim \"$selected\" && tmux attach"
    tmux new-session -ds $selected_name -c $selected
fi

tmux send-keys -t $selected_name "cd \"$selected_directory\" && nvim \"$selected\"" C-m
tmux switch-client -t "$selected_name"

