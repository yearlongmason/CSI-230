#/!bin/bash

:> "report.html"

echo "<html><body><table>" >> "report.html"

# TODO: Get contents of report.txt and put into a table in report.html
echo "<p>Hello! Awagga!</p>" >> "report.html"

echo "</table></body></html>" >> "report.html"

cp "report.html" "/var/www/html/"
