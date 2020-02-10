#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Setting grub wallpaper ####"

####################################################################

check_root

####################################################################

install -Dm 644 $(aux_dir)/archlinux.png /boot/grub/
sed -i 's@^#GRUB_BACKGROUND=.*$@GRUB_BACKGROUND="/boot/grub/archlinux.png"@' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish
