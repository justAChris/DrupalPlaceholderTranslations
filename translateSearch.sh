#! /bin/bash

#########################
#
# This script searches for multiple lines in the translation file
#
# Usage: ./translateSearch.sh searchTerms translationFile outputFile
# Tested on OSX 10.10
#########################

search=$1
translate=$2
output=$3

rm $output

# Remove newlines with surronding quotes
# See http://stackoverflow.com/questions/1251999/how-can-i-replace-a-newline-n-using-sed
trans=$(sed -e ':a' -e 'N' -e '$!ba' -e 's/\"\n\"//g' $translate)

# Replace \" with "
trans=$(sed -e 's/\\\"/\"/g' <<< "$trans")
count=0

printf "Searching."

while read line;do
  printf "."
  if grep -Fq "$line" <<< "$trans" ; then
    ((count++))
    echo $line >> $3
  fi
done < $search

echo "==================================================" >> $output
echo "$count matches found in the translation file" >> $output
echo "$count matches found"

#echo $trans >> output.txt

