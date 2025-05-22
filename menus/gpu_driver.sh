#!/bin/sh

# Arch Linux install script
# by Santiago Torres

# Prompt the user to select the driver
# that cooresponds to their GPU
while true; do
    export GPU_DRIVER=$(dialog \
        --title "GPU Driver" \
        --menu "Select the driver you wish to install" 16 70 1 \
        "amdgpu" "Southern Islands and later" \
        "ati" "Older AMD GPUs" \
        "intel" "Intel cards" \
        "nvidia" "Maxwell through Ada Lovelace" \
        "nvidia-open" "Turing and newer" \
        "nouveau" "Open source Nvidia drivers (for legacy cards)" \
        "qemu" "QEMU VirtIO/QXL" \
        "vmware" "VMware SVGA drivers" \
        "virtualbox" "VirtualBox VGA drivers" \
        3>&1 1>&2 2>&3) ; clear

    if [[ $GPU_DRIVER == "" ]]; then
        dialog --msgbox "You must select a GPU driver" 8 35
    else
        break
    fi
done
