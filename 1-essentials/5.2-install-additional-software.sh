#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing additional software ####"

####################################################################

initialize

####################################################################

print_message "Installing telegram-desktop, qbittorrent, libreoffice, mtpaint..."
install_packages telegram-desktop qbittorrent libreoffice-still aspell-ru mtpaint

####################################################################

finish

