#!/bin/bash

source "$HOME/scripts/lib/colors.sh"

DIR="$HOME/scripts/config"
__README_SYMBOL='☡'
__README_COLOR="$BRIGHT_FG$MAGENTA_FG"
README_CONFIG="$DIR/readme.conf"
test -f "$README_CONFIG" && source "$README_CONFIG"

case "$TERM" in
xterm*|rxvt* )
    __SMILEY='☹ '
    ;;
* )
    __SMILEY='('
	__README_SYMBOL='z'
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
	if [[ -n $(find -maxdepth 1 -iname '*README*' 2>/dev/null) ]]
    then
        POST_NOTIFY='\['$__README_COLOR'\]'"$__README_SYMBOL $PS_RESET_FONT"
        POST_RESET="$PS_RESET_FONT"
    fi

    local GIT_POST="${SADNESS}${POST_NOTIFY}${POST}${POST_RESET}"
    __git_ps1 "$PREF" "$GIT_POST"
}

unset DIR
unset README_CONFIG
