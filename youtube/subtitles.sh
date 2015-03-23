#!/bin/bash

set -u
set -e

DIR=$( cd $(dirname $0) ; pwd -P )

exec "$DIR/simple.sh" --write-sub --skip-download "$@"
