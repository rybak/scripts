#!/bin/bash

# Script to compare lists of tests run on TeamCity

set -u
set -e

extract_tests () {
	cut -d, -f2 "$1" | sort
}

readonly FIRST="$1"
readonly SECOND="$2"

readonly FIRST_TESTS="/tmp/$FIRST.sorted"
readonly SECOND_TESTS="/tmp/$SECOND.sorted"

extract_tests "$FIRST" >"$FIRST_TESTS"
extract_tests "$SECOND" >"$SECOND_TESTS"

git diff --no-index --color-words='[A-Za-z]' "$FIRST_TESTS" "$SECOND_TESTS"

rm "$FIRST_TESTS"
rm "$SECOND_TESTS"
