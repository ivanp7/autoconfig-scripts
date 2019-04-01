#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring system ####"

####################################################################

check_user

####################################################################

print_message "Setting number of VT's..."
sudo sed -i "s/#NAutoVTs=6/NAutoVTs=12/" /etc/systemd/logind.conf

print_message "Setting grub wallpaper..."
sudo install -Dm 644 $(aux_dir)/archlinux.png /boot/grub/
sudo sed -i 's@^#GRUB_BACKGROUND=.*$@GRUB_BACKGROUND="/boot/grub/archlinux.png"@' /etc/default/grub
sudo grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

