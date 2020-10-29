#!/bin/bash

if [[ $# -lt 1 ]]
then
	echo "Missing iso file parameter"
	exit 1
fi
sudo mount -o loop,ro -t iso9660 "${@}" /mnt/iso/
