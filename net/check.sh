#!/bin/bash

set -u
set -e

source "$HOME/scripts/lib/sound.sh"
function curr_time
{
    date +%FT%R
}
function print_time
{
    echo "Started at $START_TIME"
    echo "Current time is $(curr_time)"
}

function mysleep
{
    echo "sleeping for $1"
    sleep $1
}

CHECK_LOG='/tmp/internet-check'

function mylog
{
    echo "$(curr_time) : $@" >> "${CHECK_LOG}"
}
RED="\e[0;33m"
GREEN="\e[0;32m"
RESET_COLOR="\e[0m"
long_delay='30m'
short_delay='3m'
readonly START_TIME="$(curr_time)"
while true
do
    echo "    Internet checker     "
    echo "========================="
    print_time
    if ping -c 10 ya.ru
    then
        mylog "ok"
        echo -e "$GREEN"
        banner OK
        echo -e "$RESET_COLOR"
        mysleep $long_delay
    else
        mylog "fail"
        echo "$RED"
        banner FAIL
        play_sound_error
        echo "$RESET_COLOR"
        mysleep ${short_delay}
    fi
done

