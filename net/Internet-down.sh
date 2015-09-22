#!/bin/bash

set -u
set -e

source "$HOME/scripts/lib/sound.sh"
function curr_time {
    date +%R
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

i=0;
while true;
do
    print_time
    let i=i+1
    echo "Restarting pppoe"
    r-net restart | tee "$stat_file"
    sleep 10s
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
    sleep 30s
done

