!#/bin/bash

# variables
yay="https://aur.archlinux.org/yay.git"

# function
cloneFunction () {
    git clone $1
}

# Install yay as AUR helper
cloneFunction $yay
cd yay
ls -la ./
#makepkg -si