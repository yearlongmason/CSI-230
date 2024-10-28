#/!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function countingCurlAccess(){
allLogs=$(cat "$file" | cut -d' ' -f1,12 | grep "curl" | sort | uniq -c)
}

countingCurlAccess
echo "$allLogs"
