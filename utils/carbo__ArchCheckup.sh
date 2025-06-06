#!/bin/bash

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

