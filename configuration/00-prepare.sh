#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

check_root

####################################################################

print_message "#### Performing initial preparations ####"

####################################################################

print_message "Creating group 'shared'..."
groupadd shared
mkdir /home/shared
chown root:shared /home/shared
chmod 2775 /home/shared

print_message "Installing sudo..."
pacman --noconfirm -Syu
install_official_packages sudo

####################################################################

finish

