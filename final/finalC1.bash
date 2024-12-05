#! /bin/bash
clear

link="10.0.17.6/IOC.html"
IOCFile="IOC.txt"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
table=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
'//html//body//table//tr//td')

clear # Clear feedback from curl request

table=$(echo "$table" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g')

# Set semicolon as the delimiter
IFS=';'

# Read the split words into an array
read -ra table <<< "$table"

:> "$IOCFile"
# Loop through the indexes in either table
for (( i=0; i<${#table[@]}; i+=2 ));
do
	echo "${table[$i]}" >> "$IOCFile"
done
