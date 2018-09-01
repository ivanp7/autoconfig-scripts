#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

check_root

####################################################################

print_message "#### Creating a non-priviledged user ####"

read -p '> Enter user name: ' USERNAME
useradd -m $USERNAME
until passwd $USERNAME; do echo "Try again"; sleep 2; done

####################################################################

print_message "Installing sudo..."
pacman --noconfirm -S sudo

print_message "Appending the following lines to sudoers..."

echo | EDITOR='tee -a' visudo
echo "# User configuration" | EDITOR='tee -a' visudo
echo "Defaults insults" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/poweroff,/usr/bin/halt,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/systemctl hibernate,/usr/bin/systemctl hybrid-sleep" | EDITOR='tee -a' visudo

####################################################################

finish

