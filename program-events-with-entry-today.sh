#!/bin/bash
_self="${0##*/}"
now=$(date)
jsonfile='/tmp/program-event-tickets.json'
jsonwebfile='/var/www/html/odata/program-event-tickets.json'
csvfile='/var/www/html/program-event-tickets.csv'
url='ODATA_URL_HERE'
# Download the json file.
curl -n ~/.netrc $url >  $jsonfile
# Convert military time
sed -i 's/0900/9:00AM/'  $jsonfile
sed -i 's/0930/9:30AM/'  $jsonfile
sed -i 's/1000/10:00AM/' $jsonfile
sed -i 's/1030/10:30AM/' $jsonfile
sed -i 's/1100/11:00AM/' $jsonfile
sed -i 's/1130/11:30AM/' $jsonfile
sed -i 's/1200/12:00PM/' $jsonfile
sed -i 's/1230/12:30PM/' $jsonfile
sed -i 's/1300/1:00PM/'  $jsonfile
sed -i 's/1330/1:30PM/'  $jsonfile
sed -i 's/1400/2:00PM/'  $jsonfile
sed -i 's/1430/2:30PM/'  $jsonfile
sed -i 's/1500/3:00PM/'  $jsonfile
sed -i 's/1530/3:30PM/'  $jsonfile
sed -i 's/1600/4:00PM/'  $jsonfile
sed -i 's/1630/4:30PM/'  $jsonfile
sed -i 's/1700/5:00PM/'  $jsonfile
sed -i 's/1730/5:30PM/'  $jsonfile
sed -i 's/1800/6:00PM/'  $jsonfile
sed -i 's/1830/6:30PM/'  $jsonfile
sed -i 's/1900/7:00PM/'  $jsonfile
sed -i 's/1930/7:30PM/'  $jsonfile
sed -i 's/2000/8:00PM/'  $jsonfile
sed -i 's/2030/8:30PM/'  $jsonfile
sed -i 's/2100/9:00PM/'  $jsonfile
sed -i 's/2130/9:30PM/'  $jsonfile
sed -i 's/2200/10:00PM/' $jsonfile
sed -i 's/2230/10:30PM/' $jsonfile
sed -i 's/T00:00:00//'   $jsonfile
# Copy from tmp to web directory
cp $jsonfile $jsonwebfile
# Convert json file to csv
cat $jsonfile  | jq  -r '.value | map([.LastName,.FirstName,.Type, (.Qty|tostring), .Entry,.Program,.Date] | join(", ")) | join("\n")'  > $csvfile
# Add a header row
sed -i '1s;^;Last_Name, First_Name, Type, Qty, Time, Program, Date\n;' $csvfile
echo "$now" "- Created MOA ticket list csv file. $_self" >> /var/log/odata.log
