#!/bin/bash

source `dirname $0`/functions.sh

####################################################################

print_message "#### Enabling Wake-on-Lan ####"

####################################################################

initialize

####################################################################

NETWORK_INTERFACE=$(grep 'Interface=' /etc/netctl/network | cut -d'=' -f2)
echo "ExecUpPost='/usr/bin/ethtool -s $NETWORK_INTERFACE wol g'
" | sudo tee -a /etc/netctl/network
sudo netctl reenable network

echo "#!/bin/bash

case \$1/\$2 in
    pre/*)
        # echo "Going to \$2..."
        ;;
    post/*)
        # echo "Waking up from \$2..."
        /usr/bin/ethtool -s $NETWORK_INTERFACE wol g
        ;;
esac
" | sudo tee /usr/lib/systemd/system-sleep/50-reset-wol.sh
sudo chmod +x /usr/lib/systemd/system-sleep/50-reset-wol.sh

####################################################################

finish

