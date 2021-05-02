#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Installing X essentials from official repositories ####"

####################################################################

check_user

####################################################################

print_message "#### Installing window manager and components ####"

install_official_packages bspwm picom
install_official_packages unclutter
install_official_packages libnotify dunst

install_packages polybar

install_official_packages dex

install_official_packages arandr

print_message "#### Installing hotkey daemon ####"

install_official_packages sxhkd

install_packages xkbset

print_message "#### Installing screen capturing tools ####"

install_official_packages maim

print_message "#### Installing graphical environment scripting tools ####"

install_official_packages wmctrl xdotool
install_official_packages xclip xsel
install_official_packages xssstate
install_packages xkb-switch

install_packages shantz-xwinwrap-bzr

print_message "#### Installing graphical toolkits ####"

install_official_packages gtkmm3 fltk

print_message "#### Installing fonts and themes ####"

install_official_packages ttf-roboto ttf-liberation
install_official_packages adapta-gtk-theme

print_message "#### Installing graphical appearance settings interface ####"

install_official_packages lxappearance

print_message "#### Installing media tools ####"

install_official_packages feh zathura zathura-pdf-mupdf zathura-djvu zathura-ps
install_official_packages ffmpeg ffmpegthumbnailer

print_message "#### Install Roswell applications ####"

ros install ivanp7/cl-image2text

####################################################################

finish

