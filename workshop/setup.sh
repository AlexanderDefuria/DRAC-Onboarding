#!/bin/bash

# USERS
N=50
users=()
for i in $(seq -f "%02g" 1 $N); do
    users+=("user$i")
done

# shellcheck disable=SC2145
echo "Users: ${users[@]}"

# Connection info
PASSWORD="mindsonai"
ADDRESS="magical.puzzlefish.org"

# List of folders to copy
folders=$(find . -maxdepth 1 -type d -name '[0-9]-*')

# shellcheck disable=SC2068
for user in ${users[@]}; do
    # Delete the files on the server
    # sshpass -p $PASSWORD ssh $user@$ADDRESS "rm -rf /home/$user/projects/def-sponsor00/$user/*"

    # shellcheck disable=SC2068
    for folder in ${folders[@]}; do
        echo "Copying $folder to $user"
        # Copy the folder and its contents without needing to enter the password
        sshpass -p $PASSWORD scp -r $folder $user@$ADDRESS:/home/$user/projects/def-sponsor00/$user
    done
    echo "Copying README*.md to $user"
    sshpass -p $PASSWORD scp README* $user@$ADDRESS:/home/$user/projects/def-sponsor00/$user
    echo "Copying bashrc to $user"
    sshpass -p $PASSWORD scp bashrc $user@$ADDRESS:/home/$user/.bashrc
done