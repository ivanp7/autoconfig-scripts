#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing X essentials ####"

####################################################################

check_user

####################################################################

install_official_packages xorg xorg-xinit xorg-drivers

uninstall_packages vim
install_official_packages gvim

install_official_packages bspwm picom libnotify dunst maim
install_packages shantz-xwinwrap-bzr
install_official_packages sxhkd wmctrl unclutter
install_official_packages dex
install_official_packages dmenu
install_packages polybar

install_official_packages xclip xsel

install_official_packages gtkmm3 fltk
install_official_packages terminus-font ttf-roboto
install_official_packages adapta-gtk-theme
install_official_packages lxappearance

####################################################################

print_message "Installing media software..."
install_official_packages feh zathura zathura-pdf-mupdf zathura-djvu

print_message "Installing Firefox and addons..."
install_official_packages firefox firefox-ublock-origin firefox-decentraleyes

print_message "Installing basic games..."
install_official_packages gnome-mahjongg

####################################################################

print_message "Installing x-dotfiles..."
git clone $GIT_URL_PREFIX/x-dotfiles.git
sh x-dotfiles/install.sh

####################################################################

finish

