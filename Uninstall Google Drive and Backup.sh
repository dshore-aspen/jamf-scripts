#!/bin/bash

killall "Backup and Sync"
killall "Google Drive"
sleep 10


rm -rf /Applications/Backup\ and\ Sync*
rm -rf /Applications/Google\ Drive*

if {{ $4 = "n" }}; then
	echo "[SKIPPING DELETE]---- Applications have been deleted but user files will not be deleted."
	exit 0
fi

for i in /Users/* ; do
	if [ -d "${i}" ]; then
		if [ -d "${i}"/Library/Application\ Support/Google/Drive ]; then
			echo "[DELETE-PROCESS]---- Deleting GDrive from user $i"
			rm -r "${i}"/Library/Application\ Support/Google/Drive
		else
			echo "[DELETE-PROCESS]---- User $i does not have any Google Drive files"
		fi
	fi
done
	