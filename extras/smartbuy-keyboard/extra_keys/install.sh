#!/bin/sh

cd "$(dirname "$0")"
MAP_FILE=smartbuy-keyboard.map
{ sudo dumpkeys | head -1; cat "$MAP_FILE"; } | sudo tee -a /usr/local/share/kbd/keymaps/$MAP_FILE
sudo chmod 644 /usr/local/share/kbd/keymaps/$MAP_FILE

cat xmodmap >> "$XDG_CONFIG_HOME/X11/xmodmap"

