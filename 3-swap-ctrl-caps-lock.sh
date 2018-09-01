#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Swapping Ctrl/CapsLock keys ####"

####################################################################

initialize

####################################################################

sudo dumpkeys | head -1 | sudo tee /etc/ctrl-caps-swap.map
echo $'keycode 29 = Caps_Lock
keycode 58 = Control
' | sudo tee -a /etc/ctrl-caps-swap.map

echo $'[Unit]
Description=Swap Ctrl and Caps Lock keys

[Service]
Type=oneshot
ExecStartPre=/usr/bin/sleep 1
ExecStart=/usr/bin/loadkeys /etc/ctrl-caps-swap.map
After=systemd-vconsole-setup.service

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

