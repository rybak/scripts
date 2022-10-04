#!/bin/bash

# For every English Wikipedia page in category `$1`, prints a bunch of wikitext
# from the start and from the end of the page.

BASE_HOST=en.wikipedia.org

if [[ $# -lt 1 ]]
then
	echo "Missing category name"
	exit 1
fi

category="${1// /_}"

curl --silent "https://$BASE_HOST/w/api.php?action=query&generator=categorymembers&gcmtitle=Category:${category}&cllimit=max&gcmlimit=max&format=json" |
	jq --raw-output '.query.pages | map(.title)[]' |
	grep '^Template:' |
while read i
do
	escaped=${i// /_}
	URL="https://${BASE_HOST}/w/api.php?action=parse&format=json&page=${escaped}&prop=wikitext&formatversion=2" 
	wikitext=$(curl --silent "$URL" | jq --raw-output '.parse.wikitext')
	echo -e "$i"
	echo -e "\t$(echo ${wikitext:0:100} | grep -o '[{][{] *[^|}]*')"
	echo -e "\t${wikitext: -20}"
	echo "-------------------------"
	sleep 1s
done
