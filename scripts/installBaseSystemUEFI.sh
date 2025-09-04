#!/bin/bash

# Arch Linux install script
# by Santiago Torres

# Determine which CPU microcode to install
case "$(lscpu | grep "Vendor ID")" in
    *GenuineIntel*)
    MICROCODE="intel-ucode"
    ;;

    *AuthenticAMD*)
    MICROCODE="amd-ucode"
    ;;
esac

# Install base packages
pacstrap -K /mnt base base-devel linux linux-firmware linux-headers vim $MICROCODE

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab

# Chroot into the install
arch-chroot /mnt /bin/bash << EOF

# Set timezone and adjust hardware clock
ln -sf /usr/share/zoneinfo/$REGION/$CITY /etc/localtime
hwclock --systohc

# Set locale
echo "${LOCALE}.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=${LOCALE}.UTF-8" > /etc/locale.conf

# Network Configuration
echo "$HOSTNAME" > /etc/hostname
cat << EOL > /etc/hosts
127.0.0.1    localhost
::1          localhost
127.0.0.1    $HOSTNAME.localdomain    $HOSTNAME
EOL

# Set root password
printf "$PASSWORD\n$CONFIRM_PASSWORD" | passwd

# Setup User
useradd -mG wheel,audio,video,storage $USERNAME
printf "$PASSWORD\n$CONFIRM_PASSWORD" | passwd $USERNAME

# Install GRUB along with other necessary programs
pacman -S --noconfirm grub efibootmgr \
    dosfstools e2fsprogs btrfs-progs xfsprogs networkmanager sudo

# Setup GRUB Bootloader
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id="Arch Linux"
grub-mkconfig -o /boot/grub/grub.cfg

# Update sudo permissions to allow the user to use sudo
sed -i 's/^# %wheel ALL=(ALL:ALL) ALL/%wheel ALL=(ALL:ALL) ALL/' /etc/sudoers

# Enable services
systemctl enable NetworkManager

EOF
