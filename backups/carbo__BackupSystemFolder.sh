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
DEST_ROOT="$DESTINO/ROOT_BACKUP"
DEST_HOME="$DESTINO/HOME_BACKUP"

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

### BACKUP DA ROOT (/)
echo -e "\n\033[1;33mEXECUTING BACKUP OF ROOT FOLDER\033[0m"
progresso & LOOP_PID=$!

rsync -aAXHh --delete --progress \
    --exclude={"/proc/*","/sys/*","/dev/*","/tmp/*","/run/*","/lost+found","/home/*","$DEST_ROOT/*","$DEST_HOME/*"} \
    / "$DEST_ROOT/" >> /var/log/root_backup.log

kill $LOOP_PID
echo -e "\n\033[1;32mBackup folder root completed...\033[0m\n"

### BACKUP DA HOME (/home)
echo -e "\n\033[1;33mStarting backup of /home folder...\033[0m\n"
progresso & LOOP_PID=$!

rsync -aAXHh --delete --progress \
    --exclude={".local/share/Trash/*","apollo/.local/share/Trash/*","eggs/","node_modules/","package.json","package-lock.json","lost+found"} \
   /home/ "$DEST_HOME/" >> /var/log/home_backup.log

kill $LOOP_PID
echo -e "\n\033[1;32mBackup folder home completed...\033[0m\n"

# Exibe os logs
echo -e "\nOpening logs...\n"
sleep 2
sudo kgx --tab -e "cat /var/log/home_backup.log" >/dev/null 2>&1
sudo kgx --tab -e "cat /var/log/root_backup.log" >/dev/null 2>&1

clear
echo -e "\033[1;32;5mBackup Completed Successfully!\033[0m"
echo "Returning to the menu.."
sleep 5

$MENU

