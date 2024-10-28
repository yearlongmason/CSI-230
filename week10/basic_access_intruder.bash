#/!bin/bash

allLogs=""
file="/var/log/apache2/access.log"

function getAllLogs(){
allLogs=$(cat "$file" | cut -d' ' -f7 | sort | uniq -c)
}

getAllLogs
echo "$allLogs"
