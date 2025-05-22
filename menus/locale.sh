#!/bin/sh

# Prompt the user to select a locale
# to get their preferred language
LOCALES=$(ls /usr/share/i18n/locales | awk '{print $1 " " NR}')
while true; do
    export LOCALE=$(dialog \
        --title "Locale" \
        --menu "Select your locale" 20 25 1 \
        $LOCALES \
        3>&1 1>&2 2>&3) ; clear

    if [[ $LOCALE == "" ]]; then
        dialog --msgbox "You must select a locale" 8 30
    else
        break
    fi
done
