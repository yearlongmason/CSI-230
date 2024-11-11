#! /bin/bash
clear

link="10.0.17.6/Assignment.html"

# get it with curl and tell curl not to give errors
fullPage=$(curl -sL "$link")

# Utilizing xmlstarlet tool to extract table from the page
table1=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
'//html//body//table[@id="temp"]//tr//td')

table2=$(echo "$fullPage" | \
xmlstarlet format --html --recover 2>/dev/null | \
xmlstarlet select --template --copy-of \
'//html//body//table[@id="press"]//tr//td')

clear # Clear feedback from curl request

table1=$(echo "$table1" | sed 's/<\/tr>/\n/g' | \
                     sed -e 's/&amp;//g' | \
                     sed -e 's/<tr>//g' | \
                     sed -e 's/<td[^>]*>//g' | \
                     sed -e 's/<\/td>/;/g' | \
                     sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                     sed -e 's/<[/\]\{0,1\}nobr>//g')

table2=$(echo "$table2" | sed 's/<\/tr>/\n/g' | \
                      sed -e 's/&amp;//g' | \
                      sed -e 's/<tr>//g' | \
                      sed -e 's/<td[^>]*>//g' | \
                      sed -e 's/<\/td>/;/g' | \
                      sed -e 's/<[/\]\{0,1\}a[^>]*>//g' | \
                      sed -e 's/<[/\]\{0,1\}nobr>//g')


# Set semicolon as the delimiter
IFS=';'

# Read the split words into an array
read -ra table1 <<< "$table1"
read -ra table2 <<< "$table2"

# Loop through the indexes in either table
for (( i=0; i<${#table1[@]}; i+=2 ));
do
	echo "${table2[$i]} ${table1[$i]} ${table1[$i+1]}"
done
