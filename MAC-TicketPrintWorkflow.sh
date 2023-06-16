#!/bin/bash
# This script is meant to make it easier to open and print multiple tickets from our Zendesk instance.
# For it to work, you must open a Zendesk session in Chrome first. (Specifically Chrome)
# Then fill in the $list variable as instructed. Then run the script. 
# For each ticket number listed, a new tab will open in Chrome to the "print ticket" view in Zendesk.
# From there, simply click the save button and choose where you want to save the PDf. 
# It will auto-name the file with the URL but you can insert whatever you want in the save window before saving.

# Insert just the ticket numbers, separated with a single space, no commas or new lines
declare -a list=(
66425 66423 66986 66849 67199 67298 67286 66692 66693 66792 66592 67208 67212 66860 67299 67306
)
echo "---"
echo "Starting run now."


for r in "${list[@]}" 
do
	echo $r
# /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-gpu --print-to-pdf https://aspeninst.zendesk.com/tickets/$r/print
# /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --disable-gpu --use-system-default-printer  https://aspeninst.zendesk.com/tickets/$r/print --kiosk-printing --print-to-pdf="$r-1.pdf"
 /Applications/Google\ Chrome.app/Contents/MacOS/Google\ Chrome --remote-debugging-port=0 --disable-gpu --use-system-default-printer --print-to-pdf="~/Downloads/$r.pdf" https://aspeninst.zendesk.com/tickets/$r/print --kiosk-printing

done

