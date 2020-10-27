#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Setting grub wallpaper ####"

####################################################################

check_root

####################################################################

install -Dm 644 "$(aux_dir)/grub.jpg" /boot/grub/
sed -i 's@^#GRUB_BACKGROUND=.*$@GRUB_BACKGROUND="/boot/grub/grub.jpg"@' /etc/default/grub
grub-mkconfig -o /boot/grub/grub.cfg

####################################################################

finish

