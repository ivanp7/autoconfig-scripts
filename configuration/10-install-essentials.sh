#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing essentials ####"

####################################################################

check_user

####################################################################

install_official_packages base-devel
install_official_packages vim powerline powerline-fonts ranger w3m screen tmux neofetch htop
install_official_packages pkgfile
sudo pkgfile --update
install_official_packages pass
install_official_packages openssh sshfs gnu-netcat wol rsync ethtool wget git-annex
install_official_packages moreutils dialog
install_official_packages p7zip atool
install_official_packages ncdu extundelete dosfstools ntfsprogs inotify-tools
install_official_packages jq
install_official_packages at cronie
sudo systemctl enable atd cronie
sudo systemctl start atd cronie
install_official_packages beep libcaca fbv mpv
install_official_packages ffmpegthumbnailer

install_official_packages octave sbcl

####################################################################

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

print_message "Installing quicklisp..."
install_packages quicklisp

print_message "Installing bash-completion..."
install_official_packages bash-completion
sudo mkdir -p /usr/share/bash_completion.d
sudo ln -s /usr/share/bash_completion.d /etc/

print_message "Installing tmux-bash-completion..."
install_packages tmux-bash-completion

####################################################################

print_message "Installing when, todotxt..."
install_packages when todotxt

####################################################################

print_message "Installing basic game collection..."
install_packages cgames bs

print_message "Installing terminal picture viewer and media player..."
install_packages pixterm-git termplay 

print_message "Installing other useful programs..."
install_packages lolcat fortune-mod sl cmatrix ponysay nyancat

####################################################################

finish

