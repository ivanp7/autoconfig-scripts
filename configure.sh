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
echo "---------------------------------------------"
echo

read -p '> Enter user name: ' USERNAME

echo ]]] Creating user \'$USERNAME\'...
useradd -m $USERNAME
echo ]]] Setting password...
until passwd $USERNAME; do echo "Try again"; sleep 2; done

cd /home/$USERNAME/

echo
echo "---------------------------------------------"
echo "     Installing terminal essentials"
echo "---------------------------------------------"
echo

echo ]]] Installing base-devel...
pacman --noconfirm -S base-devel

echo
echo "---------------------------------------------"
echo

echo ]]] Appending the following lines to sudoers...

echo | EDITOR='tee -a' visudo
echo "# User configuration" | EDITOR='tee -a' visudo
echo "Defaults insults" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/poweroff,/usr/bin/halt,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/systemctl hibernate,/usr/bin/systemctl hybrid-sleep" | EDITOR='tee -a' visudo

echo
echo "---------------------------------------------"
echo

echo ]]] Installing vim...
pacman --noconfirm -S vim
echo ]]] Installing vim-config
sudo -H -u $USERNAME git clone $GIT_URL_PREFIX/vim-config.git .vim

# echo ]]] Now vim is going to update installed plugins. Quit from vim manually when the process is complete.
# read -n1 -rsp $'Press any key to continue...\n'
# echo $'\n:PlugUpdate\n' | sudo -H -u $USERNAME vim

ln -s /home/$USERNAME/.vim /root/

echo
echo "---------------------------------------------"
echo

echo ]]] Installing pkgfile, openssh, ranger, neofetch...
pacman --noconfirm -S pkgfile openssh ranger neofetch

echo
echo "---------------------------------------------"
echo

echo ]]] Installing dotfiles...
sudo -H -u $USERNAME git clone $GIT_URL_PREFIX/dotfiles.git
chmod +x dotfiles/install.sh
sudo -H -u $USERNAME dotfiles/install.sh
dotfiles/install.sh

echo
echo "---------------------------------------------"
echo

echo ]]] Installing Open VM Tools...
pacman --noconfirm -S open-vm-tools
systemctl enable vmtoolsd.service vmware-vmblock-fuse.service

echo ]]] Configuring automount of host-shared folder
mkdir HostShared
echo >> /etc/fstab
echo "# VMWare Workstation shared folders" >> /etc/fstab
echo ".host:/VMShared /home/$USERNAME/HostShared fuse.vmhgfs-fuse rw,allow_other,uid=$USERNAME,gid=$USERNAME,umask=0033,auto_unmount,defaults 0 0" >> /etc/fstab
echo >> /etc/fstab

echo
echo "---------------------------------------------"
echo

echo ]]] Installing symbolic links...
sudo -H -u $USERNAME ln -s /home/$USERNAME/Personal/Code/bash/scripts

sudo -H -u $USERNAME ln -s /home/$USERNAME/HostShared/Workspace/Data/Personal
sudo -H -u $USERNAME ln -s /home/$USERNAME/HostShared/Workspace/Downloads

sudo -H -u $USERNAME ln -s /home/$USERNAME/Personal/Code/c_cpp
sudo -H -u $USERNAME ln -s /home/$USERNAME/Personal/Code/common-lisp

echo
echo "---------------------------------------------"
echo

echo ]]] Installing yay
sudo -H -u $USERNAME mkdir tmp
cd tmp
sudo -H -u $USERNAME git clone https://aur.archlinux.org/yay.git
cd yay
sudo -H -u $USERNAME makepkg --noconfirm -si

cd ..
rm -rf yay
cd ..

echo
echo "---------------------------------------------"
echo

echo ]]] Installing tty-clock, when, htop...
pacman --noconfirm -S tty-clock when htop

echo
echo "---------------------------------------------"
echo

echo ]]] Installing kpcli, todotxt...
sudo -H -u $USERNAME yay --noconfirm -S kpcli todotxt

echo
echo "---------------------------------------------"
echo "           Installing graphics"
echo "---------------------------------------------"
echo

echo ]]] Installing xorg and drivers
pacman --noconfirm -S xorg xorg-drivers gtkmm3

echo ]]] Installing i3-gaps
pacman --noconfirm -S i3-gaps

echo
echo "---------------------------------------------"
echo

echo ]]] Installing x-dotfiles
sudo -H -u $USERNAME git clone $GIT_URL_PREFIX/x-dotfiles.git
chmod +x x-dotfiles/install.sh
sudo -H -u $USERNAME x-dotfiles/install.sh

echo
echo "---------------------------------------------"
echo

echo ]]] Installing ALSA
pacman --noconfirm -S alsa-utils
sudo -H -u $USERNAME amixer sset Master unmute
sudo -H -u $USERNAME amixer sset Speaker unmute
sudo -H -u $USERNAME amixer sset Headphone unmute

echo
echo "---------------------------------------------"
echo

echo ]]] Installing termite, dunst
pacman --noconfirm -S termite dunst

echo
echo "---------------------------------------------"
echo

read -n1 -rsp $'Done. Press any key to reboot computer now (Ctrl+C to cancel)...\n'
reboot

