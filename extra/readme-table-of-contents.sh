# This script parses Markdown file README.md and outputs a table of contents in
# form of a nested list with clickable links. Generated URLs are GitHub
# compatible.

# grep finds all lines which look like Markdown header syntax
# sed commands does the following:
# - replace headings with list syntax
# - duplicate the text and wrap in link syntax
# - replace spaces with dashes (up to four spaces supported)
grep ^# README.md | sed -e 's/###/    -/' -e 's/##/  -/' -e 's/#/-/' -e 's/[-] \(.*\)$/- [\1](#\L\1)/' -e 's/(\(.*\) \(.*\))/(\1-\2)/'  -e 's/(\(.*\) \(.*\))/(\1-\2)/' -e 's/(\(.*\) \(.*\))/(\1-\2)/' -e 's/(\(.*\) \(.*\))/(\1-\2)/'

