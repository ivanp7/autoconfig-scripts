#!/bin/sh

case $1/$2 in
    pre/*)
        # echo "Going to $2..."
        ;;
    post/*)
        # echo "Waking up from $2..."
        /usr/bin/ethtool -s $NETWORK_INTERFACE wol g
        ;;
esac

