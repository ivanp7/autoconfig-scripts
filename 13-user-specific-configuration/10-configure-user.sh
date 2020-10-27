#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/functions.sh"

####################################################################

print_message "#### Performing basic user configuration ####"

####################################################################

check_user

####################################################################

print_message "Changing shell to zsh..."
mkdir -p $HOME/.cache/zsh
chsh -s /usr/bin/zsh

####################################################################

print_message "Adding Roswell binaries to PATH..."
ln -sT $HOME/.roswell/bin $HOME/bin/roswell

####################################################################

finish

