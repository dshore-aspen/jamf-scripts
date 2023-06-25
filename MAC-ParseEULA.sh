#!/bin/bash

eulaFolder=/Users/Shared/EULA.txt
if [[ ! -z $5 ]]; then
	eulaFolder=$5
fi

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
		echo "<result>EULA SIGNED</result>"
		exit
	fi
done

echo "<result>EULA NOT SIGNED</result>"
exit