
USERNAME_FONT='\e[0;33;93m'
PS1='${debian_chroot:+($debian_chroot)}\['"$USERNAME_FONT"'\]\u\[\e[0m\]@\[\e[0;35m\]\h\[\e[00m\]:\[\e['"$DIR_FONT"'m\]\w\[\e[00m\]'
unset USERNAME_FONT
