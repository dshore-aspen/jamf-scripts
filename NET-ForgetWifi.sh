#!/bin/bash


sudo -s
# Pulls the current logged in user and their UID
currUser=$(ls -l /dev/console | awk '{print $3}')
currUserUID=$(id -u "$currUser")

result=$(
/bin/launchctl asuser "$currUserUID" sudo -iu "$currUser" /usr/bin/osascript > /dev/null << APPLESCRIPT

display dialog "Enter name of the Wi-Fi access point you wish to forget.

Note: This is case-sensitive" default answer "" with title "Forget Wi-Fi Access Point" with icon file "System:Library:CoreServices:CoreTypes.bundle:Contents:Resources:GenericNetworkIcon.icns"
set the wifiAP to the text returned of the result
do shell script "networksetup -removepreferredwirelessnetwork en0 "& quoted form of wifiAP
do shell script "networksetup -removepreferredwirelessnetwork en1 "& quoted form of wifiAP
APPLESCRIPT
)

echo "$result"