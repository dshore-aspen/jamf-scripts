#!/bin/bash


# Process generated from this article: https://helpx.adobe.com/creative-cloud/kb/cc-cleaner-tool-installation-problems.html

adobeProcesses=(
"Creative Cloud" 	
"CCXProcess"		
"CCLibrary"			
"CoreSync helper"	
"Adobe IPC Broker"	
"armsvc"			
"AGS Service"		
"Adobe Desktop Service"	
"Core Sync"			
)

for i in ${!adobeProcesses[@]};
do
	process="${adobeProcesses[i]}"
	killall $process && echo "[KILL] --- $process killed " || echo "[KILL] --- $process wasn't running"
done


url="https://swupmf.adobe.com/webfeed/CleanerTool/mac/AdobeCreativeCloudCleanerTool.dmg"
dmgfile="AdobeCreativeCloudCleanerTool.dmg"
user=`ls -l /dev/console | cut -d " " -f 4`

# Download All the Things
/usr/bin/curl -k -o /tmp/$dmgfile $url && "[LOG] --- Downloading the uninstaller from Adobe's servers" || echo "[LOG] --- Could not download Adobe's uninstaller"

/usr/bin/hdiutil attach /tmp/$dmgfile -nobrowse -quiet && "[LOG] --- Mounting dmg file." || echo "[LOG] --- Could not mount dmg file"

# Run the thing. 

/Volumes/CleanerTool/Adobe\ Creative\ Cloud\ Cleaner\ Tool.app/Contents/MacOS/Adobe\ Creative\ Cloud\ Cleaner\ Tool removeAll=ALL && "[LOG] --- Running uninstaller script" || echo "[LOG] --- Could not run the uninstaller script"


# Cleanup Tasks
/bin/echo "[LOG] --- Unmounting installer disk image."
/usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "CleanerTool" | awk '{print $1}') -quiet
/bin/echo "[LOG] --- Deleting temp files."
rm -fv /tmp/$dmgfile
/bin/sleep 3
/bin/echo "[LOG] --- Finished."