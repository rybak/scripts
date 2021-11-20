#!/bin/bash

#
# This script shows a summary of T0D0 files in Taskell format.
# Modification date, part of the path to the file, and the first task in the
# "active" column ("Doing" or "In dev") is displayed for every file.
#
# Files are listed by the user manually in the configuration file.
#

set -e
set -u

die () {
	>&2 echo "${1:-Error occurred}"
	exit 1
}

readonly CONFIG=${XDG_CONFIG_HOME:-$HOME/.config/summarykel}
if ! test -r "$CONFIG"
then
	touch "$CONFIG" || die "Can't write to '$CONFIG'"
fi

if test "$(stat --format='%s' "$CONFIG")" = 0
then
	echo "Configuration file '$CONFIG' is empty"
	echo "Add paths to taskell files to '$CONFIG'"
	die
fi

add_file_to_config () {
	local f="$1"
	if ! test -r "$f"
	then
		die "Cannot read file '$f'"
	fi
	f=$(readlink -f "$f")
	echo "$f" >>"$CONFIG" || die "Cannot write to '$CONFIG'"
	echo "Added '$f' to the config"
	exit 0
}

if test "x${1:-x}" = "xadd"
then
	shift
	add_file_to_config "$1"
fi

# readonly TODAY=$(date -Idate)
source ~/scripts/lib/colors.sh

list_one_file () {
	local file="$1"
	local tmp="${file%/*/*}"
	local path_part="${file:$((${#tmp} + 1))}"
	local timestamp=$(stat --format=%y "$line")
	local d=${timestamp:0:10}
	local todo=$(grep -i -E -A 2 '## (in dev|doing)' "$file" | tail -n 1)

	echo -e "${CYAN_FG}${d}${RESET_FONT} -" \
		"${MAGENTA_FG}${path_part}${RESET_FONT}" \
		"\t${BRIGHT_FG}${todo}${RESET_FONT}"
}

cat "$CONFIG" | while read line
do
	list_one_file "$line"
done | sort
