#!/bin/sh

# Prompt the user to make a password
# for the root user
while true; do
    export ROOT_PASSWORD=$(dialog \
        --title "Root Password" \
        --inputbox "Enter a root password" 15 60 \
        3>&1 1>&2 2>&3) ; clear

        if [[ $ROOT_PASSWORD == "" ]]; then
            dialog --msgbox "The password cannot be blank" 8 35
            continue
        fi

    # Prompt the user to make a username
    # and password for their user
    export USERNAME=$(dialog \
        --title "Username" \
        --inputbox "Enter a username" 15 60 \
        3>&1 1>&2 2>&3) ; clear
    
    export PASSWORD=$(dialog \
        --title "Password" \
        --inputbox "Enter a password" 15 60 \
        3>&1 1>&2 2>&3) ; clear
    
    export CONFIRM_PASSWORD=$(dialog \
        --title "Confirm Password" \
        --inputbox "Confirm password" 15 60 \
        3>&1 1>&2 2>&3) ; clear

    if   [[ $PASSWORD == $CONFIRM_PASSWORD ]]; then
        break
    elif [[ $PASSWORD == "" || $CONFIRM_PASSWORD == "" ]]; then
        dialog --msgbox "The password cannot be blank" 8 35
    else
        dialog --msgbox "Passwords do not match" 10 30
    fi
done
