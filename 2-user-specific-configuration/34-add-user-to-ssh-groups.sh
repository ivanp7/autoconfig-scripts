#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Adding user to the ssh groups ####"

####################################################################

check_user

####################################################################

sudo gpasswd -a $(whoami) ssh-users
sudo gpasswd -a $(whoami) sftp-users

####################################################################

finish

