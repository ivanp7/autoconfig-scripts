#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing ALSA  ####"

####################################################################

check_user

####################################################################

install_official_packages alsa-utils
amixer sset Master unmute
amixer sset Speaker unmute
amixer sset Headphone unmute

####################################################################

finish

