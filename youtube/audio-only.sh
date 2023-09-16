#!/bin/bash

# --restrict-filenames is to avoid weird Unicode causing issues with file
# transfers to other filesystems and such
yt-dlp --continue --ignore-errors --no-overwrites \
	--format bestaudio --extract-audio --audio-format opus \
	--output '%(uploader_id)s/%(upload_date)s_%(title)s_%(id)s.%(ext)s' \
	--restrict-filenames \
	"$@"

