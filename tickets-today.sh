#!/bin/bash
_self="${0##*/}"
now=$(date)
jsonfile='/tmp/tickets.json'
csvfile='/var/www/html/odata/tickets.csv'
url='ALTRU_ODATA_URL_HERE'
# Download json file. Be sure you have a service account that is a Blackbaud ID and store the creds in a chmod 600 protected netrc file
curl -s -n ~/.netrc $url >  $jsonfile
# Use jq to parse and concatenate ticket URL prefix with sale order ID and export as csv
cat $jsonfile  |  jq  -r '.value | map([.OrderNum,.LastName,.FirstName,.Lookup,.ProgramEvent,"https://SITEID.blackbaudhosting.com/SITEID/sslpage.aspx?pid=202&soid=" + .soid] | join(", ")) | join("\n")' > $csvfile
# Add a header row to the csv
sed -i '1s;^;OrderNum, Last_Name,First_Name, LookupID, ProgramEvent, URL\n;' $csvfile
# Log the job to /var/log. Recommend setting up log rotation
echo "$now" "- Ticket csv created - Script: $_self" >> /var/log/odata.log
