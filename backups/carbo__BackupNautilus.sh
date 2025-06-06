#!/bin/bash
################################################################################
# Carbonara                                                                    #
# Script: carbo__BackupManager.sh		                               #
# Invoke Nautilus by opening a specific directory.                             #
# Author: Apollo Alves                                                         #
# Date  : 21/11/2024                                   			       #
################################################################################

# Check if the user is root
source 'carbo__verifyRoot.sh'

# Directory path
mount /dev/sdd1 /mnt/VENTOY >/dev/null 2>&1
mount /dev/sdd3 /mnt/MDSATA/ >/dev/null 2>&1
echo -e "\nAll devices are mounted!"

# Check if Nautilus processes are running
if pgrep -x "nautilus" >/dev/null; then

    echo "Terminating Nautilus processes..."
    pkill -f "nautilus" >/dev/null 2>&1

    # Wait until Nautilus processes are completely closed
    while pgrep -x "nautilus" >/dev/null; do
        echo -n "."
        sleep 1
    done
fi

# Open Nautilus in the specified directory
echo -e "\nOpening Nautilus...\n"
nautilus /mnt/VENTOY >/dev/null 2>&1 &


