#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing WPA supplicant ####"

####################################################################

initialize

####################################################################

print_message "Installing wpa_supplicant..."

install_official_packages wpa_supplicant
sudo install -Dm 644 $(aux_dir)/wpa_supplicant.conf /etc/wpa_supplicant/
sudo wpa_supplicant -B -i $(cat /proc/net/wireless | tail -n1 | cut -d':' -f1) -c /etc/wpa_supplicant/wpa_supplicant.conf

####################################################################

finish

