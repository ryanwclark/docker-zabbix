#!/bin/bash
## Get Days left of Domain Name registration
## Author: Ryan Clark <ryanwclark@yahoo.com>

domain=$1

if [ -z $1 ];then
	echo "Usage : $0 <domain name>"
	exit;
fi
expiration=$(whois ${domain} | egrep -i 'Expiry Date' | grep -oE '[0-9]{4}-[0-9]{2}-[0-9]{2}|[0-9]{4}\/[0-9]{2}\/[0-9]{2}')
expirationseconds=$(date --date="${expiration//\//\-}" +%s)
today=$(date +"%s")
diff=$(($expirationseconds-$today))
daysleft=$(($diff/86400))
echo $daysleft
