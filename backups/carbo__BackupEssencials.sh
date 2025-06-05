#!/bin/bash
#######################################################################################
# Carbonara                                                                           #
# Script: carbo__BackupPersonal.sh                                                    #
# Author: Apollo Alves                                                                #
# Date  : 21/11/2024                                                                  #
# Description: Executes rsync backups for essential system/user files with logs.      #
#######################################################################################

source 'carbo__verifyRoot.sh'

MENU='/bin/carbonara.sh'
DESTINOROOT="/bak"
DESTINOEMERGENCY="/mnt/BACK_EMERGENCY/bak"


clear

# Função spinner sincronizado com o processo
spinner() {
    local pid=$1
    local delay=0.3
    local spinstr='|/-\'
    while kill -0 "$pid" 2>/dev/null; do
        local temp=${spinstr#?}
        printf " [%c]  \r" "$spinstr"
        spinstr=$temp${spinstr%"$temp"}
        sleep $delay
    done
}

### BACKUP ESSENCIAL
echo -e "\n\033[1;33mEXECUTING BACKUP FILES ESSENCIALS FOLDER\033[0m"

backup_files=(
    /boot/grub/grub.cfg
    "/home/apollo/.bashrc"
    "/home/apollo/.bash_profile"
    /etc/fstab
    /etc/pacman.conf
    /etc/pacman.d/mirrorlist
    /etc/default/grub
    /etc/mkinitcpio.conf
    /etc/pipewire/pipewire.conf
    /etc/pipewire/pipewire-pulse.conf
    /etc/pipewire/media-session.d/*
    /home/apollo/.config/pipewire/pipewire.conf
    /home/apollo/.config/pipewire/pipewire-pulse.conf
)

for DEST_BAK in "$DESTINOROOT" "$DESTINOEMERGENCY"; do
    echo -e "\n\033[1;36mBackup para $DEST_BAK\033[0m"
    rsync -aAXHh "${backup_files[@]}" "$DEST_BAK/" >> /var/log/backupEssencials.log 2>> /var/log/backupEssencials.error.log &
    RSYNC_PID=$!
    spinner $RSYNC_PID
    wait $RSYNC_PID
done

echo -e "\n\033[1;32mBackup files essenciais concluído para ambos os destinos.\033[0m\n"

echo -e "\nAbrindo logs...\n"
sleep 2
sudo kgx --tab -e "cat /var/log/backupEssencials.log" >/dev/null 2>&1

clear
echo -e "\033[1;32;5mBackup Completed Successfully!\033[0m"
