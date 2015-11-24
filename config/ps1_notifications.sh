#!/bin/bash

source "$HOME"'/scripts/lib/colors.sh'

DIR="$HOME"'/scripts/config'
__README_SYMBOL='📖'
README_CONFIG="$DIR"'/readme.conf'
test -f "$README_CONFIG" && source "$README_CONFIG"

case "$TERM" in
xterm*|rxvt* )
    __SMILEY='☹'
    ;;
* )
    __SMILEY='('
    ;;
esac

function __sad_ps1() {
    local EXIT=$?

    local PREF="$1"
    local POST="$2"
    local SADNESS=
    local POST_NOTIFY=
    local POST_RESET=
    if [[ "$EXIT" != '0' ]]
    then
        SADNESS="$__SMILEY"
    fi
    if [[ -f 'README' || -f 'README.md' || -f 'readme.txt' || -f 'readme.md' ]]
    then
        POST_NOTIFY='\['$BLUE_FG'\]'"$__README_SYMBOL $PS_RESET_FONT"
        POST_RESET="$PS_RESET_FONT"
    fi

    local GIT_POST="${SADNESS}${POST_NOTIFY}${POST}${POST_RESET}"
    __git_ps1 "$PREF" "$GIT_POST"
}

unset DIR
unset README_CONFIG
