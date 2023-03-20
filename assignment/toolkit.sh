#!/bin/bash

# Author: Alvaro Alonso
# Created: 14/03/2023
# Last Modified: 14/03/2023
# Description: Toolkit will allow you to select between two scripts: curf_remover.sh and folder_organiser.sh. 
# Usage: Run ./toolkit.sh and select the script you wish to run.

PS3="Which tool do you want to open? [1/2] "
select option in "Curf Remover" "Folder Organiser"; do
    case "$option" in
    1 | "Curf Remover")
        echo "Running Curf Remover"
        ./curf_remover.sh
        break
        ;;
    2 | "Folder Organiser")
        echo "Running Folder Organiser"
        ./folder_organiser.sh
        break
        ;;
    *)
        echo "You didn't select a correct option. Quitting"
        break
        ;;
    esac
done
