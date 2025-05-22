#!/bin/sh

# Arch Linux install script
# by Santiago Torres

# Prompt the user to select a filesystem
# for their installation
while true; do
    export FILESYSTEM=$(dialog \
        --title "Filesystem" \
        --menu "Choose a filesystem" 11 10 1 \
        "ext4" "" \
        "btrfs" "" \
        "xfs" "" \
        3>&1 1>&2 2>&3) ; clear

    if [[ $FILESYSTEM == "" ]]; then
        dialog --msgbox "You must select a filesystem" 8 35
    else
        break
    fi
done
