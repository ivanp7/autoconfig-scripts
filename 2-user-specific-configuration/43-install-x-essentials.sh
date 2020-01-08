#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing X essentials ####"

####################################################################

check_user

####################################################################

print_message "Installing x-dotfiles..."
sh x-dotfiles/install.sh

####################################################################

finish

