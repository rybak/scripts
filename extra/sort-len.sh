#!/bin/sh

awk '{ print length, $0 }' | sort -n -s | cut -d" " -f2-
