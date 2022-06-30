#!/bin/bash

set -u
set -e

source "$HOME/scripts/lib/sound.sh"

function my_notify {
    notify-send --icon "$ICON" --urgency $1 "$TITLE" "$2"
}

CONFIG="$HOME/.config/youtube/youtuberc"
CURDIR=$(pwd -P) # $(pwd --physical) — bash BUILTIN command `pwd` does not support long options
TITLE="yt-dlp"
DIR=$(dirname "$0")
ICON="$DIR/youtube-logo.png"

if [[ -r "$CONFIG" ]]
then
    source "$CONFIG"
else
    echo "Error: No config at '$CONFIG'. Closing."
    exit 1
fi

if ! grep --fixed-strings --line-regexp --quiet "$CURDIR" "$DIRS_LIST"
then
    cd -P "$DEFAULT"
fi

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

