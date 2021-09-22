#!/bin/sh

# relies on:
# iptables -I FORWARD 1 -p tcp -d IP_ADDRESS -m limit --limit 1/min -j LOG --log-prefix "WOL_LOG:  " --log-level 7
#

#debugging
#set -xv

TARGET=$1 # local IP address of the computer to wake up
MAC=$2 # MAC address of the computer to wake up
AWAKENING_TIME=$3 # amount of time to sleep after waking attempt
shift 3 # other parameters are ports to scan (8080, 443, etc.)

log ()
{
    echo "[$(date)] $@" >> /tmp/autowakeup-$TARGET.log
}

INTERFACE=br-lan
PING_TRIES=3
PING_TIME=3
OLD=""
LOGPROG=dmesg #or logread

wake_up ()
{
    INTERFACE=$1
    TARGET=$2
    MAC=$3
    AWAKENING_TIME=$4
    PORT=$5

    LINE=$($LOGPROG | grep "WOL_LOG: .* DST=$TARGET .* DPT=$PORT" | tail -1)

    SRC1=${LINE##* SRC=}
    SRC=${SRC1%% *}

    NEW1=${LINE##* ID=}
    NEW=${NEW1%% *}

    if [ "$NEW" != "" -a "$NEW" != "$OLD" ]
    then
        if ping -qc $PING_TRIES -W $PING_TIME $TARGET > /dev/null 2>&1
        then
            log "$TARGET:$PORT was accessed by $SRC and is awoken"
            OLD=$NEW
        else
            log "$TARGET:$PORT was accessed by $SRC and is asleep"
            log "etherwake: $(etherwake -i $INTERFACE $MAC)"
            sleep $AWAKENING_TIME
        fi
    fi
}

log "                           "
log "---------------------------"
log "auto-wakeup service started"

INTERVAL=3
while sleep $INTERVAL
do
    for port in $@
    do
        wake_up $INTERFACE $TARGET $MAC $AWAKENING_TIME $port;
    done
done

