#!/bin/bash

# Author: Alvaro Alonso
# Created: 14/03/2023
# Last Modified: 14/03/2023
# Description: Folder organiser will ask for a folder and it will sort files based on extension 
# storing them in directories related to their content.
# Usage: Run ./folder_organiser.sh and enter the name of the folder you want to organise.

read -r -p "Which folder do you want to organise?: " directory
# Checks if the selected directory exist.
if [ ! -d "$directory" ]; then
    echo "Directory doesn't exist"
    exit 1
fi

# Function to move files to folder and create the folder if it doesn't exist.
moveitmoveit() {
    if [ -d "$final" ]; then
        mv "$directory/$file" "$final"
    else
        mkdir "$final"
        mv "$directory/$file" "$final"
    fi
}

# Maim loop to move the files
while read -r file; do

    case "$file" in
    *.txt | *.doc | *.docx | *.pdf)
        final="$directory/documents/"
        moveitmoveit
        ;;

    *.jpg | *.jpeg | *.png)
        final="$directory/images/"
        moveitmoveit
        ;;

    *.xls | *.xlsx | *.csv)
        final="$directory/spreadsheets/"
        moveitmoveit
        ;;

    *.sh)
        final="$directory/scripts/"
        moveitmoveit
        ;;

    *.zip | *.tar | *.tar.gz | *.tar.bz2)
        final="$directory/archives/"
        moveitmoveit
        ;;

    *.ppt | *.pptx)
        final="$directory/presentations/"
        moveitmoveit
        ;;
    *.mp3)
        final="$directory/audio/"
        moveitmoveit
        ;;
    *.mp4)
        final="$directory/video/"
        moveitmoveit
        ;;
    esac

done < <(ls "$directory")
