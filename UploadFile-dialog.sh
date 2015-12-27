#!/bin/bash

# UploadFile: botclases.php based MediaWiki file uploader - dialog front-end script
# 
#  (c) 2015 Davod - https://commons.wikimedia.org/wiki/User:Amitie_10g
#
#  This program is free software, and you are welcome to redistribute it under
#  certain conditions. This program comes with ABSOLUTELY NO WARRANTY.
#  see README.md and LICENSE for more information

################################################################
#                       *** WARNING ***                        #
# This script is incomplete! Any help to build a complete      #
# dialog-based form (in the same way as YAD-based) is welcome. #
################################################################

DIRECTORY=$(dialog --stdout --dselect $PWD 10 40)

i=0
while read FILE
do
    FILES[$i]="${FILE} ${FILE##*/} off"
    (( i++ ))
done < <(find "${DIRECTORY}" -maxdepth 1 -type f)

printf '%s\n' "${FILES[@]}"

IFS="|" read -r -a FILES <<< $(dialog --stdout --checklist "Select files" 30 120 20 $(printf '%s\n' "${FILES[@]}"))