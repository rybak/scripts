#!/bin/bash

while [[ $# -gt 0 ]]
do
	file="$1"
	shift
	to="${file%.*}.jpg"
	echo "'$file' -> '$to'"

	convert "$file" "$to"
	kioclient5 move "$file" trash:/
	echo "	'$file' was moved to trash"
done
