#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Creating a maintainer user ####"

####################################################################

check_root

####################################################################

until { echo -n 'User name: '; read USERNAME; useradd -m "$USERNAME"; }
do echo "Try again"; sleep 2; done
until passwd $USERNAME; do echo "Try again"; sleep 2; done

echo $USERNAME > /tmp/archlinux-autoconfig-username

print_message "Adding user to group 'shared'..."
gpasswd -a $USERNAME shared

####################################################################

finish

