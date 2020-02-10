#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing essentials ####"

####################################################################

check_user

####################################################################

print_message "Installing dotfiles..."
git clone $GIT_URL_PREFIX/dotfiles.git
sudo sh dotfiles/install.sh

####################################################################

print_message "Installing yay..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd $CONFIG_DIRECTORY

####################################################################

print_message "Installing essentials from AUR..."
install_packages lf archivemount 
install_packages roswell quicklisp
install_packages stardict-full-eng-rus stardict-full-rus-eng
install_packages stardict-slang-eng-rus stardict-computer-ru

print_message "Installing basic game collection..."
install_packages cgames bs

print_message "Installing other useful programs..."
install_packages lolcat fortune-mod sl cmatrix ponysay nyancat

####################################################################

finish
