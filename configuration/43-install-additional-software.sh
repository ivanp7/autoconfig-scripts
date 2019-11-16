#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing additional software ####"

####################################################################

check_user

####################################################################

install_packages telegram-desktop 
install_packages qbittorrent 
install_packages libreoffice-still aspell-ru phototonic

####################################################################

finish

