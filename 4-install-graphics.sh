#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Installing graphics ####"

####################################################################

initialize

####################################################################

print_message "Installing xorg and drivers..."
install_official_packages xorg xorg-xinit xorg-drivers

print_message "Installing gvim..."
uninstall_packages vim
install_official_packages gvim

print_message "Installing xclip, gtkmm3, compton, dex, fltk..."
install_official_packages xclip gtkmm3 compton dex fltk

print_message "Installing i3-gaps, i3status, dmenu, conky, dunst, gnome-screenshot..."
install_official_packages i3-gaps i3status dmenu conky dunst gnome-screenshot

print_message "Installing wmctrl..."
install_official_packages wmctrl

print_message "Installing termite..."
install_official_packages termite

####################################################################

print_message "Installing fonts..."
install_official_packages terminus-font ttf-roboto
# install_packages ttf-input

print_message "Installing lxappearance..."
install_official_packages lxappearance

####################################################################

print_message "Enabling middle mouse click emulation..."
echo $'
Section \"InputClass\"
  Identifier \"system-mouse\"
  Option \"MiddleEmulation\" \"true\"
EndSection
' | sudo tee /etc/X11/xorg.conf.d/10-evdev.conf

####################################################################

print_message "Installing ALSA..."
install_official_packages alsa-utils

amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

####################################################################

print_message "Installing firefox, feh, vlc..."
install_official_packages firefox feh vlc

####################################################################

print_message "Installing russian spell dictionary..."
install_official_packages aspell-ru

####################################################################

print_message "Installing x-dotfiles..."
git clone $GIT_URL_PREFIX/x-dotfiles.git
sh x-dotfiles/install.sh

####################################################################

finish

