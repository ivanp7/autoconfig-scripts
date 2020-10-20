#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Fix computer suspend with Nvidia driver ####"

####################################################################

check_root

####################################################################

install -Dm 644 $(aux_dir)/nvidia_copy /usr/lib/elogind/system-sleep/
install -Dm 755 $(aux_dir)/nvidia_copy /usr/lib/elogind/system-sleep/nvidia
install -Dm 644 $(aux_dir)/nvidia-utils.hook /etc/pacman.d/hooks/

####################################################################

finish

