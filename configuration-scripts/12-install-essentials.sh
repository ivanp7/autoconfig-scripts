#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing essentials ####"

####################################################################

check_user

####################################################################

install_official_packages base-devel ctags
install_official_packages vim w3m screen tmux 
install_official_packages neofetch htop glances
install_official_packages pkgfile
sudo pkgfile --update
sudo systemctl enable pkgfile-update.timer
install_official_packages when task pass
install_official_packages openssh sshfs encfs
install_official_packages wget rsync
install_official_packages gnu-netcat wol ethtool ifplugd 
install_official_packages cpupower
install_official_packages dosfstools ntfsprogs inotify-tools
install_official_packages ncdu extundelete trash-cli
install_official_packages unzip p7zip atool
install_official_packages at cronie
sudo systemctl enable --now atd cronie
install_official_packages moreutils jq dialog expect
install_official_packages beep libcaca fbv mpv
install_official_packages ffmpegthumbnailer
install_official_packages youtube-dl
install_official_packages sdcv
install_official_packages octave

####################################################################

print_message "Relinking sh to dash..."
install_official_packages dash

sudo ln -sfT dash /usr/bin/sh
sudo mkdir -p /etc/pacman.d/hooks/
sudo install -Dm 644 $(aux_dir)/dash.hook /etc/pacman.d/hooks/

print_message "Changing shell to zsh..."
install_official_packages zsh zsh-completions zsh-syntax-highlighting

sudo mkdir -p /root/.cache/zsh
sudo mkdir -p /var/cache/zsh/
sudo install -Dm 644 $(aux_dir)/zsh.hook /etc/pacman.d/hooks/

chsh -s /usr/bin/zsh
sudo chsh -s /usr/bin/zsh

####################################################################

print_message "Installing yay..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd $CONFIG_DIRECTORY

####################################################################

print_message "Installing essentials from AUR..."
install_packages lf archivemount 
install_packages roswell
install_packages stardict-full-eng-rus stardict-full-rus-eng
install_packages stardict-slang-eng-rus stardict-computer-ru

print_message "Installing basic game collection..."
install_packages cgames bs

print_message "Installing other useful programs..."
install_packages lolcat fortune-mod sl cmatrix ponysay nyancat

####################################################################

print_message "Installing dotfiles..."
git clone $GIT_URL_PREFIX/dotfiles.git
sh dotfiles/install.sh
sudo sh dotfiles/install.sh

####################################################################

finish

