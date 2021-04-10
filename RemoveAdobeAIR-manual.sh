#!/bin/bash

touch ~/Desktop/test/1\ test.txt
touch ~/Desktop/test/2.txt


allUsers=$(dscl . -ls /Users)
list=($allUsers)
realUsers=()
for i in ${!list[@]}; 
do

	case ${list[$i]} in
	"daemon")
		;;
	"nobody")
		;;
	"root")
		;;
	*)
		if [[ ${list[$i]:0:1} != "_" ]]; then
			echo "[USER ADD]----${list[$i]}"
			realUsers+=(${list[$i]})
		fi
	esac	
done
echo "[USER LIST]----${realUsers[*]}"


userFiles=(
Desktop/test/1\ test.txt
Desktop/test/2.txt
Library/Application\ Support/Adobe/AIR/
Library/Caches/com.adobe.air.Installer
Library/Preferences/com.adobe.air.els.*
)
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
)


echo "----------------"
echo "----------------"
echo "[BEGINNING]----Beginning to check for files"
echo "----------------"

for i in ${!airFiles[@]};
do
		rm -r "${airFiles[$i]}" && echo "[FOUND]----${airFiles[$i]}"  ||  echo "[MISSING]----${airFiles[$i]}"
done


for u in ${!realUsers[@]};
do
	user=${realUsers[$u]}
	echo "[USER]----$user"
	for i in ${!userFiles[@]};
	do
		rm "/Users/$user/${userFiles[$i]}" && { echo "[FOUND]----${userFiles[$i]}"; deletedFiles+=${userFiles[$i]}; } || { echo "[MISSING]----${userFiles[$i]}"; deletedFiles+=${userFiles[$i]}; }
	done
done

echo "----------------"
echo "----------------"