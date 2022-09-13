#!/bin/bash

# For every English Wikipedia page in `input.txt`, prints first 20 characters of
# its wikitext

BASE_HOST=en.wikipedia.org

for i in $(cat input.txt)
do
	wikitext=$(curl -q "https://${BASE_HOST}/w/api.php?action=parse&format=json&page=${i}&prop=wikitext&formatversion=2" | jq '.parse.wikitext')
	echo -e "$i\t${wikitext:0:20}"
	sleep 3s
done
