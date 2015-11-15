#!/bin/bash

HOTSPOT_SCREEN_NAME="hotspot"

function print_wifi_state {
    local RED="\033[1;31m"
    local GREEN="\033[32m"
    local OFF="\033[0m"
    echo -n "WiFi hotspot is $@"
    if is_wifi_on
    then
        echo -n -e "${GREEN}on"
    else
        echo -n -e "${RED}off"
    fi
    echo -e "${OFF}."
}

function is_wifi_on {
    if grep --silent "${HOTSPOT_SCREEN_NAME}" <(screen -list)
    then
        return 0
    else
        PROCESS_NAME='hostapd'
        if grep --silent "${PROCESS_NAME}" <(ps -ejH)
        then
            echo "Something's wrong. Process '${PROCESS_NAME}' is running."
            ps -ejH | grep "${PROCESS_NAME}" -C 5
        fi
        return 1
    fi
}


