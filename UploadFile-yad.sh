#!/bin/bash

# UploadFile: botclases.php based MediaWiki file uploader - YAD front-end script
# 
#  (c) 2015 Davod - https://commons.wikimedia.org/wiki/User:Amitie_10g
#
#  This program is free software, and you are welcome to redistribute it under
#  certain conditions. This program comes with ABSOLUTELY NO WARRANTY.
#  see README.md and LICENSE for more information

if [ -z "$@" ]; then
	IFS='|' read -r -a FILES <<< `yad --width=800 --height=600 --file-selection --title="Select files" --multiple --item-separator=';'`
else
	IFS=' ' read -r -a FILES <<< $@
fi

if [ -z "$FILES" ]; then
	yad --image "dialog-info" --title "Cancelled" --button=gtk-ok:1 --text "Upload cancelled." --kill-parent
fi

# You can add your username as a Wiki link (eg. [[User:Example|Example]]) (as above, DON'T use any space!)
AUTHOR="[[User:Amitie 10g|Davod]]"

# Bellow the licenses allowed. Categories can be separated with "!!" (DON'T add any spaces! replace them with underscore)
LICENSES="{{Free_screenshot|GPLv3}}!{{Free_screenshot|GPLv2+}}!{{Free_screenshot|GPLv2}}!{{Free_screenshot|BSD}}!{{Free_screenshot|MIT}}!{{Free_screenshot|Mozilla-Debian_MPL}}!{{Free_screenshot|MPLv2}}!{{Free_screenshot|MPL}}!!{{PD-art|PD-old-100}}!{{PD-scan|PD-old-100}}!{{PD-art|PD-old-70}}!{{PD-scan|PD-old-70}}!{{PD-art|PD-US-1923}}!{{PD-scan|PD-US-1923}}!!{{PD-self}}!!{{CC-BY-4.0}}!{{CC-BY-3.0}}!{{CC-BY-2.5}}!{{CC-BY-2.1}}!{{CC-BY-2.0}}!{{CC-BY-1.0}}!!{{CC-BY-2.5}}!{{CC-BY-2.2}}!{{CC-BY-2.0}}"

printf $FILES

i=0;
for FILENAME in "${FILES[@]}"
do

	# For the moment, YAD does not resize the image in form; big images
	# will render the form almost unusable.  There is a  workarround to
	# disable the preview, and provide a button to get a preview.
	if [ "$1" != "--no-preview" ]; then
		PREVIEW="--image=${FILENAME}"
	fi

	LIST[$i]="`yad --width=800 --height=600 --title='Enter information' --text='Please enter the file information' \
	${PREVIEW} \
	--button="Preview:exo-open --launch FileManager "${FILENAME}"" \
	--button=gtk-cancel:1 \
	--button=gtk-ok:0 \
	--form --date-format='%Y-%m-%d' --separator=';' --quoted-output \
	--field='Filename':RO "${FILENAME}" \
	--field='Pagename' "${FILENAME##*/}" \
	--field='Description:':TXT '' \
	--field='Date':DT "{{subst:#time:Y-m-d}}" \
	--field='Source' '{{own}}' \
	--field='Author' "${AUTHOR}" \
	--field='Other info' '' \
	--field='License:':CBE "{$LICENSES}" \
	--field='Categories'`"

	FILELIST="$FILELIST*${FILENAME##*/}
" # Don-t remove this quote from this position!

	(( i++ ))
done

if [ -z "`printf '%s\n' "${LIST[@]}"`" ]; then
	yad --image "dialog-info" --title "Cancelled" --button=gtk-ok:1 --text "Upload cancelled." --kill-parent
fi

if printf '%s\n' "${FILELIST[@]}" \
"Continue?" | yad --text-info --title="Confirm upload" --text="The following files will be uploaded:" --button=gtk-no:1 --button=gtk-yes:0; then
	# Just a workarround to get the output by redirecting to a temp file, due almost any
	# attemp to pass the output to a variable and display in result does not work with YAD
	TMPFILE="/tmp/results_`echo $RANDOM | sha1sum`"
	`printf '%s\n' "${LIST[@]}" | ./UploadFile.sh --filelist=stdin > "${TMPFILE:0:40}"` | yad --width=400 --title="Upload in progress..." --progress --pulsate --auto-kill --auto-close --button="gtk-cancel:1"
else
	yad --image "dialog-info" --title "Cancelled" --button=gtk-ok:1 --text "Upload cancelled." --kill-parent
fi

# Get the results from the file
RESULTS=`cat ${TMPFILE:0:40}`
rm ${TMPFILE:0:40}

# Output the results to YAD
printf '%s\n' "${RESULTS}" | yad --width=800 --height=600 --title="Upload results" --text-info --auto-kill --button="gtk-close:1"