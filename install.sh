#!/bin/bash

# Arch linux install script
# by Santiago Torres

# Check if there is internet access
echo "Testing Internet Connection"
ping -c 3 archlinux.org > /dev/null 2>&1
if [ $? -eq 0 ]; then
    echo "Internet is working"
    sleep 1
else
    echo "Internet is not working."
    echo "To connect to the internet, use the iwctl command"
    echo "iwctl --passphrase <passphrase> station <name> connect <SSID>"
    exit 1
fi

# Check if dialog is installed
echo "Checking if dialog is installed"
which dialog > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "Dialog is not installed. Installing dialog"
    pacman -Sy --noconfirm dialog > /dev/null 2>&1
else
    echo "Dialog is installed"
    sleep 1
fi

# Check if the system is UEFI or legacy BIOS
cat /sys/firmware/efi/fw_platform_size > /dev/null 2>&1
if [ $? -eq 0 ]; then
    export BOOT_MODE="UEFI"
else
    export BOOT_MODE="BIOS"
fi

# Display a welcome message to the user
dialog \
    --title "Welcome" \
    --msgbox "Welcome to my Arch Linux install script. \n\nThis script
installs Arch Linux with a minimal KDE desktop that only includes
the programs necessary for your system. \n\nBefore proceeding, make sure
you select the correct drive and backup any important data to avoid
any data loss." \
    11 80 ; clear

# Go through all of the menus to get
# the installation settings
source menus/disk.sh
source menus/filesystem.sh
source menus/timezone.sh
source menus/locale.sh
source menus/user.sh
source menus/hostname.sh
source menus/gpu_driver.sh

# Prompt the user to confirm that they want to erase the disk
dialog \
    --yesno "By selecting yes, all data on the selected drive will be erased.
\n\nAre you sure you want to continue?" 10 50

if [ $? -eq 0 ]; then
    if [[ $BOOT_MODE = "UEFI" ]]; then
        source scripts/partitionDiskUEFI.sh
        source scripts/installBaseSystemUEFI.sh
        source scripts/postInstall.sh
    else
        source scripts/partitionDiskBIOS.sh
        source scripts/installBaseSystemBIOS.sh
        source scripts/postInstall.sh
    fi
    umount -R /mnt
    exit 0
else
    exit 1
fi
