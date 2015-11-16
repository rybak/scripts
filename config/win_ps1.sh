#!/bin/bash
# 2015-09-24
# Andrey Rybak
# this is my rendition of /etc/profile.d/git-prompt.sh

# 2015-11-17
# update for use on VM (Debian 8 with xfce)

source "$HOME/scripts/lib/colors.sh"
function reset_font() {
    PS1="$PS1${PS_RESET_FONT}"
}

PS1='\[\033]0;$MSYSTEM:${PWD//[^[:ascii:]]/?}\007\]' # set window title
#PS1="$PS1"'\n'                 # new line
# Do not PS1="$PS1"'\[\033[32m\]'      # change to green

USERNAME_FONT='\e[0;33;93m'
HOSTNAME_FONT='\e[0;32m'

PS1="$PS1""\[$USERNAME_FONT\]"'\u' # user
PS1="$PS1""\[$WHITE\]"'@'  # @
PS1="$PS1""\[$HOSTNAME_FONT\]"'\h ' # host<space>
reset_font
# Do not PS1="$PS1"'\[\033[35m\]' # change to purple
# Do not PS1="$PS1"'$MSYSTEM ' # show MSYSTEM

PS1="$PS1"'\[\033[01;34m\]'       # change to directory color

PS1="$PS1"'\w/'                # current working directory<slash>
reset_font

