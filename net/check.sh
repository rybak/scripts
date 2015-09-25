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
RED="$(tput setf 4)"
BOLD="$(tput bold)"

GREEN="$(tput setf 2)"
RESET_COLOR="$(tput sgr0)"
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
        echo $GREEN
        echo $BOLD
        banner OK
        echo $RESET_COLOR
        mysleep $long_delay
    else
        mylog "fail"
        echo $RED
        echo $BOLD
        banner FAIL
        play_sound_error
        echo $RESET_COLOR
        mysleep ${short_delay}
    fi
done

