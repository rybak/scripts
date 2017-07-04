#!/bin/bash

set -u
set -e

# source for list_all_tags
# https://stackoverflow.com/questions/33275853/git-find-all-tags-reachable-from-a-commit

list_all_tags () {
    COMMIT="$1"
    git log --decorate=full --simplify-by-decoration --pretty=oneline "$COMMIT" | \
        sed -r -e 's#^[^\(]*\(([^\)]*)\).*$#\1#' \
        -e 's#,#\n#g' | \
        grep 'tag:' | \
        sed -r -e 's#[[:space:]]*tag:[[:space:]]*##'
}

if [[ $# -ne 1 ]]
then
    echo "Usage: $0 <OLD_TAG>"
    echo ""
    echo -e "\tThis script will print in diff format tags that are present in HEAD,"
    echo -e "\tbut not present in <OLD_TAG>"
    exit 1
fi

OLD_TAG="$1"

TAGS_1=/tmp/tags-diff-1
TAGS_2=/tmp/tags-diff-2
list_all_tags "$OLD_TAG" | sort > "$TAGS_1"
list_all_tags HEAD | sort > "$TAGS_2"
git diff --no-index "$TAGS_1" "$TAGS_2"
