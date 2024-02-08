source ./defaults.zsh

ln -s ~/git/dotfiles/macos/.zshrc ~/.zshrc
ln -s ~/git/dotfiles/macos/.zshenv ~/.zshenv
ln -s ~/git/dotfiles/macos/.zprofile ~/.zprofile
ln -s ~/git/dotfiles/macos/yabairc ~/.config/yabai/yabairc
ln -s ~/git/dotfiles/macos/skhdrc ~/.config/skhd/skhdrc

rm ~/Library/Application\ Support/Code/User/settings.json
ln -s ~/git/dotfiles/vscode/settings.json ~/Library/Application\ Support/Code/User/settings.json
rm ~/Library/Application\ Support/Code/User/keybindings.json
ln -s ~/git/dotfiles/vscode/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json


rm -r ~/.config/kitty
ln -s ~/git/dotfiles/kitty/ ~/.config/kitty

# Currently mapped all karabiner/ dir
ln -s ~/git/dotfiles/macos/karabiner.json ~/.config/karabiner/karabiner.json
