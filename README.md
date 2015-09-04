# DrupalPlaceholderTranslations
Scripts and results to help determine the number of translations strings touched by patch in [2560783]

Related to https://www.drupal.org/node/2560783

Tested on OSX10.10 only
Usage notes from scripts

1. stripHelpPatch.sh<br />
Script used to create helpPatchStrip.txt, which is the patch stripped down into individual lines of search text<br />
Usage: ./stripHelpPatch.sh input output

2. translateSearch.sh<br />
Searches input translation file for parsed strings from above script<br />
Usage: ./stripHelpPatch.sh searchTerms translationFile outputFile


