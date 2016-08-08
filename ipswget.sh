#!/bin/bash
# Lookup ipsw links by device and iOS version number and download each file to local computer..




#Insert lookup code here
#inster tmp files same


filename='peptides.txt'
filelines=`cat $filename`
echo Start
for line in $filelines ; do
    curl -O $line 
done
