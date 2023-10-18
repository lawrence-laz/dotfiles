if [[ $(uname -s) =~ "Darwin" ]]; then
	# MacOS
	echo "macos"
	mkdir -p ~/Library/Application\ Support/lazygit/
	ln -s ~/git/dotfiles/lazygit/config.yml ~/Library/Application\ Support/lazygit/config.yml
else
	# Linux
	echo "linux"
	mkdir -p ~/.config/jesseduffield/lazygit/
	ln -s ~/git/dotfiles/lazygit/config.yml ~/.config/jesseduffield/lazygit/config.yml
fi

