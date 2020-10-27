#!/bin/sh

ROOT_DIR="$(realpath "$(dirname "$0")")/.."
. "$ROOT_DIR/.functions.sh"

####################################################################

print_message "#### Adding user sudoers configuration ####"

####################################################################

check_root

####################################################################

if [ -f /tmp/archlinux-autoconfig-username ]
then USERNAME=$(cat /tmp/archlinux-autoconfig-username)
else
    until { echo -n 'User name: '; read USERNAME; }
    do echo "Try again"; sleep 2; done
fi

install -Dm 0440 "$(aux_dir)/user_sudoers" /etc/sudoers.d/${USERNAME}_sudoers
sed -i "s/\$USERNAME/$USERNAME/g" /etc/sudoers.d/${USERNAME}_sudoers

####################################################################

finish

