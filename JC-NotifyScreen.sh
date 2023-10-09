#!/bin/bash

if [[ -z $4 ]]; then
	scriptLocation=/Users/Shared/Jamf/notify.sh
else
	scriptLocation=$4
fi

touch $scriptLocation
chmod 777 $scriptLocation
echo "Writing file to $scriptLocation"
cat << EOF >> $scriptLocation
#!/bin/zsh 
#variables
NOTIFY_LOG="/var/tmp/depnotify.log"
appNameCommand=(
    "the ITS remote acces tool: install-beyondtrust"
    "the ITS security software: install-rapid7"
    "the ITS security software: install-crowdstrike"
    "some admin tools: install-rosetta"
    "some admin tools: install-jcimages"
    "some admin tools: install-jamfconnect"
    "MS Office: install-office-script"
    "MS Office: install-msaudoupdate"
    "Adobe Reader: install-adobereader"

)
# Function to parse "key: value" strings


parse_key_value() {
    local input="$1"
    IFS=":" read -r key value <<< "$input"
   	echo "Status: Installing "$key"..." >> $NOTIFY_LOG
	/usr/local/bin/jamf policy -event "$value"
    echo "App name: $key"
    echo "Install command: $value"
}

commandCount="${#appNameCommand[@]}"
echo "There are ${#appNameCommand[@]} installers to run."

echo $TOKEN_GIVEN_NAME
echo $TOKEN_UPN

echo "STARTING RUN" >> $NOTIFY_LOG # Define the number of increments for the progress bar
echo "Command: Determinate: ${#appNameCommand[@]}" >> $NOTIFY_LOG
 
#1 - Introduction window with username and animation
echo "Command: Image: /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbookpro-15-retina-touchid-silver.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Welcome to your new Mac" >> $NOTIFY_LOG
echo "Command: MainText: Your Mac is now enrolled and will be automatically configured for you." >> $NOTIFY_LOG
echo "Status: Preparing your new Mac..." >> $NOTIFY_LOG
sleep 10

 
#2 - Setting up single sign-on passwords for local account
echo "Command: Image: /System/Applications/Utilities/Keychain Access.app/Contents/Resources/AppIcon.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Tired of remembering multiple passwords?" >> $NOTIFY_LOG
echo "Command: MainText: We use single sign-on services to help you sign in to each of our corporate services.
Use your email address and account password to sign in to all necessary applications." >> $NOTIFY_LOG
echo "Status: Setting the password for your Mac to sync with your network password..." >> $NOTIFY_LOG
sleep 10
 
#3 - Self Service makes the Mac life easier
echo "Command: Image: /Applications/Self Service.app/Contents/Resources/AppIcon.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Self Service makes Mac life easier" >> $NOTIFY_LOG
echo "Command: MainText: Self Service includes helpful bookmarks and installers for other applications that may interest you." >> $NOTIFY_LOG
echo "Status: Installing Self Service..." >> $NOTIFY_LOG
sleep 10
 
#4 - Everything you need for your first day
###Jamf Triggers
echo "Command: Image: /System/Library/CoreServices/Install in Progress.app/Contents/Resources/Installer.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Installing everything you need for your first day." >> $NOTIFY_LOG
echo "Command: MainText: All the apps you will need today are already being installed. When setup is complete, you'll find Microsoft Office, Slack, and Zoom are all ready to go. Launch apps from the Dock and have fun!" >> $NOTIFY_LOG

# Iterate over the array of apps and commands
for element in "${appNameCommand[@]}"; do
	parse_key_value "$element"
done


#5 - Finishing up
# echo "Status: Installing some administrative tools..." >> $NOTIFY_LOG
# /usr/local/bin/jamf policy -event ""
# /usr/local/bin/jamf policy -event ""
# sleep 5
echo "Status: Finishing up... We're almost ready for you." >> $NOTIFY_LOG
sleep 3
 
###Clean Up
sleep 3
echo "Command: Quit" >> $NOTIFY_LOG
sleep 1
 rm -rf $NOTIFY_LOG
 
#6 - Disable notify screen from loginwindow process
 /usr/local/bin/authchanger -reset -JamfConnect	

EOF
if [[ -f $scriptLocation ]]; then
	echo "Script appears in $scriptLocation"
else
	echo "Script does not appear in $scriptLocation"
fi