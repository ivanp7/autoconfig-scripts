#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Installing terminal essentials ####"

####################################################################

initialize

####################################################################

print_message "Installing base-devel..."
install_official_packages base-devel

print_message "Installing vim..."
install_official_packages vim

print_message "Installing ranger, w3m, neofetch, htop, ncdu, pkgfile..."
install_official_packages ranger w3m neofetch htop ncdu pkgfile

print_message "Installing inotify-tools..."
install_official_packages inotify-tools

print_message "Installing at..."
install_official_packages at
sudo systemctl enable atd
sudo systemctl start atd

print_message "Installing jq..."
install_official_packages jq

print_message "Installing 7z, atool..."
install_official_packages p7zip atool

print_message "Installing screen, openssh, sshfs, fuse3, gnu-netcat, wol, rsync, ethtool..."
install_official_packages screen openssh sshfs fuse3 gnu-netcat wol rsync ethtool
sudo pkgfile --update

print_message "Installing extundelete..."
install_official_packages extundelete

print_message "Installing dosfstools, ntfsprogs..."
install_official_packages dosfstools ntfsprogs

####################################################################

print_message "Installing beep..."
install_official_packages beep

print_message "Installing libcaca..."
install_official_packages libcaca

####################################################################

print_message "Installing octave, sbcl..."
install_official_packages octave sbcl

echo "graphics_toolkit('fltk')" > .octaverc
ln -sf /home/shared/.octaverc $HOME/

####################################################################

print_message "Installing vim-config..."
git clone $GIT_URL_PREFIX/vim-config.git
sh vim-config/install.sh
sudo sh vim-config/install.sh

print_message "Installing dotfiles..."
git clone $GIT_URL_PREFIX/dotfiles.git
sh dotfiles/install.sh
sudo sh dotfiles/install.sh

####################################################################

print_message "Installing yay..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd /home/shared

####################################################################

print_message "Fixing bash-completion..."
sudo mkdir -p /usr/share/bash_completion.d
sudo ln -s /usr/share/bash_completion.d /etc/

####################################################################

print_message "Installing tty-clock, when, todotxt, kpcli..."
install_packages tty-clock when todotxt kpcli perl-capture-tiny perl-clipboard

####################################################################

finish

