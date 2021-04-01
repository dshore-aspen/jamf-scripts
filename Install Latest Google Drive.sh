#!/bin/sh
################################################################################
#  ABOUT THIS PROGRAM
#
#  NAME
#    InstallGoogleFileStream.sh
#
#  SYNOPSIS
#    ./InstallGoogleFileStream.sh
#
#  DESCRIPTION
#    Downloads latest version of File Stream from Google's servers and installs
#    it for the current user. If Google Drive is detected, the application is
#    stopped and deleted, but user data is not. If data is found, a
#    notification is displayed through JAMF helper.
#
#  HISTORY
#    Version 1.0
#      Brian Monroe, 18.10.2017
#       updated for Google Drive v45
################################################################################
# Set some Variables
SupportContactInfo="your system administrator."
dmgfile="GoogleDrive.dmg"
logfile="/Library/Logs/GoogleDrive.log"
url="https://dl.google.com/drive-file-stream/GoogleDrive.dmg"
user=`ls -l /dev/console | cut -d " " -f 4`

# Say what we are doing
/bin/echo "`date`: Installing latest version of File Stream for $user..." >> ${logfile}

# Download All the Things
/bin/echo "`date`: Downloading the latest version of Google Drive from Google's servers" >> ${logfile}
/usr/bin/curl -k -o /tmp/$dmgfile $url
/bin/echo "`date`: Mounting dmg file." >> ${logfile}
/usr/bin/hdiutil attach /tmp/$dmgfile -nobrowse -quiet

# Install the things. 
/bin/echo "`date`: Installing pkg" >> ${logfile}
/usr/sbin/installer -pkg /Volumes/Install\ Google\ Drive/GoogleDrive.pkg -target /

# Look for Google Drive 
#commented this section out since the name is back to Google Drive
#if [ -d /Applications/Google\ Drive.app/ ]; then
#  /bin/echo "`date`: Found depricated version of Google Drive. Stopping Drive service." >> ${logfile}
#  /usr/bin/osascript -e 'tell application "Google Drive" to quit'
#  /bin/echo "`date`: Deleting Google Drive Application." >> ${logfile}
#  rm -Rf /Applications/Google\ Drive.app/
#  /Library/Application\ Support/JAMF/bin/jamfHelper.app/Contents/MacOS/jamfHelper  -title "Google Drive Version Found" -windowType hud -description "Google Drive Version Found" -description "While installing Google Drive File Stream we found an older version of Google Drive. Since they are not compatible, we removed the older version. However, you still have data stored in your home folder under Google Drive. These files will no longer be synced, so you should either move them or delete them. If you have any addional questions please reach out to ${SupportContactInfo}." &
#fi

# Cleanup Tasks
/bin/echo "`date`: Unmounting installer disk image." >> ${logfile}
/usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "Install Google Drive" | awk '{print $1}') -quiet
/bin/echo "`date`: Deleting temp files." >> ${logfile}
rm -fv /tmp/$dmgfile
/bin/sleep 3
/bin/echo "`date`: Finished." >> ${logfile}

exit 0