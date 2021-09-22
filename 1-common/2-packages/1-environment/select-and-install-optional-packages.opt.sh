#!/bin/sh

SCRIPT_NAME="$(basename "$0")"
cd -- "$(dirname "$0")"
SCRIPT_DIR="$PWD"

SCRIPT_TITLE="Select and install optional packages"
: ${AUTOCONFIG_SELF_LOGGING:=deferred}
. "./.init.sh"

####################################################################

choose_packages_and_start_self_logging \
`# Filesystems support` \
    encfs "Encrypted filesystem in user-space" on \
    dosfstools "DOS filesystem utilities" off \
    ntfs-3g "NTFS filesystem driver and utilities" off \
`# Hardware management tools` \
    tlp "Linux Advanced Power Management" off \
    tlp-runit "Runit service script for tlp" off \
    cpupower "Linux kernel tool to examine and tune power saving related features of your processor" off \
    usb_modeswitch "Activating switchable USB devices on Linux" on \
`# System state monitoring and control tools` \
    glances "CLI curses-based monitoring tool" off \
    powertop "A tool to diagnose issues with power consumption and power management" off \
`# Basic development, programming and debugging tools` \
    inetutils "A collection of common network programs" on \
`# Terminal session tools` \
    screen "Full-screen window manager that multiplexes a physical terminal" on \
`# Mouse support` \
    gpm "A mouse server for the console and xterm" off \
    gpm-runit "runit service scripts for gpm" off \
`# Work environment tools` \
    when "A simple commandline personal calendar program" on \
    w3m "Text-based Web browser as well as pager" on \
`# Dictionaries` \
    sdcv "StarDict Console Version" off \
    stardict-full-eng-rus "Large english-russian dictionary for Stardict" off \
    stardict-full-rus-eng "Large russian-english dictionary for Stardict" off \
    stardict-slang-eng-rus "English-Russian slang dictionary" off \
    stardict-computer-ru "English-Russian dictionary of computer terms for StarDict" off \
`# Media tools` \
    beep "Advanced PC speaker beeping program" on \
    alsa-utils "Advanced Linux Sound Architecture - Utilities" on \
    pulseaudio "A featureful, general-purpose sound server" on \
    mpv "a free, open source, and cross-platform media player" on \
    fbv "FrameBuffer image viewer" on \
    poppler "PDF rendering library based on xpdf 3.0" on \
    youtube-dl "A command-line program to download videos from YouTube.com and a few more sites" off \
`# Games and miscellaneous stuff` \
    cgames "Collection of three ncurses games: csokoban (sokoban), cmines (minesweeper) and cblocks (sliding-block puzzles)" off \
    bs "The classic game of Battleships against the computer" off \
    tty-clock "Digital clock in ncurses" on \
    sl "Steam Locomotive runs across your terminal when you type 'sl' as you meant to type 'ls'" on \
    cmatrix "A curses-based scrolling 'Matrix'-like screen" off \
    nyancat "Nyancat rendered in your terminal" off \
    lolcat "Okay, no unicorns. But rainbows!!" on \
    ponysay "cowsay reimplemention for ponies" off \
    fortune-mod "The Fortune Cookie Program from BSD games" off \
    fortune-mod-ru "A collection of cookie files for fortune-mod in Russian" off

install_packages $AUTOCONFIG_CHOSEN_PACKAGES

