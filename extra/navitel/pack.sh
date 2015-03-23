#!/bin/bash

if [[ $# -lt 1 ]]
then
    echo "Error: name not specified"
    exit 1
else
    TAG="$1"
    filename="${TAG}.ns2"
    if [[ -f "${filename}" ]]
    then
        echo "File ${filename} already exists"
        exit 2
    else
        echo "Packing into ${filename}"
        zip --recurse-paths -0 "${filename}" * --exclude *.ns2 *.sh
        echo "Finished packing ${filename}"
    fi
fi

