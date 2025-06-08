bash ./sway/install.sh
bash ./codecs/install.sh

sudo grubby --update-kernel=ALL --args="hid_apple.swap_opt_cmd=1"
sudo grubby --update-kernel=ALL --args="hid_apple.swap_fn_leftctrl=1"

# su
# vi /etc/udev/rules.d/99-asahi-battery.rules
# KERNEL=="macsmc-battery", SUBSYSTEM=="power_supply", ATTR{charge_control_end_threshold}="80", ATTR{charge_control_start_threshold}="70"
