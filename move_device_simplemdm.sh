#!/bin/bash

#Origin Group ID
og="90880"
#Destination Group ID
dg="76054"
#SimpleMDM base URL
url="https://a.simplemdm.com/api/v1/device_groups"
#$APIKEY is passed by a system variable

while read device; do
    curl --location --request POST "$url/$dg/devices/$device" \
        --header "Authorization: Basic $APIKEY"
    echo "Moved Device# $device to Group# $dg"
done < <(curl --location --request GET "$url/$og" \
    --header "Authorization: Basic $APIKEY" | jq -r '[.data.relationships.devices.data[].id] | @csv' | tr ',' '\n')

exit 0
