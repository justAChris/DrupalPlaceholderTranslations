# DrupalPlaceholderTranslations
Scripts and results to help determine the number of translations strings touched by patch in [2560783]

Related to https://www.drupal.org/node/2560783

Tested on OSX10.10 only<br />
Usage notes from scripts

1. stripHelpPatch.sh<br />
Script used to create helpPatchStrip.txt, which is the patch stripped down into individual lines of search text<br />
Usage: ./stripHelpPatch.sh input output<br />
Example: ./stripHelpPatch.sh replace_placeholder-2560783-21.patch helpPatchStrip.txt<br />
input is the patch file, output will be used in following script (searchTerms)

2. translateSearch.sh<br />
Searches input translation file for parsed strings from above script<br />
Usage: ./translateSearch.sh searchTerms translationFile outputFile<br/>
Example: ./translateSearch.sh helpPatchStrip.txt drupal-8.0.0-beta14.uk.po ukrainianSearch.txt<br />
Where translationFile is downloaded from https://localize.drupal.org/translate/languages/uk (for example)

Updated 09/05/2015:<br />
Added wholePatchStrip.txt, which is a parsed version of the larger patch where the hook_help originated.

