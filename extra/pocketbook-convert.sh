#!/usr/bin/env bash

if [[ $# -lt 1 ]]
then
	echo "Specify filename"
	exit 1
fi

while [[ $# -gt 0 ]]
do
	from="$1"
	to="${1%.*}.bmp"
	shift
	echo "'$from' -> '$to'"
	convert "$from" -type Grayscale -colorspace Gray -colors 255 -compress None BMP3:"$to"
done
