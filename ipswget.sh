#!/bin/bash
# Get list of ipsw files from Apple download for version specified in variable parameter
# usage ./ipswget.sh "{versionNumber}"
# Remember to chmod +x ipswget.sh
# You can place it in your PATH or your firmware folder to 
# Example ./ipswget.sh 10.2.1 <enter>

version=$1
filelocation="/Users/Shared/acFirmware"

curl http://ax.phobos.apple.com.edgesuite.net/WebObjects/MZStore.woa/wa/com.apple.jingle.appserver.client.MZITunesClientCheck/version | grep ipsw | grep $version | sort -u | sed 's/<string>//g' | sed 's/<\/string>//g' | grep -v protected | awk '{$1=$1}1' >> /tmp/ipswList_iOS${version}.txt

sort -k 1.89 -o ${filelocation}/iOS${version}_All.txt /tmp/ipswlist_iOS${version}.txt

cat /tmp/ipswList_iOS${version}.txt | grep iPhone > ${filelocation}/ipswListiOS${version}_iPhone.txt
cat /tmp/ipswList_iOS${version}.txt | grep iPad > ${filelocation}/ipswListiOS${version}_iPad.txt
cat /tmp/ipswList_iOS${version}.txt | grep iPodtouch > ${filelocation}/ipswListiOS${version}_iPodtouch.txt
rm -rf /tmp/ipswList_iOS${version}.txt

##	Uncomment lines to auto open the list(s) for viewing.
#open ${filelocation}/ipswListiOS${version}_iPhone.txt
#open ${filelocation}/ipswListiOS${version}_iPad.txt
#open ${filelocation}/ipswListiOS${version}_iPodtouch.txt

## Uncomment lines to automatically loop through the list and download all files.
#for i in $(cat ${filelocation}/ipswListiOS${version}_iPhone.txt) ; do curl -O $i ; done
#for i in $(cat ${filelocation}/ipswListiOS${version}_iPad.txt) ; do curl -O $i ; done
#for i in $(cat ${filelocation}/ipswListiOS${version}_iPodtouch.txt) ; do curl -O $i ; done
