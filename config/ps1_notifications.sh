#!/bin/bash

source "$HOME/scripts/lib/colors.sh"


__TOP_BRACKET="\[\e[2m\]┌─"
__BOTTOM_BRACKET="\\[\\e[2m\\]└─"
# set up simple PS1
PS1=
ps1_reset_font
USERNAME_FONT='\033[0;33;93m'
HOSTNAME_FONT='\033[0;32m'
PS1="$__BRACKET_COLOR${__TOP_BRACKET}$PS1\[$USERNAME_FONT\]"'\u' # user
PS1="$PS1\[$WHITE\]"'@'  # @
PS1="$PS1\[$HOSTNAME_FONT\]"'\h' # host
ps1_reset_font

PS1="${PS1}\[\033[01;34m\]" # change to directory color
PS1="$PS1"'\w'                # current working directory
ps1_reset_font

__README_COLOR="$DIM_FG$MAGENTA_FG"

# TODO double check the function of README_CONFIG
README_CONFIG="$HOME/scripts/config/readme.conf"
test -f "$README_CONFIG" && source "$README_CONFIG"

case "$TERM" in
xterm*|rxvt* )
	__SMILEY='☹ '
	__README_SYMBOL='☡'
    ;;
* )
	__SMILEY='('
	__README_SYMBOL='z'
    ;;
esac

function __custom_ps1() {
	local EXIT=$?

	local PREF="$1"
	local POST="$2"
	local SADNESS=
	local NOTIFY=
	local POST_RESET=
	if [[ "$EXIT" != '0' ]]
	then
		SADNESS="$__SMILEY"
	fi
	if [[ -n $(find -maxdepth 1 -iname '*README*' 2>/dev/null) ]]
	then
		NOTIFY='\['$__README_COLOR'\]'"$__README_SYMBOL $PS_RESET_FONT" POST_RESET="$PS_RESET_FONT"
	fi

	local GIT_POST="${NOTIFY}\n${SADNESS}${POST}${POST_RESET}"
	__git_ps1 "$PREF" "$GIT_POST"
}


if true
then
	# "if" is for debug
	PROMPT_COMMAND="__custom_ps1 '$PS1' '$__BOTTOM_BRACKET$PS_RESET_FONT\\\$ '"
else
	PROMPT_COMMAND="__git_ps1 '$PS1' '$NORMAL\n${__BOTTOM_BRACKET}\\\$ '"
fi

unset README_CONFIG

