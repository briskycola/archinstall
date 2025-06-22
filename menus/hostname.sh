#!/bin/bash

# Arch Linux install script
# by Santiago Torres

# Prompt the user to choose a hostname
while true; do
    export HOSTNAME=$(dialog \
        --title "Hostname" \
        --inputbox "Enter a hostname" 10 60 \
        3>&1 1>&2 2>&3) ; clear

    if [[ $HOSTNAME == "" ]]; then
        dialog --msgbox "You must enter a hostname" 8 30
    else
        break
    fi
done
