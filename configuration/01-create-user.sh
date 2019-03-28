#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

check_root

####################################################################

print_message "#### Creating a maintainer user ####"

until { read -p 'User name: ' USERNAME; useradd -m "$USERNAME"; }
do echo "Try again"; sleep 2; done
until passwd $USERNAME; do echo "Try again"; sleep 2; done

####################################################################

print_message "Adding user to group 'shared'..."
gpasswd -a $USERNAME shared

print_message "Configuring sudoers..."
cat $(aux_dir)/sudoers_tail | sed "s/\$USERNAME/$USERNAME/g" | \
    EDITOR='tee -a' visudo

####################################################################

finish

