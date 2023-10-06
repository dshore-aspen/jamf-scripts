#!/bin/zsh
# tee -a /Users/Shared/Jamf/notify.sh > /dev/null <<EOT

#!/bin/zsh 
#variables
#NOTIFY_LOG="/var/tmp/depnotify.log"
#For TOKEN_BASIC, use same file path location as set for OIDCIDTokenPath in com.jamf.connect.login
#TOKEN_BASIC="/tmp/token"
#TOKEN_GIVEN_NAME=$(echo "$(cat $TOKEN_BASIC)" | sed -e 's/\"//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep given_name | cut -d ":" -f2)
#TOKEN_UPN=$(echo "$(cat $TOKEN_BASIC)" | sed -e 's/\"//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | grep upn | cut -d ":" -f2)
appNameList=(
    ""
    ""
    ""
    ""
    ""
    ""
)

appInstallCommandList=(
    ""
    ""
    ""

)
installerStepCount="${#appNameList[@]}"
echo "There are $installerStepCount installers to run."

exit
echo $TOKEN_GIVEN_NAME
echo $TOKEN_UPN
 
echo "STARTING RUN" >> $NOTIFY_LOG # Define the number of increments for the progress bar
echo "Command: Determinate: 6" >> $NOTIFY_LOG
 
#1 - Introduction window with username and animation
echo "Command: Image: /System/Library/CoreServices/CoreTypes.bundle/Contents/Resources/com.apple.macbookpro-15-retina-touchid-silver.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Welcome, $TOKEN_GIVEN_NAME" >> $NOTIFY_LOG
echo "Command: MainText: Your Mac is now enrolled and will be automatically configured for you." >> $NOTIFY_LOG
echo "Status: Preparing your new Mac..." >> $NOTIFY_LOG
sleep 10
 
#2 - Setting up single sign-on passwords for local account
echo "Command: Image: /System/Applications/Utilities/Keychain Access.app/Contents/Resources/AppIcon.icns" >> $NOTIFY_LOG
echo "Command: MainTitle: Tired of remembering multiple passwords? \n $TOKEN_GIVEN_NAME " >> $NOTIFY_LOG
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
echo "Status: Installing ITS' remote access tool..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event "install-beyondtrust"
sleep 5

echo "Status: Installing ITS' antivirus software..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event "install-rapid7"
/usr/local/bin/jamf policy -event "install-crowdstrike"
sleep 5

echo "Status: Installing MS Office..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event "install-office-script"
sleep 5

install-chrome-script
 
#5 - Finishing up
echo "Status: Installing some administrative tools..." >> $NOTIFY_LOG
/usr/local/bin/jamf policy -event "install-jcimages"
/usr/local/bin/jamf policy -event "install-jamfconnect"
sleep 5
echo "Status: Finishing up... We're almost ready for you, $TOKEN_GIVEN_NAME" >> $NOTIFY_LOG
sleep 3
 
###Clean Up
sleep 3
echo "Command: Quit" >> $NOTIFY_LOG
sleep 1
rm -rf $NOTIFY_LOG
 
#6 - Disable notify screen from loginwindow process
/usr/local/bin/authchanger -reset -JamfConnect	


EOT
exit