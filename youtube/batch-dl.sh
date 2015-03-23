#!/bin/bash

set -u
set -e

LIST="$1"
echo "File: $LIST"
cat "$LIST"

if [[ -r "$LIST" ]]
then
    LIST="$(readlink -f "$LIST")"
else
    echo "ERROR in if"
fi
ARG="-a $LIST"
DIR=$( cd $(dirname $0) ; pwd -P )

exec "$DIR/simple.sh" "$ARG"
