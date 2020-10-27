#!/bin/sh

for keymap in $(find /usr/local/share/kbd/keymaps/ -type f)
do
    loadkeys "$keymap"
done

