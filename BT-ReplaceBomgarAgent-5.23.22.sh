#!/bin/bash

mkdir -p /Library/Management/bomgar/
cd /Library/Management/bomgar/

curl --output 'btagent.zip' "https://aspeninstitute.beyondtrustcloud.com/download_client_connector?fn=null&jc=918c8ddcbe4eec577d9a7862ee717cb8&p=mac-osx-x86&ss=cf588b6349ea900c7c31f87f599e2e7e35b4de4f"
unzip ./btagent.zip
./Open\ To\ Deploy\ Jump\ Client.app/Contents/MacOS/Bootstrap 
