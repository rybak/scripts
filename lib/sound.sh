#!/bin/bash

DEFAULT_VOLUME=50
OK_SOUND='/usr/share/psi-plus/sound/ft_complete.wav'
COMPLETE_SOUND='/usr/share/sounds/freedesktop/stereo/complete.oga'
ERROR_SOUND='/usr/share/psi-plus/sound/attention.wav'
BING_SOUND='/usr/share/psi-plus/sound/chess_move.wav'

function play_sound {
    file="$1"
    volume=${2:-$DEFAULT_VOLUME}
    mplayer -quiet -msglevel all=-1 -volume "$volume" "$file" 2> /dev/null
}

function play_sound_ok {
    play_sound "$OK_SOUND" '40'
}

function play_sound_success {
    play_sound "$COMPLETE_SOUND" '70'
}

function play_sound_error {
    play_sound "$ERROR_SOUND" '70'
}

function play_sound_bing {
    play_sound "$BING_SOUND" '30'
}
