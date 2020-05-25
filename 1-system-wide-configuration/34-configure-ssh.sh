#!/bin/sh

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Configuring SSH ####"

####################################################################

check_root

####################################################################

print_message "Creating groups..."

groupadd ssh-users
groupadd sftp-users

print_message "Configuring SSH..."

SSH_PORT=62222

sed -i "s/^#Port 22/Port $SSH_PORT/" /etc/ssh/sshd_config
sed -i "s/^#PermitRootLogin .*/PermitRootLogin no/" /etc/ssh/sshd_config
sed -i "s/^#PubkeyAuthentication .*/PubkeyAuthentication yes/" /etc/ssh/sshd_config
sed -i "s/^#PasswordAuthentication .*/PasswordAuthentication no/" /etc/ssh/sshd_config
sed -i "s/^#PermitEmptyPasswords .*/PermitEmptyPasswords no/" /etc/ssh/sshd_config
sed -i "s/^#X11Forwarding .*/X11Forwarding yes/" /etc/ssh/sshd_config
sed -i "s/^#X11UseLocalhost .*/X11UseLocalhost yes/" /etc/ssh/sshd_config
sed -i "/^Subsystem.*sftp.*/ s/Subsystem/#Subsystem/" /etc/ssh/sshd_config
cat $(aux_dir)/sshd_config_tail | tee -a /etc/ssh/sshd_config

install_and_enable_service sshd

####################################################################

finish

