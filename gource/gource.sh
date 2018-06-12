#!/bin/bash

IMAGE_DIR="$HOME/Pictures/gource"
TARGET="$1"
shift
CAPTIONS="$1"
shift
USER_SCALE="${1:-4}"
shift

RANDOM=$$   # Reseed using script's PID

# show since 80% to show more recent history
r1=$((80+${RANDOM}%20))
printf -v POSITION "0.%.2d" $r1

gource "$TARGET" "$@" \
	--fullscreen \
	--start-position "$POSITION" --loop \
	--hide bloom,filenames,usernames --user-scale "$USER_SCALE" \
	--seconds-per-day 1 --time-scale 1 --auto-skip-seconds 1 \
	--user-image-dir "$IMAGE_DIR" --logo "$IMAGE_DIR/logo.png" \
	--caption-file "$CAPTIONS" --caption-duration 30 --caption-size 64 \
