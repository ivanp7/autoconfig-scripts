#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing NVIDIA graphics driver ####"

####################################################################

check_user

####################################################################

pacman -Qi linux-lts > /dev/null 2>&1 && PKG=nvidia-lts || PKG=nvidia
install_packages $PKG nvidia-settings

####################################################################

finish

