#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing essentials ####"

####################################################################

check_user

####################################################################

print_message "Changing shell to zsh..."
mkdir -p $HOME/.cache/zsh
chsh -s /usr/bin/zsh

####################################################################

print_message "Installing dotfiles..."
sh dotfiles/install.sh

####################################################################

print_message "Adding Roswell binaries to PATH..."
ln -sT $HOME/.roswell/bin $HOME/bin/roswell

####################################################################

finish

