#!/bin/bash

# Author: Alvaro Alonso
# Created: 14/03/2023
# Last Modified: 14/03/2023
# Description: Curf Remover will ask you to enter a directory and a date. Everything older than the selected days in the selected
# folder will be prompted to be removed. 
# Usage: Run ./curf_remover.sh and enter the name of the folder you want to remove curf from, followed by a date in days.

read -r -p "Enter the directory to remove curf from: " directory
# Checks if the directory exist.
if [ ! -d "$directory" ]; then
    echo "Directory doesn't exist"
    exit 1
fi

read -r -p "Enter how old (in days) do you want to remove curf: " days
# Checks if the date in days is valid.
if ! [[ "$days" =~ ^-?[0-9]+$ ]]; then
    echo "Date invalid. Please enter a valid date in days"
    exit 1
fi

# Ask to remove each file in the directory that matches the date criteria.
for file in $(find "$directory" -type f -maxdepth 1 -mtime "$days"); do
    read -r -p "Are you sure you want to remove $file [y/N]?" prompt
    if [[ $prompt == "y" || $prompt == "Y" || $prompt == "yes" || $prompt == "Yes" ]]; then
        rm "$file"
        echo "$file has been removed."
    else
        echo "$file will live to fight another day"
    fi
done

exit 0
