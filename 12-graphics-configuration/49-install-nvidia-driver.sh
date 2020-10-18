#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing NVIDIA graphics driver ####"

####################################################################

check_user

####################################################################

if pacman -Qi linux-lts > /dev/null 2>&1 
then
    install_official_packages linux-lts-headers nvidia-lts
    HOOK=nvidia-lts 
else 
    install_official_packages linux-headers nvidia
    HOOK=nvidia
fi

install_official_packages nvidia-settings libvdpau-va-gl

install -Dm 644 $(aux_dir)/${HOOK}.hook /etc/pacman.d/hooks/

####################################################################

finish

