#!/bin/bash
# Check if the user is root
source 'carbo__verifyRoot.sh'

# Function to print status
print_status() {
    if [ "$?" -eq 0 ]; then
        printf "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n\n"
    else
        printf "[ \033[01;31mFAILED\033[01;37m ]\n\n"
    fi
}

clear
echo
echo "FULL SYSTEM CLEAN-UP - ARCH LINUX"
echo "-------------------------------------------"

# -------------------------
# 0. Clean broken or partial pacman cache files
# -------------------------
echo "Removing broken or partial pacman packages from cache..."
echo "------------------------------------------------------------"
sudo find /var/cache/pacman/pkg/ -type f \( -name "*.part" -o -size -1M \) -exec rm -fv {} \;
sudo find /var/cache/pacman/pkg/ -type f ! -name "*.sig" ! -name "*.pkg.tar.zst" -exec rm -fv {} \;
echo
print_status
echo
# Disk space before clean-up
echo "Calculating disk space before clean-up..."
space_before=$(df -h / | awk 'NR==2 {print $4}')
echo "Free space before: $space_before"
echo
print_status

# 1. Remove orphan packages
echo "Checking for orphan packages..."
echo "-------------------------------------------"
orphans=$(pacman -Qtdq)

if [[ -n "$orphans" ]]; then
    echo "Removing orphan packages..."
    sudo pacman -Rns $orphans
else
    echo "No orphan packages found."
fi
echo
print_status

# 2. Clean pacman cache
echo "Cleaning pacman cache (keeping the latest version)..."
echo "-------------------------------------------------------"
sudo paccache -r -k1
rm -rfv /var/lib/apt/lists/lock
rm -rfv /var/lib/dpkg/lock-frontend
rm -rfv /var/lib/apt/lists/*
rm -rfv ~/.cache/thumbnails/*
rm -rfv ~/.cache/thumbnails/normal/*
rm -rf ~/.cache/icon*
rm -rfv /var/cache/apt/archives/lock
rm -rfv ~/.cache/tracker/
rm -Rfv /var/log/*
find /var/log/ ! -name 'syslog' -type f -exec rm -fv {} +
echo
print_status

# 3. Clean AUR cache
if command -v yay &> /dev/null; then
    echo "Cleaning yay cache..."
    yay -Sc --noconfirm
elif command -v paru &> /dev/null; then
    echo "Cleaning paru cache..."
    paru -Sc --noconfirmss
else
    echo "No AUR helper detected (yay, paru...)"
fi
echo
print_status

# 4. Clean Flatpak (if installed)
if command -v flatpak &> /dev/null; then
    echo "Cleaning Flatpak unused packages..."
    flatpak uninstall --unused -y
    sudo rm -rf /var/tmp/flatpak-cache-*
else
    echo "No Flatpak detected."
fi
echo
print_status
# 5. Clean Brave browser cache
echo "Cleaning Brave browser cache..."
echo "-------------------------------------------"
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/Cache/*
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/Code\ Cache/js/*
rm -rf ~/.cache/BraveSoftware/Brave-Browser/Default/GPUCache/*
rm -rf ~/.config/B

print_status

