#!/bin/bash
# Get list of ipsw files from Apple download for version specified in variable parameter
# usage ./ipswget.sh "{versionNumber}"
# Remember to chmod +x ipswget.sh
# You can place it in your PATH or your firmware folder to 
# Example ./ipswget.sh 10.2.1 <enter>

version=$1

curl http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/com.apple.jingle.appserver.client.MZITunesClientCheck/version | grep ipsw | grep $version | sort -u | sed 's/<string>//g' | sed 's/<\/string>//g' | grep -v protected | awk '{$1=$1}1' > /tmp/ipswlist_iOS${version}.txt

sort -k 1.89 -o /Users/Shared/acFirmware/iOS${version}_All.txt /tmp/ipswlist_iOS${version}.txt

cat /tmp/ipswlist_iOS${version}.txt | grep iPhone > /Users/Shared/acFirmware/ipswListiOS${version}_iPhone.txt
cat /tmp/ipswlist_iOS${version}.txt | grep iPad > /Users/Shared/acFirmware/ipswListiOS${version}_iPad.txt
cat /tmp/ipswlist_iOS${version}.txt | grep iPodtouch > /Users/Shared/acFirmware/ipswListiOS${version}_iPodtouch.txt
rm -rf /tmp/ipswlist_iOS${version}.txt
