!#/bin/bash

# variables
yay="https://aur.archlinux.org/yay.git"
yayDir="./yay"

# function
cloneFunction () {
    git clone $1
}

# Install yay as AUR helper
cloneFunction $yay

if [ ! -d "$yayDir" ]; then
    echo "failed to clone yay repo"
else
    # move and build
    cd $yayDir
    ls -la ./
    #makepkg -si

    # Check yay version
    yay --version

    # Return to parent directory
    cd ../
fi

echo "$(pwd)"

# Add flathub as remote for flatpaks
flatpak remote-add flathub https://flathub.org/repo/flathub.flatpakrepo

# Install flatpaks
xargs flatpak --user install -y < ./flatpak.txt