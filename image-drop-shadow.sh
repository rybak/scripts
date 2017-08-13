#!/bin/bash

pathname="$1"
noext="${pathname%.*}"

convert $pathname -trim \
        \( -clone 0 -background black -shadow 50x5 \) \
        -reverse -background none -layers merge +repage "${noext}-shadow.png"
