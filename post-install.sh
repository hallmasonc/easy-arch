!#/bin/bash

# Uncomment multilib repo
sed -i "/\[multilib\]/,/Include/"'s/^#*//' /etc/pacman.conf

# Install pacman packages
sudo pacman -S --needed - < ./pacman.txt

# Variables
yay="https://aur.archlinux.org/yay.git"
yayDir="./yay"

# Function
cloneFunction () {
    git clone $1
}

# Install yay as AUR helper
cloneFunction $yay

if [ ! -d "$yayDir" ]; then
    echo "failed to clone yay repo"
else
    # Move directory and build
    cd $yayDir
    makepkg -si

    # Return to parent directory
    cd ../

    # Install yay packages
    yay -S --needed - < ./yay.txt
fi

echo "$(pwd)"

# Add flathub as remote for flatpaks
flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

# Install flatpaks
xargs flatpak --user install -y < ./flatpak.txt