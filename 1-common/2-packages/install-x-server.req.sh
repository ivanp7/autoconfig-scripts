#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install X server"
. "./.init.sh"

####################################################################

if ! check_packages $AUR_HELPER
then
    print_error "AUR helper is not available"
    exit 1
fi

TERMINUS_FONT_PACKAGE=$(find_package terminus-font)

uninstall_packages $TERMINUS_FONT_PACKAGE
install_packages xorg xorg-xinit
install_packages $TERMINUS_FONT_PACKAGE

uninstall_packages xorg-xbacklight
install_packages acpilight

install_packages xf86-video-fbdev

