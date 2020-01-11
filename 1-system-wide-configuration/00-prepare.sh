#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Performing initial preparations ####"

####################################################################

check_root

####################################################################

print_message "Creating group 'shared'..."
groupadd shared
mkdir $CONFIG_DIRECTORY
chown root:shared $CONFIG_DIRECTORY
chmod 2775 $CONFIG_DIRECTORY

print_message "Installing sudo..."
pacman --noconfirm -Syu
pacman --noconfirm -S sudo

print_message "Configuring pacman..."
sed -i "s/^#Color/Color/" /etc/pacman.conf

####################################################################

finish

