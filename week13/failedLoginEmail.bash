#! /bin/bash

authfile="/var/log/auth.log"

function getLogins(){
	logline=$(cat "$authfile" | grep "systemd-logind" | grep "New session")
	dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,11 | tr -d '\.')
	echo "$dateAndUser"
}

# Todo - 1
# a) Make a little research and experimentation to complete the function
# b) Generate failed logins and test
function getFailedLogins(){
	logline=$(cat "$authfile" | grep "failure")
	dateAndUser=$(echo "$logline" | cut -d' ' -f1,2,16 | sed 's/user=//g' )
	echo "$dateAndUser"
}

# Todo - 2
# Send failed logins as email to yourself.
# Similar to sending logins as email
function sendFailedLogins(){

	failedLogins=$(getFailedLogins)
	echo "To: mason.lee@mymail.champlain.edu" > emailform.txt
	echo "Subject: Security Incident" >> emailform.txt
	echo "$failedLogins" >> emailform.txt
	cat emailform.txt | ssmtp mason.lee@mymail.champlain.edu
}

sendFailedLogins
