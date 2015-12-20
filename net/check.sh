#!/bin/bash

set -u
set -e

source "$HOME/scripts/lib/sound.sh"
source "$HOME/scripts/lib/colors.sh"
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
long_delay='30m'
short_delay='3m'
if [[ $# -gt 0 ]]
then
    long_delay="$1"
fi
readonly START_TIME="$(curr_time)"
while true
do
    echo "    Internet checker     "
    echo "========================="
    print_time
    if ping -c 10 ya.ru
    then
        mylog "ok"
        echo -e "$GREEN_FG"
        banner OK
        echo -e "$RESET_FONT"
        mysleep $long_delay
    else
        mylog "fail"
        echo -e "$RED_FG"
        banner FAIL
        play_sound_error
        echo -e "$RESET_FONT"
        mysleep ${short_delay}
    fi
done

