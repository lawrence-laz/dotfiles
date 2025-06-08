# Packages
sudo dnf install sway-config-fedora -q # Preconfigured Sway (i3 alternative for Waylad)
sudo dnf install chromium -q
sudo dnf install tldr -q     # Short manuals/examples
sudo dnf install powertop -q # Power analyzer
sudo dnf install tlp -q      # Power manager

sudo dnf install git -q
sudo dnf install neovim -q
sudo dnf install ripgrep -q
sudo dnf install fd-find

sudo dnf install tlp tlp-rdw
systemctl enable tlp.service
systemctl mask systemd-rfkill.service systemd-rfkill.socket

sudo dnf install smartmontools

sudo dnf install wg-tools # Wire gurad VPN
sudo dnf install remmina  # Remote desktop protocol

sudo dnf install dotnet-sdk-9.0

sudo dnf install gifsicle
sudo dnf install wf-recorder
sudo dnf install tmux
sudo dnf install entr # A utility for running arbitrary commands when files change
sudo dnf install hstr # Command history search
sudo dnf install zbar # Read QR code
sudo dnf install fzf  # Fuzzy search utility
sudo dnf install git-delta
sudo dnf install lldb

sudo dnf install pandoc                   # HTML to PDF ect.
sudo dnf install git-credential-libsecret # git config --global credential.helper /usr/libexec/git-core/git-credential-libsecret
sudo dnf install openssl

sudo dnf install pavucontrol # Audio control
