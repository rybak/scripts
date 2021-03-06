#!/bin/bash

set -u
set -e

source "$HOME/scripts/lib/sound.sh"
function curr_time {
    date +%FT%R
}

readonly START_TIME="$(curr_time)"

function print_time {
    echo "Directory = $DIR"
    echo "Started at $START_TIME"
    echo "Current time is $(curr_time)"
    echo "Cycle #$i"
}

function print_log {
    FILE="$1"
    shift
    echo "$@" | tee --append "$FILE"
}

function print_succ {
    print_log "$succ_file" "$@"
}

function print_fail {
    print_log "$fail_file" "$@"
}

SUFF=_INTERNET_DOWN
rm -rf "/tmp/*${SUFF}"

DIR="$(mktemp --directory --suffix=_${START_TIME}${SUFF})"
fail_file="$DIR/${START_TIME}_FAIL"
succ_file="$DIR/${START_TIME}_SUCCESS"
stat_file="$DIR/${START_TIME}_STAT"

# script `net` should be in same folder
THIS_DIR="$( cd -P "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )"
NET_SCRIPT="${THIS_DIR}/net"

i=0
while true
do
    print_time
    let i=i+1
    echo "Restarting pppoe"
    "${NET_SCRIPT}" eth0
    sleep 20s
    "${NET_SCRIPT}" restart | tee "$stat_file"
    sleep 20s
    echo "Pinging ya.ru"
    if ping -c 4 ya.ru
    then
        print_succ "ping success : $?"
        print_succ "exiting"
        rm -f "$fail_file"
        print_fail "success"
        play_sound_success
        play_sound_ok
        break
    else
        print_fail "ping fail : $?"
        print_succ "fail"
    fi
    echo "Sleeping. --- Cycle #$i"
    print_time
    sleep 10m
done

