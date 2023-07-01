#!/usr/bin/env bash
tmux_running=$(pgrep tmux)

if [[ -z $TMUX ]] && [[ -z $tmux_running ]]; then
    tmux new-session -s Music
    exit 0
fi

if ! tmux has-session -t=Music 2> /dev/null; then
    tmux new-session -ds Music
    tmux switch-client -t Music
    tmux send-keys -t Music "ncspot" C-m
else
    tmux switch-client -t Music
fi

