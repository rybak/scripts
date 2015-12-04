#!/bin/bash

set -u
set -e

LIST="$1"

if [[ -r "$LIST" ]]
then
    LIST="$(readlink -f "$LIST")"
else
    echo "ERROR in if"
fi

echo "File: $LIST"
cat "$LIST"

DIR=$( cd -P "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
exec "$DIR/simple.sh" -a "$LIST"
