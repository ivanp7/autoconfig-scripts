#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing NVIDIA graphics driver ####"

####################################################################

check_user

####################################################################

install_packages nvidia nvidia-xrun

####################################################################

finish

