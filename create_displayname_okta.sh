#!/bin/bash

# Search for email address and bring back userid, firstName and lastName, then add a displayName using these values.

url="OKTA URL"


updateuser() {
    curl --location -g --request POST "$url/api/v1/users/""$1" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apikey" \
        --data-raw '{
  "profile": {
    "displayName": "'"$2 $3"'"
    }
    }'
}

while read -r email; do
    userid=$(curl --location "$url//api/v1/users?q=$email&limit=1" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apikey" | jq -r '[.[0] | .id]' | tr -d '"','[]','\n' | awk '{$1=$1};1')
    firstName=$(curl --location "$url//api/v1/users?q=$email&limit=1" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apikey" | jq -r '[.[0] | .profile.firstName]' | tr -d '"','[]','\n' | awk '{$1=$1};1')
    lastName=$(curl --location "$url//api/v1/users?q=$email&limit=1" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apikey" | jq -r '[.[0] | .profile.lastName]' | tr -d '"','[]','\n' | awk '{$1=$1};1')
    updateuser "$userid" "$firstName" "$lastName" &>/dev/null
done <"$1"

