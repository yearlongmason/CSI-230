#/!bin/bash

:> "report.html"

echo "<html><body>" >> "report.html"

echo "<p>Access logs with IOC indicators:</p>" >> "report.html"

# Start table tag
echo "<table style='border: 1px solid;'>" >> "report.html"

# Get contents of report.txt
report=$(cat report.txt)

#Set the field separator to new line
IFS=$'\n'

#Iterate over each line
for row in $report
do
	# Create a new table row and iterate over the row using space as a delimeter
	echo "<tr>" >> "report.html"
	IFS=" "
	for item in $row
	do
		echo "<td style='border: 1px solid;'>$item</td>" >> "report.html"
	done
	echo "</tr>" >> "report.html"
done

# Close out the html tags
echo "</table></body></html>" >> "report.html"

# Move file to /var/www/html/
cp "report.html" "/var/www/html/"
