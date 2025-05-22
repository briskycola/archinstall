# Arch Linux Installer
This is a script that installs Arch Linux with a minimal
version of the KDE Desktop Environment with only the
programs you need. It is designed for new users who want
a minimal Arch + KDE installation without doing the
manual configuration. Advanced users who already have
an understanding of Arch Linux, but don't want to
manually install the OS can also benefit from this script.

## Prerequisite
You must be connected to the internet when booted from
the ISO. If you are connecting via Ethernet, you should
be good to go. For those connecting via Wi-Fi, you will
have to run the following command to connect to the
Internet.

```bash
iwctl --passphrase <passphrase> station <name> connect <SSID>
```

1. *passphrase*: your Wi-Fi password
1. *name*: the name of your network interface
(to get this, type `ip a` and you should see an interface
titled wlan* or wlp*)
1. *SSID*: the name of your Wi-Fi network
(put "" in between the SSID if it has spaces)

If you don't see an interface, it's likely that the Arch
ISO does not have a driver for your Wi-Fi adapter. To get
around this, you can either connect via Ethernet or
connect an Android phone to your computer and enable
USB Tethering.

## Install
To begin the installation, we first need to install the
following packages to the ISO.
```bash
pacman -Sy --noconfirm git dialog
```

Then we will download and run the install script
```bash
git clone https://github.com/briskycola/archinstall
cd archinstall/
./install.sh
```
