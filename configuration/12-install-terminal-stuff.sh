#!/bin/bash

SCRIPT_DIR=$(realpath `dirname $0`)
. $(realpath $SCRIPT_DIR/..)/functions.sh

####################################################################

print_message "#### Installing terminal stuff ####"

####################################################################

check_user

####################################################################

print_message "Installing when, todotxt..."
install_packages when todotxt

####################################################################

print_message "Installing basic game collection..."
install_packages cgames bs

print_message "Installing terminal picture viewer and media player..."
install_packages pixterm-git termplay 

print_message "Installing other useful programs..."
install_packages lolcat fortune-mod sl cmatrix ponysay nyancat

####################################################################

finish

