#!/bin/bash

if [ -z $4 ]; then
	dmgName=""
else 
	dmgName=$4
fi
if [ -z $5 ]; then
	url=""
else
	url=$5
fi
if [ -z $6 ]; then
	filePath="/Users/Shared/"
else
	filePath=$6
fi
curl --output $filePath$dmgName "$url"
cd $filePath
if test -f $dmgName; then
	echo "found -->"$dmgName
	xattr -d com.apple.quarantine $dmgName
	hdiutil attach -mountpoint /Volumes/bomgar-scc "$dmgName"
    '/Volumes/bomgar-scc/Double-Click To Start Support Session.app/Contents/MacOS/sdcust'
	ps aux | grep bomgar | wc -l
    hdiutil detach /Volumes/bomgar-scc
    rm -r $dmgName
    exit 0
else
	echo "Missing dmg file"
	exit 1
fi