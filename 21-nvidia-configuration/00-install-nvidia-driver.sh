#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing NVIDIA graphics driver ####"

####################################################################

check_root

####################################################################

if pacman -Qi linux-lts > /dev/null 2>&1 
then
    install_official_packages linux-lts-headers nvidia-lts
    HOOK=nvidia-lts 
else 
    install_official_packages linux-headers nvidia
    HOOK=nvidia
fi

install_official_packages nvidia-settings libvdpau-va-gl nvtop

install -Dm 644 "$(aux_dir)/${HOOK}.hook" /etc/pacman.d/hooks/

####################################################################

finish

