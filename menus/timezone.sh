#!/bin/sh

# Arch Linux install script
# by Santiago Torres

# Prompt the user to select their
# region and city to get their timezone.
while true; do
    export REGION=$(dialog \
        --title "Locale" \
        --menu "Select your region: " 20 10 1 \
        "Africa" "" \
        "America" "" \
        "Antarctica" "" \
        "Arctic" "" \
        "Asia" "" \
        "Atlantic" "" \
        "Australia" "" \
        "Europe" "" \
        "Indian" "" \
        "Pacific" "" \
        3>&1 1>&2 2>&3) ; clear

    if [[ $REGION == "" ]]; then
        dialog --msgbox "You must select a region" 8 30
        continue
    fi
    
    CITIES=$(find /usr/share/zoneinfo/$REGION \
        -maxdepth 1 -type f -exec basename {} \; | awk '{print $1 " " NR}')
    
    export CITY=$(dialog \
        --title "City" \
        --menu "Select the closest city" 20 25 1 \
        $CITIES \
        3>&1 1>&2 2>&3) ; clear

    if [[ $CITY == "" ]]; then
        dialog --msgbox "You must select a city" 8 30
        continue
    else
        break
    fi
done
