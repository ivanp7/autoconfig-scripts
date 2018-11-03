#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
source $SCRIPT_DIR/functions.sh

####################################################################

print_message "#### Installing terminal essentials ####"

####################################################################

initialize

####################################################################

install_official_packages base-devel
install_official_packages vim powerline powerline-fonts ranger w3m screen tmux
install_official_packages neofetch htop ncdu pkgfile
sudo pkgfile --update
install_official_packages openssh sshfs gnu-netcat wol rsync ethtool
install_official_packages p7zip atool
install_official_packages extundelete dosfstools ntfsprogs inotify-tools
install_official_packages jq
install_official_packages at cronie
sudo systemctl enable atd cronie
sudo systemctl start atd cronie
install_official_packages beep libcaca fbv

####################################################################

install_official_packages octave sbcl
cp $SCRIPT_DIR/aux/.octaverc ./
ln -sf $(realpath .octaverc) $HOME/

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

YAFT_TABSTOP=4
YAFT_TERMINUS_FONT_VARIATION=u12n

print_message "Installing yaft..."
cd /tmp
git clone https://aur.archlinux.org/yaft.git
cd yaft
makepkg --noconfirm -o
YAFT_VER=$(cat PKGBUILD | grep ^pkgver= | cut -d'=' -f2)
cd src/yaft-$YAFT_VER/
# change TABSTOP
sed -i "/^[[:blank:]]*TABSTOP[[:blank:]]*=/ s/8/$YAFT_TABSTOP/" conf.h
# do not build default font
sed -i '/^[[:blank:]]*.\/mkfont_bdf/ s/.\/mkfont_bdf/# .\/mkfont_bdf/' makefile
# build Terminus font instead
make mkfont_bdf
cp $SCRIPT_DIR/aux/glyph_builder.sh ./
sh glyph_builder.sh terminus $YAFT_TERMINUS_FONT_VARIATION
cd ../..
makepkg --noconfirm -ei

####################################################################

print_message "Installing yay..."
cd /tmp
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg --noconfirm -si
cd /home/shared

####################################################################

print_message "Installing bash-completion..."
install_official_packages bash-completion
sudo mkdir -p /usr/share/bash_completion.d
sudo ln -s /usr/share/bash_completion.d /etc/

print_message "Installing tmux-bash-completion..."
install_packages tmux-bash-completion

####################################################################

print_message "Installing tty-clock, when, todotxt, kpcli..."
install_packages tty-clock when todotxt kpcli perl-capture-tiny perl-clipboard

####################################################################

print_message "Configuring system..."
sudo sed -i "s/#NAutoVTs=6/NAutoVTs=12/" /etc/systemd/logind.conf

####################################################################

finish

