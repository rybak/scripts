#!/bin/bash

youtube-dl --format bestaudio --continue --ignore-errors --no-overwrites --output '%(uploader_id)s/%(upload_date)s_%(title)s_%(id)s.%(ext)s' "$@"

