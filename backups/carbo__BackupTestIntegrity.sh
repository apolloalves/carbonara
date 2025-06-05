#!/bin/bash
#######################################################################################
# Carbonara Turbo                                                                     #
# Script: carbo__TestBackup.sh                                                        #
# Author: Apollo Alves                                                                #
# Date  : 21/11/2024                                                                  #
# Description: Valida se os arquivos essenciais estão no backup e verifica integridade#
#######################################################################################

source 'carbo__verifyRoot.sh'

DESTINO="/mnt/MDSATA"
DEST_BAK="$DESTINO/ESSENCIALS"

LOG="/var/log/testBackupEssencials.log"
ERROR_LOG="/var/log/testBackupEssencials.error.log"

# Lista de arquivos e diretórios para verificar
declare -a ARQUIVOS=(
    "/boot/grub/grub.cfg"
    "/etc/fstab"
    "/etc/pacman.conf"
    "/etc/pacman.d/mirrorlist"
    "/etc/default/grub"
    "/etc/mkinitcpio.conf"
    "/etc/pipewire"
)

# Verifica se o SSD está montado
if ! mountpoint -q "$DESTINO"; then
    echo -e "\n\033[1;31m[ERROR] O destino $DESTINO não está montado!\033[0m"
    exit 1
fi

# Limpa logs anteriores
rm -f "$LOG" "$ERROR_LOG"
touch "$LOG" "$ERROR_LOG"

echo -e "\n\033[1;34m[INFO] Iniciando verificação dos arquivos no backup...\033[0m"

ERROS=0
DIVERGENCIAS=0

for ITEM in "${ARQUIVOS[@]}"; do
    BACKUP_PATH="$DEST_BAK/.$ITEM"

    if [ ! -e "$BACKUP_PATH" ]; then
        echo -e "\033[1;31m[✘] FALTANDO: $ITEM\033[0m" | tee -a "$ERROR_LOG"
        ((ERROS++))

        # Pergunta se quer restaurar
        read -rp "Deseja restaurar $ITEM? (s/N) " RES
        if [[ $RES =~ ^[Ss]$ ]]; then
            echo "Restaurando $ITEM..."
            mkdir -p "$(dirname "$ITEM")"
            rsync -aAXH "$BACKUP_PATH" "$(dirname "$ITEM")"
            echo "Arquivo restaurado."
        fi

    else
        # Verifica se é arquivo ou diretório
        if [ -f "$ITEM" ]; then
            ORIG_HASH=$(sha256sum "$ITEM" | awk '{print $1}')
            BACK_HASH=$(sha256sum "$BACKUP_PATH" | awk '{print $1}')

            if [[ "$ORIG_HASH" == "$BACK_HASH" ]]; then
                echo -e "\033[1;32m[✔] OK: $ITEM\033[0m" | tee -a "$LOG"
            else
                echo -e "\033[1;33m[⚠️] DIVERGENTE: $ITEM\033[0m" | tee -a "$ERROR_LOG"
                ((DIVERGENCIAS++))

                read -rp "Arquivo divergente. Deseja restaurar $ITEM do backup? (s/N) " RES
                if [[ $RES =~ ^[Ss]$ ]]; then
                    echo "Restaurando $ITEM..."
                    mkdir -p "$(dirname "$ITEM")"
                    rsync -aAXH "$BACKUP_PATH" "$(dirname "$ITEM")"
                    echo "Arquivo restaurado."
                fi
            fi
        else
            # Se for diretório, apenas verifica existência
            echo -e "\033[1;34m[INFO] Pasta presente no backup: $ITEM\033[0m" | tee -a "$LOG"
        fi
    fi
done

# Resultado final
echo -e "\n\033[1;33m[INFO] Verificação concluída.\033[0m"

if [[ $ERROS -eq 0 && $DIVERGENCIAS -eq 0 ]]; then
    echo -e "\033[1;32m[✔] Backup perfeito! Todos os arquivos presentes e íntegros.\033[0m"
else
    echo -e "\033[1;31m[✘] Atenção! $ERROS ausente(s) e $DIVERGENCIAS divergente(s). Veja o log.\033[0m"
fi

# Abre o log no terminal
sleep 2
sudo kgx --tab -e "cat $LOG" >/dev/null 2>&1

exit 0

