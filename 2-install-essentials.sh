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

print_message "Installing vim-config..."
git clone $GIT_URL_PREFIX/vim-config.git .vim
sudo ln -s /home/$USERNAME/.vim /root/

print_message "Installing pkgfile, openssh, sshfs, fuse3, ranger, w3m, neofetch, htop, ncdu..."
install_official_packages pkgfile openssh sshfs fuse3 ranger w3m neofetch htop ncdu
sudo pkgfile --update

print_message "Installing dosfstools, ntfsprogs..."
install_official_packages dosfstools ntfsprogs

print_message "Installing libcaca..."
install_official_packages libcaca

####################################################################

print_message "Installing dotfiles..."
git clone $GIT_URL_PREFIX/dotfiles.git
chmod +x dotfiles/install.sh
dotfiles/install.sh
sudo dotfiles/install.sh

####################################################################

print_message "Installing yay"
mkdir -p tmp
cd tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si

cd ../..
rm -rf tmp/yay

####################################################################

print_message "Installing tty-clock, when, todotxt, kpcli, htop, ncdu..."
install_packages tty-clock when todotxt kpcli perl-capture-tiny perl-clipboard htop ncdu

####################################################################

print_message "Installing octave, sbcl..."
install_packages octave sbcl

echo "graphics_toolkit('fltk')" | run_as_nonroot tee .octaverc

####################################################################

finish

