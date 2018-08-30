#!/bin/bash

GIT_URL_PREFIX=https://gitlab.com/ivanp7

####################################################################

print_message ()
{
    echo
    echo $(printf '%0.s-' $(seq 1 $(wc -c <<< $*)))
    echo $*
    echo $(printf '%0.s-' $(seq 1 $(wc -c <<< $*)))
    echo
}

run_as_nonroot ()
{
    sudo -H -u $USERNAME "$@"
}

install_official_packages ()
{
    pacman --noconfirm -S "$@"
}

install_packages ()
{
    run_as_nonroot yay --noconfirm -S "$@"
}

finish ()
{
    # read -n1 -rsp $'Done. Press any key to reboot computer now (Ctrl+C to cancel)...\n'
    print_message "Done. Restarting in 5 seconds. Press Ctrl+C to abort..."
    sleep 5
    reboot
}

####################################################################

print_message "Arch Linux VM environment auto-configuration script"

if [[ $EUID != 0 ]]; then
    echo This script must be run under root. Terminating...
    exit 1
fi

####################################################################

print_message "Creating a non-priviledged user..."

read -p '> Enter user name: ' USERNAME
useradd -m $USERNAME
until passwd $USERNAME; do echo "Try again"; sleep 2; done

cd /home/$USERNAME/

pacman -Syu

####################################################################

print_message "Installing sudo..."
install_official_packages sudo

print_message "Appending the following lines to sudoers..."

echo | EDITOR='tee -a' visudo
echo "# User configuration" | EDITOR='tee -a' visudo
echo "Defaults insults" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) ALL" | EDITOR='tee -a' visudo
echo "%$USERNAME ALL=(ALL) NOPASSWD: /usr/bin/shutdown,/usr/bin/poweroff,/usr/bin/halt,/usr/bin/reboot,/usr/bin/systemctl suspend,/usr/bin/systemctl hibernate,/usr/bin/systemctl hybrid-sleep" | EDITOR='tee -a' visudo

####################################################################
####################################################################

print_message "#### Installing terminal essentials ####"

####################################################################

print_message "Installing base-devel..."
install_official_packages base-devel

print_message "Installing vim..."
install_official_packages vim

print_message "Installing vim-config..."
run_as_nonroot git clone $GIT_URL_PREFIX/vim-config.git .vim
ln -s /home/$USERNAME/.vim /root/

print_message "Installing pkgfile, openssh, sshfs, fuse3, ranger, neofetch, htop, ncdu..."
install_official_packages pkgfile openssh sshfs fuse3 ranger neofetch htop ncdu

print_message "Installing dosfstools, ntfsprogs..."
install_official_packages dosfstools ntfsprogs

print_message "Installing libcaca..."
install_official_packages libcaca

####################################################################

print_message "Installing dotfiles..."
run_as_nonroot git clone $GIT_URL_PREFIX/dotfiles.git
chmod +x dotfiles/install.sh
run_as_nonroot dotfiles/install.sh
dotfiles/install.sh

####################################################################

print_message "Installing yay"
run_as_nonroot mkdir -p tmp
cd tmp
run_as_nonroot git clone https://aur.archlinux.org/yay.git
cd yay
run_as_nonroot makepkg --noconfirm -si

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
####################################################################

if [[ "$1" != "+graphics" ]]; then finish; fi

print_message "#### Installing graphics ####"

####################################################################

print_message "Installing xorg and drivers..."
install_official_packages xorg xorg-xinit xorg-drivers

print_message "Installing xclip, gtkmm3, compton, dex, fltk..."
install_official_packages xclip gtkmm3 compton dex fltk

print_message "Installing i3-gaps, i3status, dmenu, conky, dunst, gnome-screenshot..."
install_official_packages i3-gaps i3status dmenu conky dunst gnome-screenshot

print_message "Installing termite..."
install_official_packages termite

####################################################################

print_message "Installing fonts..."
install_packages ttf-input ttf-roboto

print_message "Installing lxappearance..."
install_official_packages lxappearance

####################################################################

print_message "Installing x-dotfiles..."
run_as_nonroot git clone $GIT_URL_PREFIX/x-dotfiles.git
chmod +x x-dotfiles/install.sh
run_as_nonroot x-dotfiles/install.sh

####################################################################

print_message "Installing ALSA..."
install_official_packages alsa-utils

run_as_nonroot amixer sset Master unmute
run_as_nonroot amixer sset Speaker unmute
run_as_nonroot amixer sset Headphone unmute

####################################################################

print_message "Installing firefox, feh, vlc..."
install_official_packages firefox feh vlc

####################################################################

finish

