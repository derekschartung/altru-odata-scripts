# altru-odata-scripts

This script,tickets-today.sh, assumes a few things. You have a .netrc with protected Blackbaud ID creds. Only root should be able to read this file. You have a cron job that runs the script at an interval that works for you. That the output json file is saved to tmp so jq can parse the data and output it to your web root or subdirectory. Your web subdirectory should be password protected using htpasswd and you set headers to never cache. You want the web content to always be new never cached.

Your Altru query should not use the default output headers. Override them all and sanitize. No commas, apostrophes, single or double quotes, no spaces. CamelCase is ideal.
The order of fields matters less since you can reorder fields using jq, but I would be consistent. You can omit fields from output using jq. If you need to deal with time, you'll have to convert from the way military time is set in Altru odata output to something more user friendly. You can do this with sed.

sed -i 's/0900/9:00AM/'  $jsonfile

We are writing a CSV and a JSON file. The JSON file is for jquery to parse as an HTML table for web display. The CSV is so Excel can access the same data as a web source using a basic user/pass instead of a Blackbaud ID. Using htpasswd is fine. You could go a step further and add Azure AD or SAML to the web directory for extra security and combine that with an IP access list. Your security vendor will have some ideas.



