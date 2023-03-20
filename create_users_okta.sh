#!/bin/bash

oktaURL="OKTA URL"

# Function to search by user
userSearch() {
    curl --location "$oktaURL//api/v1/users?q=$1&limit=1" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apiKey"
}

# Function to create a user, add it to a group and activate it.
userCreate() {
    curl --location "$oktaURL//api/v1/users?activate=true" \
        --header 'Accept: application/json' \
        --header 'Content-Type: application/json' \
        --header "Authorization: SSWS $apiKey" \
        --data-raw '{
  "profile": {
    "firstName": "'"$3"'",
    "displayName": "'"$3"'",
    "lastName": "'"$2"'",
    "email": "'"$1"'",
    "login": "'"$1"'",
    "secondEmail": "'"$4"'",
    "department": "Live",
    "contractType": "Freelancer"
  },
  "groupIds": [
    "00g83wg3tyDzoIpXf416"
  ]
}'
}

# Main Loop
while IFS="," read -r login lastName firstName secondEmail; do
    # Check if the person's email address already exist in Okta
    # If exists, prints the result in the console and skips the user
    if userSearch "$login" | grep id &>/dev/null; then
        echo
        echo "$login already exist. Skipping"
        echo
    else
        userCreate "$login" "$lastName" "$firstName" "$secondEmail" &>/dev/null
        echo
        echo "User $login has been created."
        echo
    fi
done < <(cut -d "," -f1,2,3,6 "$1" | tail -n +2)

exit 0
