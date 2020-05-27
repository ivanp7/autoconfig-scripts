#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing X essentials ####"

####################################################################

check_root

####################################################################

uninstall_packages terminus-font
install_official_packages xorg xorg-xinit
install_official_packages xf86-video-fbdev
install_official_packages terminus-font

install_official_packages bspwm picom unclutter libnotify dunst maim
install_official_packages sxhkd wmctrl xdotool
install_official_packages dex
install_official_packages dmenu

install_official_packages xclip xsel

install_official_packages gtkmm3 fltk
install_official_packages terminus-font ttf-roboto
install_official_packages adapta-gtk-theme
install_official_packages lxappearance

####################################################################

print_message "Installing media software..."
install_official_packages feh zathura zathura-pdf-mupdf zathura-djvu

print_message "Installing Firefox and addons..."
install_official_packages firefox firefox-extension-https-everywhere 
install_official_packages firefox-ublock-origin firefox-decentraleyes

print_message "Installing basic games..."
install_official_packages gnome-mahjongg

####################################################################

finish

