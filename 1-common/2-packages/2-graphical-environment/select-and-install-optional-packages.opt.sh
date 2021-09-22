#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Select and install optional packages for X server"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

choose_packages_and_start_self_logging \
`# Additional components of a graphical environment` \
    picom "X compositor that may fix tearing issues" off \
    unclutter "A small program for hiding the mouse cursor" on \
    dex "Program to generate and execute DesktopEntry files of type Application" on \
`# Graphical environment control` \
    arandr "Provide a simple visual front end for XRandR 1.2" on \
    lxappearance "Feature-rich GTK+ theme switcher of the LXDE Desktop" off \
`# Pulseaudio settings interface` \
    pavucontrol "PulseAudio Volume Control" on \
    paprefs "Configuration dialog for PulseAudio" on \
`# Fonts and themes` \
    ttf-liberation "Font family which aims at metric compatibility with Arial, Times New Roman, and Courier New" on \
    ttf-roboto "Google's signature family of fonts" on \
    adapta-gtk-theme "An adaptive Gtk+ theme based on Material Design Guidelines" on \
`# Media tools` \
    zathura-pdf-mupdf "PDF support for Zathura (MuPDF backend) (Supports PDF, ePub, and OpenXPS)" off \
    zathura-djvu "DjVu support for Zathura" off \
    zathura-ps "Adds ps support to zathura by using the libspectre library" off \
`# Basic game collection` \
    gnome-mahjongg "Disassemble a pile of tiles by removing matching pairs" off \
    powder-toy "Desktop version of the classic falling sand physics sandbox, simulates air pressure, velocity & heat!" off

install_packages $AUTOCONFIG_CHOSEN_PACKAGES

