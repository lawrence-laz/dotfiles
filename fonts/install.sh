sudo mkdir -p /usr/local/share/fonts/firacode
sudo cp ~/git/dotfiles/fonts/firacode/*.ttf /usr/local/share/fonts/firacode/
sudo chown -R root: /usr/local/share/fonts/firacode
sudo chmod 644 /usr/local/share/fonts/firacode/*
sudo restorecon -vFr /usr/local/share/fonts/firacode
sudo fc-cache -v

