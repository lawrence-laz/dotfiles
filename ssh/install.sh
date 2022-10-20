ln -sf $PWD/config ~/.ssh/config

systemctl --user enable $PWD/ssh-agent.service
systemctl --user start ssh-agent
