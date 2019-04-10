#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing essentials ####"

####################################################################

check_user

####################################################################

install_official_packages base-devel
install_official_packages powerline powerline-fonts
install_official_packages vim ranger w3m screen tmux 
install_official_packages neofetch htop cpupower
install_official_packages pkgfile
sudo pkgfile --update
install_official_packages pass
install_official_packages openssh sshfs 
install_official_packages wget rsync git-annex
install_official_packages gnu-netcat wol ethtool ifplugd 
install_official_packages moreutils jq dialog expect
install_official_packages ncdu extundelete dosfstools ntfsprogs inotify-tools
install_official_packages p7zip atool
install_official_packages at cronie
sudo systemctl enable atd cronie
sudo systemctl start atd cronie
install_official_packages beep libcaca fbv mpv
install_official_packages ffmpegthumbnailer

####################################################################

install_official_packages zsh zsh-completions zsh-syntax-highlighting

sudo mkdir -p /etc/pacman.d/hooks/
sudo install -Dm 644 $(aux_dir)/zsh.hook /etc/pacman.d/hooks/

print_message "Changing shell to zsh..."
chsh -s /usr/bin/zsh
sudo chsh -s /usr/bin/zsh

####################################################################

cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd /home/shared

####################################################################

install_official_packages octave
install_packages when todotxt

install_official_packages sbcl
install_packages quicklisp

####################################################################

print_message "Installing dotfiles..."
git clone $GIT_URL_PREFIX/dotfiles.git
sh dotfiles/install.sh
sudo sh dotfiles/install.sh

####################################################################

finish

