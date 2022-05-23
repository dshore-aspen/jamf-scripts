#!/bin/bash

mkdir -p /Library/Management/bomgar/
cd /Library/Management/bomgar/

curl -O btagent.dmg https://aspeninstitute.beyondtrustcloud.com/download_client_connector?fn=null&jc=39e41f307d2659bf22b82dfd401e8bf3&p=mac-osx-x86-dmg&ss=291e8ca1a9fb054bff729f0897987ff8dfe29e3c
hdiutil attach /Library/Management/bomgar/bomgar-scc.dmg

/bomgar-scc/Double-Click\ To\ Start\ Support\ Session.app/Contents/
