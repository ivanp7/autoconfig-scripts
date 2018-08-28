#!/bin/bash

echo Arch Linux environment auto-configuration script
echo ------------------------------------------------
echo

if [[ $EUID != 0 ]]; then
    echo This script must be run under root. Terminating...
    exit 1
fi

##########################################################################

read -p 'Enter user name: ' USERNAME

echo Creating user \'$USERNAME\'...
useradd -m $USERNAME
echo Setting password...
passwd $USERNAME

##########################################################################

echo Installing sudo...
pacman --noconfirm -S sudo
echo Configuring sudoers...

echo | EDITOR='tee -a' visudo
echo "# User configuration" | EDITOR='tee -a' visudo
echo "Defaults insults" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/poweroff,/usr/bin/halt,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/systemctl hibernate,/usr/bin/systemctl hybrid-sleep" | EDITOR='tee -a' visudo

# echo Please, configure sudoers manually. visudo will be launched now.
# read -n1 -rsp $'Press any key to continue...\n'

