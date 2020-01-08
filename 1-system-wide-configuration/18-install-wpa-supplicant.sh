#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing WPA supplicant ####"

####################################################################

check_root

####################################################################

install_official_packages wpa_supplicant
install -Dm 644 $(aux_dir)/wpa_supplicant.conf /etc/wpa_supplicant/
ip link | grep -E '^[[:digit:]]*: *wl.*:' | sed -E 's/^(.*): *(.*): (.*)/\2/' | head -n1 | 
    xargs -I {} wpa_supplicant -B -i {} -c /etc/wpa_supplicant/wpa_supplicant.conf

####################################################################

finish

