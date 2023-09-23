#!/bin/bash

# For every English Wikipedia page in category `$1`, prints a bunch of wikitext
# from the start and from the end of the page.

BASE_HOST=en.wikipedia.org

if [[ $# -lt 1 ]]
then
	echo "Missing category name"
	exit 1
fi

category="Category:${1// /_}"

echo "Checking '$category'..."

url=$(trurl \
	--set host=$BASE_HOST --set scheme=https --set path=/w/api.php \
	--append query=action=query --append query=generator=categorymembers \
	--append query=cllimit=max --append query=gcmlimit=max \
	--append query=format=json \
	--append "query=gcmtitle=${category}" \
	)

echo "Downloading URL='$url'..."

curl "$url" |
	jq --raw-output '.query.pages | map(.title)[]' |
	grep '^Template:' |
while read i
do
	escaped=${i// /_}
	URL=$(trurl \
		--set host=$BASE_HOST --set scheme=https --set path=/w/api.php \
		--append query=action=parse --append query=format=json \
		--append query="page=${escaped}" --append query=prop=wikitext \
		--append query=formatversion=2 \
	)
	wikitext=$(curl --silent "$URL" | jq --raw-output '.parse.wikitext')
	echo -e "$i"
	echo -e "\t$(echo ${wikitext:0:100} | grep -o '[{][{] *[^|}]*')"
	echo -e "\t${wikitext: -20}"
	echo "-------------------------"
	sleep 1s
done
