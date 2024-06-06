#!/bin/bash

set -u
set -e

source "$HOME/scripts/lib/sound.sh"

function my_notify {
    notify-send --icon "$ICON" --urgency $1 "$TITLE" "$2"
}

TITLE="yt-dlp"
DIR=$(dirname "$0")
ICON="$DIR/youtube-logo.png"

function print_time {
    echo -n "Time $1 : "
    date --iso-8601=seconds
}

print_time 'started'
echo "Downloading to the folder '$PWD'"
if ! yt-dlp --restrict-filenames \
    --continue --ignore-errors --no-overwrites \
    --output '%(uploader_id)s/%(upload_date)s_%(title)s.%(ext)s' \
    "$@"
then
    my_notify critical "Error during download."
    print_time 'of the error'
    play_sound_error
    exit 1
fi

print_time 'ended  '

my_notify normal "Download finished."

play_sound_ok

echo "success"
exit 0

