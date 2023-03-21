#!/bin/bash

# Search for email address and bring back userid, firstName and lastName, then add a displayName using these values.
# Usage: <script> <target csv>

url="OKTA URL"

# Function to modify the user
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

# Function to search for a user based on email address
getuserinfo() {
    curl --location "$url//api/v1/users?q=$1&limit=1" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apikey" | jq -r '[.[0] | .id, .profile.firstName, .profile.lastName] | @csv' | tr -d '"'
}

# Main loop
while read -r email; do
    while IFS="," read -r id firstName lastName; do
        updateuser "$id" "$firstName" "$lastName" &>/dev/null
    done < <(getuserinfo "$email")
done <"$1"
