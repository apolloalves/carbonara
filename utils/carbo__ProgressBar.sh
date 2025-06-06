#!/bin/bash
################################################################################
# Carbonara                                                                    #
# Script: carbo__ProgressBar.sh                                                #
# Author: Apollo Alves                                                         #
# Date  : 21/11/2024                                                           #
# Description: Shows a progress bar.                                           #
################################################################################

clear
# Exibe mensagem em amarelo negrito
echo -e "\n\033[1;33mEXECUTING BACKUP OF ROOT FOLDER\033[0m"

(
    # Loop de progresso
    while true; do
        for i in {0..100}; do
            # Imprime a porcentagem
            echo -ne "\rProgress: $i% ["
            # Imprime a barra de progresso
            for ((j=0; j<i/2; j++)); do
                echo -n "="
            done
            for ((j=i/2; j<50; j++)); do
                echo -n " "
            done
            echo -n "]"
            sleep 0.1
        done
        break
    done
) &

# Store the PID of the loop process
LOOP_PID=$!

# Exec anyway here!
# When the backup is complete, the loop is terminated
kill $LOOP_PID
