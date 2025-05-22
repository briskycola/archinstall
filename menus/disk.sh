#!/bin/sh

# Prompt the user to select the disk
# that they want to install Arch Linux to
while true; do
    export DISK=$(dialog \
        --title "Select Disk" \
        --menu "Select your disk" 15 25 1 \
        $(lsblk -d -o NAME,SIZE -n -e7) \
        3>&1 1>&2 2>&3) ; clear

    if [[ $DISK == "" ]]; then
        dialog --msgbox "You must select a disk" 8 30
    else
        break
    fi
done
