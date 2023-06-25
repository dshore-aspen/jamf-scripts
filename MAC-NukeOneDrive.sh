#!/bin/bash
# Version 1.0
# This script is meant to remove all traces of OneDrive
# It starts by running the ResetOneDriveAppStandalone.command
# It then hunts for all OneDrive directories and files throughout the 
# user's folders.


/Applications/OneDrive.app/Contents/Resources/ResetOneDriveAppStandalone.command
fileCount=0
declare -a deletedList=()
declare -a leftovers=(
~/Library/Containers
~/Library/Caches
~/Library/Preferences
~/Library/Cookies
~/Library/Logs
~/Library/LaunchAgents)

echo ""
echo ""
echo ""
echo "Beginning checks now."
for location in ${leftovers[@]} ; do
	echo "-------"
	echo "FILE CHECK--- Checking for files in $location"
	if (ls $location/*OneDrive*); then
		declare -a targets=($location/*OneDrive*)
		for t in ${targets[@]} ;do
			fileCount=$((fileCount+1))
			echo "FILE FOUND--- $t"
			rm -r $t && echo "FILE DELETED--- $t" && deletedList+=($t) || echo "FILE NOT DELETED--- $t"
		done
	else
		echo "FILE NOT FOUND--- $t"
	fi
done
echo "FILE COUNT--- Found $fileCount files so far."

cd ~/Library/Application\ Support/
if (ls ./*OneDrive*); then
	for t in $(ls ./*OneDrive*); do
	fileCount=$((fileCount+1))
		t=${t%?}
		echo "FILE FOUND--- $t"
		rm -r $t && echo "FILE DELETED--- $t" && deletedList+=($t) || echo "FILE NOT DELETED--- $t"
	done
fi
echo "FILE COUNT--- Found $fileCount files at end of search."
echo "DELETED FILE LIST--- ${deletedList[@]}"
