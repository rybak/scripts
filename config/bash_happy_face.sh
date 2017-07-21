#!/bin/bash

readonly FACES=('(∩︵∩)' 'ᵒᴖᵒ' 'ಠ╭╮ಠ' '(;﹏;)')
readonly FACE=${FACES[ $RANDOM % ${#FACES[@]} ]}

case "$TERM" in
xterm*|rxvt* )
    SMILEY="${FACE}"
    ;;
* )
    SMILEY='('
    ;;
esac

function __sad_ps1() {
    local EXIT=$?

    local PREF="$1"
    local POST="$2"
    if [[ "$EXIT" != '0' ]]
    then
        SADNESS="$SMILEY"
    else
        SADNESS=''
    fi
    local GIT_POST="\n${SADNESS}${POST}"
    __git_ps1 "$PREF" "$GIT_POST"
}

