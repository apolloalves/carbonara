#!/bin/bash
#######################################################################################
# Carbonara                                                                           #
# Script: carbo__BackupPersonal.sh                                                    #
# Author: Apollo Alves                                                                #
# Date  : 21/11/2024                                                                  #
# Description: Executes rsync backups for folders: / and /home with logs.            #
#######################################################################################

# Verifica se o script está sendo executado como root
source 'carbo__verifyRoot.sh'

MENU='/bin/carbonara.sh'
DESTINO="/mnt/MDSATA"
DEST_BAK="$DESTINO/ESSENCIALS"


clear

# Verifica se o SSD de destino está montado
if ! mountpoint -q "$DESTINO"; then
    echo -e "\n\033[1;31mErro: O destino $DESTINO não está montado!\033[0m"
    exit 1
fi

# Função para exibir barra de progresso em background
progresso() {
    while true; do
        for i in {0..100}; do
            echo -ne "\rProgress: $i% ["
            for ((j=0; j<i/2; j++)); do echo -n "="; done
            for ((j=i/2; j<50; j++)); do echo -n " "; done
            echo -n "]"
            sleep 0.1
        done
        break
    done
}

### BACKUP  (/)
echo -e "\n\033[1;33mEXECUTING BACKUP FILES ESSENCIALS FOLDER\033[0m"
progresso & LOOP_PID=$!

rsync -aAXHh --progress \
    --relative \
    /boot/grub/grub.cfg \
    "/home/apollo/.bashrc" \
    "/home/apollo/.bash_profile" \
    /etc/fstab \
    /etc/pacman.conf \
    /etc/pacman.d/mirrorlist \
    /etc/default/grub \
    /etc/mkinitcpio.conf \
    /etc/pipewire/ \
    "/home/apollo/.config/pipewire/" \
    "$DEST_BAK/" >> /var/log/backupEssencials.log 2>> /var/log/backupEssencials.error.log

    
kill $LOOP_PID
echo -e "\n\033[1;32mBackup files essencilas completed...\033[0m\n"

# Exibe os logs
echo -e "\nOpening logs...\n"
sleep 2
sudo kgx --tab -e "cat /var/log/backupEssencials.log" >/dev/null 2>&1
#sudo kgx --tab -e "cat /var/log/backupEssencials.log" >/dev/null 2>&1

clear
echo -e "\033[1;32;5mBackup Completed Successfully!\033[0m"




