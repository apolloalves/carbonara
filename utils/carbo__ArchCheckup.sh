#!/bin/bash
#################################################################################
# Carbonara                                                                     #
# Script: carbo__ArchCheckup.sh                                                 #
# Author: Apollo Alves                                                          #
# Date  : 08/06/2025                                                            #
#                                                                               #
# Description:                                                                  #
#This script performs a general check of your Arch Linux system and generates a #
#log of the results. It identifies corrupted packages, orphaned dependencies,   #
#manually installed AUR packages, modified files, failed services, and recent   #
#system errors.								        #
#									        #
#It also displays RAID status, checks disk integrity via SMART, and tests the   #
#speed of pacman mirrors. When finished, it saves everything to a log file and  #
#returns to the main menu.                                                      #
#################################################################################

# Check if the user is root
source 'carbo__verifyRoot.sh'
MENU='/bin/carbonara.sh'

LOG="$HOME/arch_checkup_$(date +%F_%H-%M-%S).log"

echo "=== Arch Linux System Checkup ===" | tee "$LOG"
echo "Date: $(date)" | tee -a "$LOG"
echo "User: $(whoami)" | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 1. Corrupted packages
echo ">>> Packages with missing or corrupted files:" | tee -a "$LOG"
sudo pacman -Qk | grep -v '0 missing' | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 2. Orphaned dependencies
echo ">>> Installed orphaned dependencies:" | tee -a "$LOG"
sudo pacman -Qtdq 2>/dev/null | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 3. Untracked AUR packages
echo ">>> Manually installed packages (AUR or local):" | tee -a "$LOG"
yay -Qm | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 4. Altered/corrupted files
echo ">>> Modified files in packages:" | tee -a "$LOG"
sudo pacman -Qkk | grep -v '0 altered files' | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 5. Failed systemd services
echo ">>> Failed systemd services:" | tee -a "$LOG"
systemctl --failed | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 6. Recent error logs
echo ">>> Recent journal error logs (priority: error):" | tee -a "$LOG"
journalctl -p 3 -xb | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 7. RAID status
echo ">>> RAID status (/proc/mdstat):" | tee -a "$LOG"
cat /proc/mdstat | tee -a "$LOG"
echo "" | tee -a "$LOG"

# 8. SMART status for SSDs (adjust as needed)
for disk in /dev/sd?; do
    echo ">>> SMART status for $disk:" | tee -a "$LOG"
    sudo smartctl -H "$disk" | tee -a "$LOG"
    echo "" | tee -a "$LOG"
done

# 9. Pacman mirror speed test
echo ">>> Testing fastest pacman mirrors (does not modify system):" | tee -a "$LOG"
reflector --verbose --latest 10 --sort rate | tee -a "$LOG"
echo "" | tee -a "$LOG"

echo ">>> System check completed. Log saved to: $LOG"


read -rsn1 -p "Press any key to continue..."
$MENU

