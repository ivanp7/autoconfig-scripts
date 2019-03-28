#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing NVIDIA graphics driver ####"

####################################################################

initialize

####################################################################

print_message "Installing graphics driver..."
install_packages nvidia nvidia-xrun

####################################################################

finish

