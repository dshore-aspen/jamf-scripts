#!/bin/bash

eulaFolder=/Users/Shared/EULA.txt
echo "folder = $eulaFolder"

statUser=$(stat -f "%Su" /dev/console)
echo "stat = $statUser"


declare -a eulaList=$(ls $eulaFolder/)
echo "list: ${eulaList[@]}"

for f in $eulaList ; do
	if [[ ! $f == *.plist ]] ; then
		mv -f $eulaFolder/$f $eulaFolder/$f.plist 	
	fi
done

for f in $eulaList ; do
	output=$(/usr/libexec/PlistBuddy $eulaFolder/$f -c "Print :User")
	if [[ $output == $statUser ]]; then
		echo "Users match."
	else
		echo "Users don't match."
	fi
done
