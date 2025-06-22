#!/bin/bash

# Arch Linux install script
# by Santiago Torres

# Partition the disk using parted
parted -s /dev/$DISK mklabel gpt
parted -s /dev/$DISK mkpart primary fat32 1MiB 201MiB
parted -s /dev/$DISK set 1 esp on
parted -s /dev/$DISK mkpart primary $FILESYSTEM 201MiB 100%

# Check if the user is using an NVMe disk or a SATA disk
if [[ "$DISK" == *nvme* ]]; then
    # Make the filesystem
    mkfs.fat -F32    /dev/${DISK}p1
    mkfs.$FILESYSTEM /dev/${DISK}p2

    # Mount the filesystem
    mount /dev/${DISK}p2 /mnt
    mkdir -p             /mnt/boot/efi
    mount /dev/${DISK}p1 /mnt/boot/efi
else
    # Make the filesystem
    mkfs.fat -F32       /dev/${DISK}1
    mkfs.$FILESYSTEM    /dev/${DISK}2

    # Mount the filesystem
    mount /dev/${DISK}2 /mnt
    mkdir -p            /mnt/boot/efi
    mount /dev/${DISK}1 /mnt/boot/efi
fi
