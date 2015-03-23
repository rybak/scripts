#!/bin/bash

./pack.sh "$1"
# TODO make better grep pattern to match MICROSD

if mount | grep '07D6-0003'
then
    ./upload.sh
    ./unmount.sh
else
    echo "No navigator connected"
    exit 1
fi

