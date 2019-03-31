#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

check_root

####################################################################

print_message "#### Adding user sudoers configuration ####"

####################################################################

if [ -f /tmp/archlinux-autoconfig-username ]
then USERNAME=$(cat /tmp/archlinux-autoconfig-username)
else
    until read -p 'User name: ' USERNAME
    do echo "Try again"; sleep 2; done
fi

install -Dm 0440 $(aux_dir)/user_sudoers /etc/sudoers.d/${USERNAME}_sudoers
sed -i "s/\$USERNAME/$USERNAME/g" /etc/sudoers.d/${USERNAME}_sudoers

####################################################################

finish

