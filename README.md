# DrupalPlaceholderTranslations
Scripts and results to help determine the number of translations strings touched by all children of https://www.drupal.org/node/2506427

Tested on OSX10.10 only<br />
Usage notes from scripts

1. iterateLanguages.sh<br />
This script iterates through a set of languages and finds strings in the translation files.<br />
Usage: ./iterateLanguages.sh searchFile download<br />
Example: ./iterateLanguages.sh translated-strings-original.txt true

2. translationSearch.sh<br />
Searches input translation file for parsed strings from above script<br />
Usage: ./translateSearch.sh searchTerms translationFile outputFile<br/>
Example: ./translateSearch.sh helpPatchStrip.txt drupal-8.0.0-beta14.uk.po ukrainianSearch.txt<br />
Where translationFile is downloaded from https://localize.drupal.org/translate/languages/uk (for example)

Additionally,
stripHelpPatch.sh<br />
This script strips a patch to only show the lines that are removed and in t()<br />
Usage: ./stripHelpPatch.sh input output<br />
Example: ./stripHelpPatch.sh 2560783-83.patch helpPatchStrip.txt<br />
input is the patch file, output will be used in following script (searchTerms)

Updated 09/05/2015:<br />
Added wholePatchStrip.txt, which is a parsed version of the larger patch where the hook_help originated.

