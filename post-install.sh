#!/bin/bash

# Uncomment multilib repo
sudo sed -i "/\[multilib\]/,/Include/"'s/^#*//' /etc/pacman.conf

# Force pacman database update
sudo pacman -Syy

# Install pacman packages
sudo pacman -S --needed - < ./pacman.txt

# Variables
yay="https://aur.archlinux.org/yay.git"
yayDir="/opt"

# Function
cloneFunction () {
    git clone $1 $2
}

# Install yay as AUR helper
cloneFunction $yay $yayDir

if [ ! -d "$yayDir" ]; then
    echo "failed to clone yay repo"
else
    # Move directory and build
    cd $yayDir
    makepkg --noconfirm -si

    # Return to home directory
    cd ~/

    # Install yay packages
    yay -S --needed - < ./yay.txt
fi

# Add flathub as remote for flatpaks
flatpak remote-add --user flathub https://flathub.org/repo/flathub.flatpakrepo

# Install flatpaks
xargs flatpak --user install -y < ./flatpak.txt

# Enable lightdm service
sudo systemctl enable lightdm.service