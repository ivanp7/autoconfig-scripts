#!/bin/bash

echo
echo ------------------------------------------------
echo Arch Linux environment auto-configuration script
echo ------------------------------------------------
echo

if [[ $EUID != 0 ]]; then
    echo This script must be run under root. Terminating...
    exit 1
fi

GIT_URL_PREFIX=https://gitlab.com/ivanp7
echo
echo "#################################################"
echo

read -p '> Enter user name: ' USERNAME

echo ] Creating user \'$USERNAME\'...
useradd -m $USERNAME
echo ] Setting password...
until passwd $USERNAME; do echo "Try again"; sleep 2; done

echo
echo "#################################################"
echo

echo ] Installing sudo...
pacman --noconfirm -S sudo
echo ] Appending the following lines to sudoers...

echo | EDITOR='tee -a' visudo
echo "# User configuration" | EDITOR='tee -a' visudo
echo "Defaults insults" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/poweroff,/usr/bin/halt,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/systemctl hibernate,/usr/bin/systemctl hybrid-sleep" | EDITOR='tee -a' visudo

echo
echo "#################################################"
echo

cd /home/$USERNAME/

echo ] Installing vim...
pacman --noconfirm -S vim
echo ] Installing vim-config
sudo -H -u $USERNAME (git clone $GIT_URL_PREFIX/vim-config.git .vim; vim +PlugUpdate)
ln -s /home/$USERNAME/.vim /root/

# echo Please, configure sudoers manually. visudo will be launched now.
# read -n1 -rsp $'Press any key to continue...\n'

