#!/bin/bash

IMAGE_DIR="$HOME/Pictures/gource"
TARGET="$1"
CAPTIONS="$2"

gource "$TARGET" \
	--fullscreen \
	--start-position random --loop \
	--hide bloom,filenames,usernames --user-scale 4 \
	--seconds-per-day 1 --time-scale 1 --auto-skip-seconds 1 \
	--user-image-dir "$IMAGE_DIR" --logo "$IMAGE_DIR/logo.png" \
	--caption-file "$CAPTIONS" --caption-duration 120 --caption-size 72 \
