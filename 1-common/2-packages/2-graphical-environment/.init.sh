cd ..; while [ ! -f ".init.sh" ]; do cd ..; done
. "./.init.sh"

###############################################################################

if ! check_packages $AUR_HELPER
then
    print_error "AUR helper is not available"
    exit 1
fi

if ! check_packages xorg-server
then
    print_error "X server is not installed"
    exit 1
fi

