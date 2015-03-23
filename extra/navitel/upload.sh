#!/bin/bash

DEST="/media/$(whoami)/MICROSD16GB/NavitelContent/Skins/"

for i in *.ns2
do
    filename="${i}"
    echo "Copying ${filename}"
    cp --no-clobber "${filename}" "${DEST}"
done

