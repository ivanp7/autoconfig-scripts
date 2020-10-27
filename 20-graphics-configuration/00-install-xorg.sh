#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing X server ####"

####################################################################

check_user

####################################################################

TERMINUS_FONT_PACKAGE=$(pacman -Qi terminus-font | grep '^Name\s*:' | sed -E 's/.*:\s*//')

uninstall_packages $TERMINUS_FONT_PACKAGE
install_official_packages xorg xorg-xinit
install_packages $TERMINUS_FONT_PACKAGE

uninstall_packages xorg-xbacklight
install_official_packages acpilight

install_official_packages xf86-video-fbdev

####################################################################

finish

