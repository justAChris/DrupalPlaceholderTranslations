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

grep "^- " $input | while read -r line ; do
  # Remove everything not in parenthesis
  strip=$( sed -E 's/(^|\))[^\(\)]+(\(|$)/\1\2/' <<< "$line" )
  # remove replacement values
  strip=$( sed 's/, array.*//' <<< "$strip")
  #remove first two characters ('
  strip=$( cut -c 3- <<< "$strip")
  #remove last character '
  strip=${strip%?}
  echo $strip >> $output
done
