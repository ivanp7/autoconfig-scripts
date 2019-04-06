#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing X games ####"

####################################################################

check_user

####################################################################

install_official_packages gnome-mahjongg

####################################################################

finish

