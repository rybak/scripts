#!/bin/bash
# 2015-09-24
# Andrey Rybak
# this is my rendition of /etc/profile.d/git-prompt.sh

# 2015-11-17
# update for use on VM (Debian 8 with xfce)

source "$HOME/scripts/lib/colors.sh"

#PS1="$PS1"'\n'                 # new line
# Do not PS1="$PS1"'\[\033[32m\]'      # change to green

USERNAME_FONT='\e[0;33;93m'
HOSTNAME_FONT='\e[0;32m'

ORIG_PS1="$PS1" # store default PS1

PS1="\[$USERNAME_FONT\]"'\u' # user
PS1="$PS1""\[$WHITE_FG\]"'@'  # @
PS1="$PS1""\[$HOSTNAME_FONT\]"'\h ' # host<space>
ps1_reset_font
PS1="$PS1"'\[\033[01;34m\]''\w/' # current working directory<slash>
ps1_reset_font

