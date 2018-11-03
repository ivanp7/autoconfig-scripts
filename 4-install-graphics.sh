#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
source $SCRIPT_DIR/functions.sh

####################################################################

print_message "#### Installing graphics ####"

####################################################################

initialize

####################################################################

install_official_packages xorg xorg-xinit xorg-drivers
uninstall_packages vim
install_official_packages gvim
install_official_packages xclip gtkmm3 compton dex fltk
install_official_packages i3-gaps i3status dmenu conky dunst gnome-screenshot
install_official_packages termite

install_official_packages wmctrl

install_official_packages terminus-font ttf-roboto
install_official_packages lxappearance

####################################################################

print_message "Enabling middle mouse click emulation..."
sudo cp $SCRIPT_DIR/aux/10-evdev.conf /etc/X11/xorg.conf.d/

####################################################################

print_message "Installing ALSA..."
install_official_packages alsa-utils
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

####################################################################

print_message "Installing useful software..."
install_official_packages firefox feh vlc

####################################################################

print_message "Installing x-dotfiles..."
git clone $GIT_URL_PREFIX/x-dotfiles.git
sh x-dotfiles/install.sh

####################################################################

finish

