#!/bin/bash


osascript -e 'quit app "Google Drive"'
echo $?
rm -r ~/Library/Preferences/com.google.* && echo $?
rm -r ~/Library/Google && echo $?
rm -r ~/Library/Application\ Support/Google/DriveFS && echo $?
rm -r ~/Library/Caches/com.google* && echo $?
rm -r ~/Library/Containers/Google\ Drive/
rm -r ~/Library/Containers/com.google*
rm -r ~/Library/Saved\ Application\ State/com.google*


sudo -s
sudo rm -r /Library/Managed\ Preferences/com.google*
sudo rm -r /Library/Google/DriveFS
sudo rm -r /Library/Application\ Support/Google/DriveFS