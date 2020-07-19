#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing X essentials ####"

####################################################################

check_user

####################################################################

install_packages shantz-xwinwrap-bzr
install_packages polybar

####################################################################

print_message "Installing x-dotfiles..."
git clone $GIT_URL_PREFIX/x-dotfiles.git
sudo sh x-dotfiles/install.sh

print_message "Installing wallpapers..."
git clone $GIT_URL_PREFIX/wallpapers.git
ln -sf $(realpath wallpapers) $HOME/

####################################################################

finish

