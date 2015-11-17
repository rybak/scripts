#!/bin/bash
# 2015-09-24
# 2015-11-17

source "$HOME/scripts/lib/colors.sh"

ORIG_PS1="$PS1" # store default PS1

USERNAME_FONT='\e[0;33;93m'
PS1="\[$USERNAME_FONT\]"'\u' # user
PS1="$PS1""\[$WHITE_FG\]"'@'  # @
HOSTNAME_FONT='\e[0;32m'
PS1="$PS1""\[$HOSTNAME_FONT\]"'\h ' # host<space>
ps1_reset_font
PS1="$PS1"'\[\033[01;34m\]''\w/' # current working directory<slash>
ps1_reset_font

unset USERNAME_FONT
unset HOSTNAME_FONT
