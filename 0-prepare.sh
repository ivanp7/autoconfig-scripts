#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

check_root

####################################################################

print_message "#### Performing initial preparations ####"

####################################################################

print_message "Creating group 'shared'..."
groupadd shared
mkdir /home/shared
chown root:shared /home/shared
chmod 775 /home/shared

print_message "Installing sudo..."
pacman --noconfirm -Syu
pacman --noconfirm -S sudo

####################################################################

finish

