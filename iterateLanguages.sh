#! /bin/bash

#########################
#
# This script iterates through a set of languages and finds strings in the
# translation files.
# Languages are in an array and are the shortened language code as they appear
# in the downloadable translation file.
#
# searchFile: list of strings to search in translation files, one per line.
# download: download all translations files, defaults to true
#
# Requires cURL
#
# Usage: ./iterateLanguages.sh searchFile download
# Tested on OSX 10.10
#########################

search=$1
download=${2:-true}

filebase="drupal-8.0.0-beta15"
filepath="http://ftp.drupal.org/files/translations/8.x/drupal"

languages=( prs af sq am ar hy as ast az ms eu be bn bs bg my ca zh-hans zh-hant hr cs da nl dz en-gb eo et fo fil fi fr fy gl ka de el gu ht he hi zh-hk hu is id ga it ja jv kn kk km rw ko ku ky lo lv lt xx-lolspeak lb mk mg ml mt mi mr mfe mn ne se nb nn oc or os ps fa pl pt-br pt pt-pt pa rhg ro ru sco gd sr sd si sk sl so es sw sv gsw-berne ta ta-lk te test th bo ti tr tyv ug uk ur vi cy yi )

if [ "$download" = true ]; then
  # Create a directory to hold translation file downloads if it doesn't already exist.
  mkdir -p translationFiles
fi

mkdir -p results
for i in "${languages[@]}"
do
  :
    if [ "$download" = true ]; then
      # Check that file is found
      # http://stackoverflow.com/questions/2220301/how-to-evaluate-http-response-codes-from-bash-shell-script
      response=$(curl --write-out "%{http_code}\n" --silent --output /dev/null "$filepath/$filebase.$i.po")
      if [ "$response" -eq 200 ]; then
        curl -O "$filepath/$filebase.$i.po"
        if [ -f "$filebase.$i.po" ]; then
          mv -f "$filebase.$i.po" "translationFiles/$filebase.$i.po"
        fi
      fi
    fi

    if [ -f "translationFiles/$filebase.$i.po" ]; then
      printf "Searching $filebase.$i.po: "
      ./translationSearch.sh $search "translationFiles/$filebase.$i.po" "results/$i-output.txt"
    else
      echo "File $filebase.$i.po not found: 0 matches found"
    fi
done

echo "DONE"
