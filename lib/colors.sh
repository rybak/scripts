#!/bin/bash

BLACK_FG="$(tput setaf 0)"
RED_FG="$(tput setaf 1)"
GREEN_FG="$(tput setaf 2)"
YELLOW_FG="$(tput setaf 3)"
BLUE_FG="$(tput setaf 4)"
MAGENTA_FG="$(tput setaf 5)"
CYAN_FG="$(tput setaf 6)"
WHITE_FG="$(tput setaf 7)"

BLACK="$BLACK_FG"
RED="$RED_FG"
GREEN="$GREEN_FG"
YELLOW="$YELLOW_FG"
BLUE="$BLUE_FG"
MAGENTA="$MAGENTA_FG"
CYAN="$CYAN_FG"
WHITE="$WHITE_FG"

RESET_FONT="\e[0m"
BRIGHT_FG="\e[1m"
HIGHLIGHT_FONT="\e[4m"

PS_RESET_FONT='\[\e[0m\]'

function ps1_reset_font() {
    PS1="$PS1${PS_RESET_FONT}"
}
