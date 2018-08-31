#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Swapping Ctrl/CapsLock keys ####"

####################################################################

initialize

####################################################################

echo $'
keymaps 0-127
keycode 29 = Caps_Lock
keycode 58 = Control
' | sudo tee /etc/ctrl-caps-swap.map

echo $'
[Unit]
Description=Swap Ctrl and Caps Lock keys

[Service]
Type=oneshot
ExecStart=/usr/bin/loadkeys /etc/ctrl-caps-swap.map

[Install]
WantedBy=default.target
' | sudo tee /etc/systemd/system/ctrl-caps-swap.service

sudo systemctl enable ctrl-caps-swap.service
sudo systemctl start ctrl-caps-swap.service

echo $'
clear lock
clear control
keycode 37 = Caps_Lock
keycode 66 = Control_L
add lock = Caps_Lock
add control = Control_L Control_R
' | sudo tee .Xmodmap

####################################################################

finish

