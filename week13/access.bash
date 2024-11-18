#! /bin/bash

date=$(date '+%Y-%m-%d %H-%M-%S')
echo "File was accessed on $date" >> fileaccesslog.txt

body=$(cat "fileaccesslog.txt")
echo "To: mason.lee@mymail.champlain.edu" > emailform.txt
echo "Subject: Access Logs" >> emailform.txt
echo "$body" >> emailform.txt
cat emailform.txt | ssmtp mason.lee@mymail.champlain.edu
