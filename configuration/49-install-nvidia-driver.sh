#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing NVIDIA graphics driver ####"

####################################################################

check_user

####################################################################

if pacman -Qs linux-lts > /dev/null && ! pacman -Qs linux > /dev/null
then install_packages nvidia-lts
else install_packages nvidia
fi

install_packages nvidia-settings

####################################################################

finish

