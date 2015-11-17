#!/bin/bash
# 2015-09-24
# 2015-11-17

source "$HOME/scripts/lib/colors.sh"

ORIG_PS1="$PS1" # store default PS1

DIR="$HOME/scripts/config"
USERNAME_FONT='\e[0;33;93m'
PS1="\[$USERNAME_FONT\]"'\u' # user
PS1="$PS1""\[$WHITE_FG\]"'@'  # @
HOSTNAME_FONT='\e[0;32m'
PS1_HOST="\[$HOSTNAME_FONT\]"'\h '
PS1_HOST_CONFIG="$DIR/ps1_host.sh"
test -f "$PS1_HOST_CONFIG" && source "$PS1_HOST_CONFIG"
PS1="$PS1""$PS1_HOST" # host<space>
ps1_reset_font
PS1="$PS1"'\[\033[01;34m\]''\w/' # current working directory<slash>
ps1_reset_font

unset USERNAME_FONT
unset HOSTNAME_FONT
unset PS1_HOST
unset DIR
