#!/bin/sh

case $1/$2 in
    pre/*)
        # echo "Going to $2..."
        ;;
    post/*)
        # echo "Waking up from $2..."
        /usr/bin/sleep 5
        /usr/bin/systemctl start ctrl-caps-swap.service
        ;;
esac

