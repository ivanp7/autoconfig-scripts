#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Install essential packages"
. "./.init.sh"

####################################################################

install_packages \
`# Manuals` \
    man-db man-pages \
`# Shells` \
    dash \
    zsh zsh-completions zsh-syntax-highlighting \
`# SSH` \
    openssh sshfs \
`# File transfering tools` \
    wget rsync \
`# Filesystem management tools` \
    inotify-tools entr \
    ncdu trash-cli \
`# Archives management tools` \
    unzip unrar p7zip atool \
    archivemount \
`# Hardware management tools` \
    acpi usbutils \
    wol ethtool \
`# System state monitoring and control tools` \
    neofetch htop iftop \
    ntp ntp-runit \
    pkgfile \
`# Cron and delayed jobs tools` \
    at cronie \
`# Basic development, programming and debugging tools` \
    patchutils \
    ctags cppcheck \
    time \
    gdb strace ltrace \
    lsof \
    gnu-netcat ngrep tcpdump nmap \
    socat \
`# Auxilliary tools` \
    dialog \
    jq expect \
    dos2unix \
`# Editor` \
    neovim \
    nvimpager-git xxd-standalone \
`# Terminal session tools` \
    tmux \
    fzf ripgrep \
`# Working environment tools` \
    pass \
    octave \
`# Framebuffer terminal` \
    fbterm

