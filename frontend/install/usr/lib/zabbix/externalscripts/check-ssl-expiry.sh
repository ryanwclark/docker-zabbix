#!/bin/bash
## Get days left before certificate expires
## Author: Ryan Clark <ryanwclark@yahoo.com>

### Set Defaults
SERVER=$1
PORT=${2:-443}
TIMEOUT=25

cert_data="$(/usr/bin/timeout $TIMEOUT /usr/bin/openssl s_client -host $SERVER -port $PORT -servername $SERVER -showcerts < /dev/null 2>/dev/null | sed -n '/BEGIN CERTIFICATE/,/END CERT/p' | openssl x509 -enddate -noout 2>/dev/null | sed -e 's/^.*\=//')"

if [ -n "$cert_data" ] ; then
	end_date_seconds=$(date "+%s" --date "$end_date")
	now_seconds=$(date "+%s")
	DAYS=$((($end_date_seconds-$now_seconds)/24/3600))
	echo $DAYS
else
	exit 124
fi 
