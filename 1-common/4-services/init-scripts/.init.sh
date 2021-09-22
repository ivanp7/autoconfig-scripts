cd ..; while [ ! -f ".init.sh" ]; do cd ..; done
. "./.init.sh"

###############################################################################

if ! check_service startup-init
then
    print_error "startup-init service is not available"
    exit 1
fi

