#!/bin/bash

# Arch Linux install script
# by Santiago Torres

arch-chroot /mnt /bin/bash << EOF

# Install GPU drivers
case $GPU_DRIVER in
    "amdgpu")
    pacman -S --noconfirm xf86-video-amdgpu mesa vulkan-radeon
    ;;

    "ati")    
    pacman -S --noconfirm xf86-video-ati mesa
    ;;

    "intel")
    pacman -S --noconfirm xf86-video-intel mesa vulkan-intel
    ;;

    "nvidia-open")
    pacman -S --noconfirm nvidia-open nvidia-utils nvidia-settings
    ;;

    "nouveau")
    pacman -S --noconfirm xf86-video-nouveau mesa vulkan-nouveau
    ;;

    "qemu")
    pacman -S --noconfirm xf86-video-qxl qemu-hw-display-qxl \
    qemu-hw-display-virtio-gpu vulkan-virtio
    ;;

    "vmware")
    pacman -S --noconfirm open-vm-tools xf86-video-vmware \
    xf86-input-vmmouse mesa
    systemctl enable vmtoolsd
    ;;

    "virtualbox")
    pacman -S --noconfirm virtualbox-guest-tools mesa
    systemctl enable vboxservice
    ;;
esac

# Install Pipewire
pacman -S --noconfirm pipewire pipewire-pulse pipewire-alsa \
    pipewire-jack wireplumber \

# Install KDE
pacman -S --noconfirm plasma-desktop dolphin dolphin-plugins \
ffmpegthumbs ark konsole okular gwenview kscreen \
firefox mpv yt-dlp ffmpeg zed kde-gtk-config breeze-gtk \
plasma-pa plasma-nm power-profiles-daemon htop \
partitionmanager ufw plasma-firewall sddm sddm-kcm

# Check for Bluetooth support and install
# Bluetooth utilities if supported
dmesg | grep -i bluetooth
if [ $? -eq 0 ]; then
    pacman -S --noconfirm bluez bluez-utils bluedevil
    systemctl enable bluetooth
fi

# Configure UFW
ufw default deny incoming
ufw default allow outgoing

# Enable UFW and SDDM on startup
ufw enable
systemctl enable ufw
systemctl enable sddm

EOF
