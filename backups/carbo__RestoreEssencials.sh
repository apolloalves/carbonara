#!/bin/bash
#######################################################################################
# Carbonara                                                                           #
# Script: carbo__RestoreEssencials.sh                                                 #
# Author: Apollo Alves                                                                #
# Date  : 05/06/2025                                                                  #
# Description: Restore essential system files from backup with structure preserved.   #
#######################################################################################

# Verifica se está como root
source 'carbo__verifyRoot.sh'

DESTINO="/mnt/MDSATA/ESSENCIALS"

clear
echo -e "\n\033[1;33m[INFO] Iniciando restauração dos arquivos essenciais...\033[0m"

# Verifica se o SSD de destino está montado
if ! mountpoint -q "/mnt/MDSATA"; then
    echo -e "\n\033[1;31m[ERRO] O destino /mnt/MDSATA não está montado!\033[0m"
    exit 1
fi

# Confirmação antes de prosseguir
read -p $'\n\033[1;33mDeseja realmente restaurar os arquivos essenciais? (s/n): \033[0m' CONFIRMA

if [[ "$CONFIRMA" != "s" && "$CONFIRMA" != "S" ]]; then
    echo -e "\n\033[1;31mRestauração cancelada pelo usuário.\033[0m"
    exit 0
fi

# Executa restauração mantendo estrutura
rsync -aAXHhv --relative "$DESTINO"/./boot/grub/grub.cfg \
                               "$DESTINO"/./etc/fstab \
                               "$DESTINO"/./etc/pacman.conf \
                               "$DESTINO"/./etc/pacman.d/mirrorlist \
                               "$DESTINO"/./etc/default/grub \
                               "$DESTINO"/./etc/mkinitcpio.conf \
                               "$DESTINO"/./etc/pipewire/ \
                               / \
                               >> /var/log/restoreEssencials.log 2>> /var/log/restoreEssencials.error.log

echo -e "\n\033[1;32m[✔] Restauração concluída com sucesso!\033[0m"

# Pergunta se deseja regenerar o grub e o initramfs
read -p $'\n\033[1;33mDeseja atualizar o GRUB e o initramfs agora? (s/n): \033[0m' ATUALIZA

if [[ "$ATUALIZA" == "s" || "$ATUALIZA" == "S" ]]; then
    echo -e "\n\033[1;36m[INFO] Gerando novo grub.cfg...\033[0m"
    grub-mkconfig -o /boot/grub/grub.cfg

    echo -e "\n\033[1;36m[INFO] Gerando initramfs...\033[0m"
    mkinitcpio -P

    echo -e "\n\033[1;32m[✔] GRUB e initramfs atualizados com sucesso!\033[0m"
else
    echo -e "\n\033[1;33m[INFO] Atualização do GRUB e initramfs pulada.\033[0m"
fi

# Exibe o log
echo -e "\n\033[1;36mAbrindo log de restauração...\033[0m"
sleep 2
sudo kgx --tab -e "cat /var/log/restoreEssencials.log" >/dev/null 2>&1

clear
echo -e "\n\033[1;32;5m✔✔✔ Restauração Finalizada com Sucesso!\033[0m\n"

