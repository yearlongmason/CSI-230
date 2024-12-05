#! /bin/bash
clear

[ $# -ne 2 ] && echo "ERROR: finalC2.bash takes 2 parameters" && exit 1

logFile=$1
iocFile=$2
outputFile="report.txt"

ioc=$(cat "$logFile" | egrep -i -f "$iocFile")
ioc=$(echo "$ioc" | awk '{print $1,$4,$7}' | sed 's/\[//g')

echo "$ioc" > "$outputFile"
