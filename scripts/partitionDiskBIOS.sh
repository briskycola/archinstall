#!/bin/bash

# Arch Linux install script
# by Santiago Torres

# Partition the disk using parted
parted -s /dev/$DISK mklabel msdos
parted -s /dev/$DISK mkpart primary $FILESYSTEM 1MiB 100%

# Make the filesystem
mkfs.$FILESYSTEM /dev/${DISK}1

# Mount the filesystem
mount /dev/${DISK}1 /mnt
