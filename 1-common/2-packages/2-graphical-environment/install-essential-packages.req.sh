#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install essential packages for X server"
. "./.init.sh"

####################################################################

install_packages \
`# Window manager and additional components` \
    bspwm polybar \
    libnotify dunst \
`# Hotkey daemon` \
    sxhkd \
`# Screen capturing tools` \
    maim \
`# Graphical environment scripting tools` \
    wmctrl xdotool \
    xclip xsel \
    xssstate \
    xkb-switch \
    xkbset \
    shantz-xwinwrap-bzr \
`# Graphical toolkits` \
    gtkmm3 fltk \
`# Media tools` \
    feh zathura \
    ffmpeg ffmpegthumbnailer

