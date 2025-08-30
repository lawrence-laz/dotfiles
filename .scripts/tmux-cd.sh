#!/usr/bin/env bash

DIRS=(
    "$HOME/git"
    "$HOME"
)

# Doesn't support whitespaces in path :(
if [[ $# -eq 1 ]]; then
    selected=$1
else
    selected=$(( 
        find "${DIRS[@]}" -maxdepth 1 -type d; \
        find ~/git/playground -maxdepth 2
    ) \
    | uniq -u \
    | sed "s|^$HOME/||" \
    | fzf --margin 10% --color bw \
    | sed 's/ /\\ /g')

    [[ $selected ]] && selected="$HOME/$selected"
fi

if [[ -z $selected ]]; then
    exit 0
fi

selected_dirname=$(dirname "$selected")
selected_name_part1=$(basename "$selected_dirname")
selected_name_part2=$(basename "$selected")
selected_name_unsanitized="$selected_name_part1 > $selected_name_part2"
selected_name=$(basename "$selected_name_unsanitized" | tr . _ | tr ' ' ' ' | tr '\\' '_')
tmux_running=$(pgrep tmux)

echo $selected
echo $selected_name

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    echo "tmux new-session -s $selected_name -c $selected"
    tmux new-session -s "$selected_name" -c $selected
    exit 0
fi

if ! tmux has-session -t="$selected_name" 2> /dev/null; then
    echo "tmux new-session -ds $selected_name -c $selected"
    tmux new-session -ds "$selected_name" -c $selected
fi

tmux switch-client -t "$selected_name"

