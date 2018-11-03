#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
source $SCRIPT_DIR/functions.sh

####################################################################

print_message "#### Swapping Ctrl/CapsLock keys ####"

####################################################################

initialize

####################################################################

sudo dumpkeys | head -1 | sudo tee /etc/ctrl-caps-swap.map
cat $SCRIPT_DIR/aux/ctrl-caps-swap.map | sudo tee -a /etc/ctrl-caps-swap.map

sudo cp $SCRIPT_DIR/aux/ctrl-caps-swap.service /etc/systemd/system/
sudo systemctl enable ctrl-caps-swap.service
sudo systemctl start ctrl-caps-swap.service

cp $SCRIPT_DIR/aux/.Xmodmap ./
ln -sf $(realpath .Xmodmap) $HOME/

sudo cp $SCRIPT_DIR/aux/90-reset-ctrl-caps-swap.sh /usr/lib/systemd/system-sleep/

####################################################################

finish

