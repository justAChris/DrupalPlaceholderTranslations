#! /bin/bash

#########################
#
# This script strips a patch to only show the lines that are removed.
# Specifically, the text found inside parenthesis only is preserved.
# Replacement array is also stripped out.
#
# Usage: ./stripHelpPatch.sh input output
# Tested on OSX 10.10
#########################

input=$1
output=$2

rm $output
rm temp.txt

while read -r "line"; do
    # Only use lines that start with - as these indicate patch deletions.
    if grep -q '^- ' <<< "$line" ; then
        # Separate cases for t('') and t("") since both are used.
        if grep -q ".*[ \.\(]t('" <<< "$line" ; then
            # Aim to retreive the string to be translated, ignoring replacement array.
            # There are occurances of \' in the patch, which should not terminate the string.
            # The most inner parenthesis attempts this:
            # (\\\'|[^'])+ Select any character except ' including when preceeded by a slash.
            strip=$( sed -E "s/.*t\('((\\\'|[^'])+)'.*/\1/" <<< "$line" )

            # Resulting string should include ! (or this shouldn't be in the patch)
            if grep -q '\!' <<< "$strip" ; then
                echo "$strip" >> temp.txt
            fi
        elif grep -q '.*[ \.\(]t("' <<< "$line" ; then
            strip=$( sed -E 's/.*t\("((\"|[^"])+)".*/\1/' <<< "$line" )
            if grep -q '\!' <<< "$strip" ; then
                echo "$strip" >> temp.txt
            fi
        fi
    fi
done < $input

# Remove dupes
# http://unix.stackexchange.com/questions/30173/how-to-remove-duplicate-lines-inside-a-text-file
# http://stackoverflow.com/questions/19039036/how-to-delete-duplicate-lines-in-a-file-awk-sed-uniq-not-working-on-my-file
awk '!x[$0]++' temp.txt > $output
