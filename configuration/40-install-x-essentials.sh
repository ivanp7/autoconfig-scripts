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
install_official_packages xclip xsel gtkmm3 compton dex fltk
install_official_packages i3-gaps dmenu libnotify dunst gnome-screenshot
install_packages polybar

install_official_packages wmctrl

install_official_packages terminus-font ttf-roboto
install_official_packages adapta-gtk-theme
install_official_packages lxappearance

####################################################################

print_message "Installing media software..."
install_official_packages feh vlc zathura zathura-pdf-mupdf zathura-djvu

print_message "Installing Firefox and addons..."
install_official_packages firefox firefox-ublock-origin firefox-decentraleyes

####################################################################

print_message "Installing x-dotfiles..."
git clone $GIT_URL_PREFIX/x-dotfiles.git
sh x-dotfiles/install.sh

####################################################################

finish

