#!/bin/bash
#######################################################################################
# Carbonara                                                                           #
# Script: carbo__BackupEssencials.sh                                                  #
# Author: Apollo Alves                                                                #
# Date  : 21/11/2024                                                                  #
# Description: Executes rsync backups for essential system/user files with logs.      #
#######################################################################################



# Ambiente gráfico para notify-send funcionar via cron
export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/$(id -u apollo)/bus"


source '/bin/carbo__verifyRoot.sh'


DESTINOROOT="/bak/"
DESTINOEMERGENCY="/mnt/MDSATA/ESSENCIALS/"


#clear

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


NotifySend() {

    local SOUND="/usr/share/sounds/freedesktop/stereo/service-logout.oga"
    sudo -u apollo DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" \
        paplay "$SOUND" 2>/dev/null || true
    sudo -u apollo DISPLAY=:0 DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus" \
        notify-send -i dialog-information "Backup Essencials" "Concluído com sucesso!" 2>/dev/null || true
}



backup_files=(
     
    /root/.bashrc
    /boot/grub/grub.cfg
    /etc/default/grub
    /etc/fstab
    /etc/pacman.conf
    /etc/pacman.d/mirrorlist
    /etc/default/grub
    /etc/mkinitcpio.conf
    /etc/pipewire/pipewire.conf
    /etc/pipewire/pipewire-pulse.conf
    /home/apollo/.bashrc
    /home/apollo/.bash_profile
    /home/apollo/.config/pipewire/pipewire.conf
    /home/apollo/.config/pipewire/pipewire-pulse.conf
)

# Inclui arquivos do media-session.d, se houver
if [[ -d /etc/pipewire/media-session.d ]]; then
    for file in /etc/pipewire/media-session.d/*; do
        [[ -e "$file" ]] && backup_files+=("$file")
    done
fi

wait

for DEST_BAK in "$DESTINOROOT" "$DESTINOEMERGENCY"; do
   
rsync -aAXHRv --ignore-missing-args --log-file=/var/log/rsync.carbo.log "${backup_files[@]}" "$DEST_BAK/" >> /var/log/backupEssencials.log 2>> /var/log/backupEssencials.error.log

  
done

echo "$(date) - Backup critical concluído para ambos os destinos | /bak | /mnt/MDSATA/ESSENCIALS"
NotifySend
 
