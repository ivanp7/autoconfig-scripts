#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring SSH ####"

####################################################################

initialize

####################################################################

print_message "Creating groups..."

sudo groupadd ssh-users
sudo groupadd sftp-users

print_message "Configuring SSH..."

sudo sed -i "s/^#Port 22/Port 62222/" /etc/ssh/sshd_config
sudo sed -i "s/^#PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
sudo sed -i "s/^#PubkeyAuthentication .*/PubkeyAuthentication yes/" /etc/ssh/sshd_config
sudo sed -i "s/^#PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config
sudo sed -i "s/^#PermitEmptyPasswords .*/PermitEmptyPasswords no/" /etc/ssh/sshd_config
sudo sed -i "/^Subsystem.*sftp.*/ s/Subsystem/#Subsystem/" /etc/ssh/sshd_config

cat $SCRIPT_DIR/aux/5/sshd_config_tail | sudo tee -a /etc/ssh/sshd_config
sudo install -Dm 644 $SCRIPT_DIR/aux/5/override.conf /etc/systemd/system/sshd.socket.d/

sudo systemctl enable --now sshd.socket

####################################################################

finish

