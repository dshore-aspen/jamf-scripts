#!/bin/bash

deletedFiles=()
airFiles=(
"/Applications/Adobe/Flash Player/AddIns/airappinstaller/airappinstaller"
"/Applications/Utilities/Adobe AIR Uninstaller.app"
"/Applications/Utilities/Adobe AIR Application Installer.app"
"/Library/Frameworks/Adobe AIR.framework/"
"/Library/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/airappinstaller.rsrc"
"/Library/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/airappinstaller"
"/Library/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/Adobe AIR.vch"
"/Library/Frameworks/Adobe AIR.framework/Versions/1.0/Resources/Adobe AIR Updater.app"
"/Library/Frameworks/Adobe AIR.framework/Versions/1.0/Adobe AIR Application Installer.app"
"/Library/Frameworks/Adobe AIR.framework/Versions/1.0/Adobe AIR/"
"/Users/Shared/Library/Application Support/Adobe/AIR/"
"~/Library/Application\ Support/Adobe/AIR/"
"~/Library/Caches/com.adobe.air.Installer"
"~/Library/Preferences/com.adobe.air.els.<some-hash>.dat.plist"
"~/Library/Preferences/com.adobe.air.els.<some-hash>.dat.plist.lockfile"
)


for i in ${!airFiles[@]};
do
    target=${airFiles[$i]}
    rm -rf $target && echo "[DELETING]----Deleting $target"
    if [ -f $target ]; then
        deletedFiles+=($target)
        airFiles[$i]=""
        echo "[CHECKING]----Successfully deleted $target"
    else
        echo "[CHECKING]----There was an error deleting $target"
    fi
done

echo "----------------"
echo "[REPORT]----The following files were discovered and deleted:"
for i in ${deletedFiles[@]};
do
    echo "[REPORT]----deleted $i"
done

echo "----------------"
echo "[REPORT]----The following files were not discovered or could not be deleted:"
for i in ${airFiles[@]};
do
    if [ $i != "" ]; then 
        echo "[REPORT]----deleted $i"
    fi
done
