#!/bin/bash

/Applications/OneDrive.app/Contents/Resources/ResetOneDriveAppStandalone.command 
/Applications/OneDrive.app/Contents/Resources/RemoveOneDriveCreds.command  
/usr/libexec/PlistBuddy -c "Add :FilesOnDemandEnabled bool true" ~/Library/Preferences/com.microsoft.OneDrive.plist