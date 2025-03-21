#!/bin/bash

# Get parent Dir

# If parent dir is DRAC-Onboarding move to workshop
if [ "$(basename $(pwd))" == "DRAC-Onboarding" ]; then
    cd workshop || exit
fi


# Get all folder in this dir
FOLDERS=$(find . -maxdepth 1 -type d -name '[0-9]-*')


# For each folder
for folder in "${FOLDERS[@]}"; do
    # Grab a README*.md file
    README=$(find $folder -maxdepth 1 -type f -name 'README_*.md')

    for readme in ${README[@]}; do
        if [ -f $readme ]; then
            cp $readme ../Writerside/topics/workshops
            echo "Copying $readme to ../Writerside/topics/workshops"
        fi
    done


done;

