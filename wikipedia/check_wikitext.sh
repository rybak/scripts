#!/bin/bash

# For every English Wikipedia page in category `$1`, prints a bunch of wikitext
# from the start and from the end of the page.

BASE_HOST=en.wikipedia.org

if [[ $# -lt 1 ]]
then
	echo "Missing category name. E.g. 'Navigational boxes'"
	exit 1
fi
if [[ $# -lt 2 ]]
then
	echo "Missing expected template regex. E.g. '[nN]avbox'"
	exit 1
fi

category="Category:${1// /_}"
expected_template="$2"

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
	wikitext_start="$(echo ${wikitext:0:100} | grep -o '[{][{] *[^|}]*')"
	if echo "$wikitext_start" | grep -q -e "$expected_template"
	then
		:
	else
		echo "${i}"
		echo -e "\t${wikitext_start}"
		echo -e "\t${wikitext: -20}"
		echo "-------------------------"
	fi
	sleep 1s
done
