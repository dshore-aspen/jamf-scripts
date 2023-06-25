#!/bin/bash
# Version 1.1
# This script is meant to remove all traces of OneDrive
# It starts by running the ResetOneDriveAppStandalone.command
# It then hunts for all OneDrive directories and files throughout the 
# currently logged in user's folders. It is not meant to trash all files 
# for all users at this time.

echo ""
echo ""
echo ""

# Grab the currently logged in user
statUser=$(stat -f "%Su" /dev/console)
echo "Current User = $statUser"

# Declare target variables and locations
fileCount=0
declare -a deletedList=()
declare -a missedList=()
declare -a leftovers=(
/Users/$statUser/Library/Containers
/Users/$statUser/Library/Caches
/Users/$statUser/Library/Preferences
/Users/$statUser/Library/Cookies
/Users/$statUser/Library/Logs
/Users/$statUser/Library/LaunchAgents)

# Begin the hunt for files
echo ""
echo "Beginning checks now."
echo ""

# Run the reset command from within the OneDrive app.
/Applications/OneDrive.app/Contents/Resources/ResetOneDriveAppStandalone.command && echo "RESET COMMAND--- Command run successfully" || echo "RESET COMMAND--- Couldn't run command for some reason"

# Run through the locations array
for location in ${leftovers[@]} ; do
	echo "-------"
	echo "FILE CHECK--- Checking for files in $location"
	
# 	Within the current location, build an array of all target items
	if (ls $location/*OneDrive*); then
		declare -a targets=($location/*OneDrive*)
		
# 		For each target found in current location, increment the fileCount variable, attempt to delete the file
# 		If the file deletes, add it to the deletedList. If not, add it to the missedList
		for t in ${targets[@]} ;do
			fileCount=$((fileCount+1))
			echo "FILE FOUND--- $t"
			rm -r $t && echo "FILE DELETED--- $t" && deletedList+=($t) || echo "FILE NOT DELETED--- $t" && missedList+=($t)
		done
	else
	
# 		If no files found in the current location, report back, then move one.
		echo "FILE NOT FOUND--- $t"
	fi
done
echo "FILE COUNT--- Found $fileCount files so far."

# Change directory to the user's Application Support folder. Had to do this because the 
# space in the directory path messed with the arrays.
cd /Users/$statUser/Library/Application\ Support/
if (ls ./*OneDrive*); then
	for t in $(ls ./*OneDrive*); do
	fileCount=$((fileCount+1))
		t=${t%?}
		echo "FILE FOUND--- $t"
		rm -r $t && echo "FILE DELETED--- $t" && deletedList+=($t) || echo "FILE NOT DELETED--- $t" && missedList+=($t)
	done
fi

# Try deleting the OneDrive.app. Report back the results but don't update the tracking variables.
# rm -rf /Applications/OneDrive.app && echo "FILE DELETED--- OneDrive.app" || echo "FILE NOT DELETED--- OneDrive.app"

echo "FILE COUNT--- Found $fileCount files at end of search."
echo "DELETED FILE LIST--- "
for f in ${deletedList[@]}; do
	echo "$f"
done

echo "MISSED FILE LIST--- "
for f in ${missedList[@]}; do
	echo "$f"
done
