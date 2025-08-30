# Runs for interactive shell only (does not run inside vim for example).

# TODO: Install autojump
# TODO: alt + arrows in remote desktop
# TODO: alt+shift+arrows in remote desktop
# TODO: Add a function to convert .mov to .gif: ffmpeg -i in.mov -pix_fmt rgb8 -r 10 zig-test-runner.gif && gifsicle -O3 zig-test-runner.gif -o zig-test-runner.gif
#
# Video from Google Photos: 
# 'constant bitrate'
# ffmpeg -i input.mov -c:v libx264 -b:v 10M -c:a aac -b:a 128k output.mov
# 'constant quality'
# ffmpeg -i input.mov -c:v libx264 -crf 20 -c:a aac -b:a 128k output.mov
# For multi files
# for i in *.avi; do ffmpeg -i "$i" "${i%.*}.mp4"; done
# for i in *.MOV; do ffmpeg -i "$i" -c:v libx264 -b:v 10M -c:a aac -b:a 128k "${i%.*}.out.mov"; done
# For Apple hardware acceleration:
# -c:v h264_videotoolbox
#
# pbcopy / pbpaste	- 	Interact with clipboard via command line
# qrencode -t ANSI -o - "here goes data"    - generate qr from string literal
# qrencode -o "out.png" < "somefile.txt"    - generate qr from file
# zbarimg "someimg.png"                     - scan qr code
# jq                                        - https://www.youtube.com/watch?v=n8sOmEe2SDg
# GIT ===================================================================================
# git describe --contains <commit>          - See what tag contains this commit
# git tag --contains <commit>               - See all tags that contain this commit
# git log -i -G"something"                  - Search commits that include "something" in their diff
# git log -i -S"something"                  - Search commits that added or removed "something" in their diff
# git diff -i -G"something"                 - See if current changes include a give string
# git diff HEAD~2 -i -G"something"              - See if 2 commits back contain changes including "something"
# pgrep "procname"                          - Get PID by name
# pkill -9 "procname"                       - Kill by name
# kill -9 PID                               - Kill by PID
# ps -p PID                                 - Get proc by PID
# otool -L <file>                           - Check what the file is linked against
# otool -l <file>                           - Check RPATH for linking frameworks in /Library/Frameworks
# df -lh .                                  - Check available space in current folder
# uname -m                                  - Get CPU arch
# wc -l *.zig                               - word count lines files pattern
# du -sh dir                                - see dir size
# find . -type f -perm +111                 - Find executables
#
# TODO: Set up git helper commands to check if:
#       current commit contains any string (case insensitive), either is changed code, or commit description, or changed files
#       show what changed
#       git diff -G
#
#
#       this can be used for git bisect, to auto git bisect skip commit that did not include a string, so are unlikely to have changed
#
#       maybe this could be a zig program?
#
#

PROMPT='%/ %# '

# Auto switch ruby bersion
source /opt/homebrew/opt/chruby/share/chruby/auto.sh
source /opt/homebrew/opt/chruby/share/chruby/chruby.sh
chruby ruby-3.1.3

# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

# Vim mode
set -o vi

# Start tmux on load
#if [ "$TMUX" = "" ]; then exec tmux; fi

# Add brew installed packages to path
eval $(/opt/homebrew/bin/brew shellenv)


cdf() {
    if [[ -z "$1" ]]; then
        cd `find . -maxdepth 3 -type d 2>/dev/null | fzf`
    else
        cd `find . -maxdepth 3 -type d 2>/dev/null | fzf -q $1`
    fi
}

# Copy files from source to dest, where each is entered via fzf
cpf() {
	SOURCES=$(find / -maxdepth 5 2>/dev/null | fzf --multi) 
	TARGET=$((echo "."; find / -maxdepth 6 2>/dev/null) | uniq -u | fzf)
	while read -r line ; do
		echo "cp $line $TARGET"
		cp "$line" "$TARGET"
	done <<< "$SOURCES"
}

# Open current tmux pane in nvim for convenient copying
# tmux2vim() {
# 	tmux capture-pane -pS - | awk NF | nvim '+ normal G$' -c ':set nonumber'
# }

# Move files from source to dest, where each is entered via fzf
mvf() {
	SOURCES=$(find / -maxdepth 5 2>/dev/null | fzf --multi) 
	TARGET=$((echo "."; find / -maxdepth 5 2>/dev/null) | uniq -u | fzf)
	while read -r line ; do
		echo "mv $line $TARGET"
		mv "$line" "$TARGET"
	done <<< "$SOURCES"
}

# yes_or_no "Do you want to proceed?" && do_something
function yes_or_no {
    while true; do
        read -p "$* [y/n]: " yn
        case $yn in
            [Yy]*) return 0 ;;
            [Nn]*) return 1 ;;
        esac
    done
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
# [[ $(ps aux | grep skhd) =~ "bin/skhd" ]] || skhd --start-service

# Key bindings
bindkey "\e[A" history-beginning-search-backward # Arrow up
bindkey "\e[B" history-beginning-search-forward  # Arrow down
# bindkey "\e[1;3D" cd -\n # ???

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000000
SAVEHIST=100000000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE

# Aliases in ./zshenv

source /Users/llaz/.config/broot/launcher/bash/br
