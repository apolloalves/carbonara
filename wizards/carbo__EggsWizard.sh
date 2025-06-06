#!/bin/bash
################################################################################
# Carbonara                                                                    #
# Script: carbo__EggsWizard.sh                                                 #
# Author: Apollo Alves                                                         #
# Date  : 21/11/2024                                                           #
#                                                                              #
# Description:                                                                 #
# This script serves as a menu for managing Penguin's Eggs, providing options  #
# to create, check, and open files with                                        #
# broot or Nautilus file managers. It also allows installation of              #
# Penguin's Eggs and Calamares.                                                #
################################################################################

# Check if the user is root
source 'carbo__verifyRoot.sh'

clear
MENU='/bin/carbonara.sh'
EGGSCREATE='/bin/carbo__EggsCreate.sh'
EGGSCHECK='/bin/carbo__EggsCheck.sh'
EGGSBROOT='/bin/carbo__ShowBrootEggs.sh'
EGGSINSTALL='/bin/carbo__EggsInstall.sh'
MANAGER='/bin/carbo__BackupManager.sh'
EGGSMENU='/bin/carbo__EggsWizard.sh'

LINE_SCRIPT='carbo__LineScript.sh'
echo -e "\033[1;97;100m               carbonara            \033[0m\033[1;30;107m        Apollo Alves        \033[1;97;100m        Penguin's Eggs Wizard       \033[0m"

echo
echo -e "\033[01;97m Input an option from the menu: \033[0m"
$LINE_SCRIPT
echo
echo -e "\033[01;32m[\033[01;37m 1\033[01;32m ]\033[00;37m - Create Penguin's Eggs\033m"
echo -e "\033[01;32m[\033[01;37m 2\033[01;32m ]\033[00;37m - Check Penguin's Eggs .iso\033m"
echo -e "\033[01;32m[\033[01;37m 3\033[01;32m ]\033[00;37m - Open my Penguin's Eggs Files - broot file manager\033m"
echo -e "\033[01;32m[\033[01;37m 4\033[01;32m ]\033[00;37m - Open my Penguin's Eggs Files - Nautilus file manager\033m"
echo -e "\033[01;32m[\033[01;37m 5\033[01;32m ]\033[00;37m - Penguin's Eggs and Calamares Install \033m"
echo -e "\033[01;32m[\033[01;37m E\033[01;32m ]\033[00;37m - Exit\033m"
echo
$LINE_SCRIPT
formatted_prompt=$(printf "\e[1;97mInput option :\e[0m ")
read -p "$formatted_prompt" option_choice

$LINE_SCRIPT

valid_option=true

if [ "$option_choice" != "e" ] && [ "$option_choice" != "E" ]; then

    if [ "$valid_option" = true ]; then

        case "$option_choice" in

        1)
            $EGGSCREATE
            ;;
        2)
            $EGGSCHECK
            ;;
        3)
            sudo mount /dev/sdd3 /mnt/MDSATA/ >/dev/null 2>&1
            $EGGSBROOT
            ;;
        4)
            $MANAGER
            ;;
        5)
            $EGGSINSTALL
            ;;
        
        *)
            echo -e "\nInvalid input! Please enter the number contained in the menu!.\n"
            ;;
        esac

        read -rsn1 -p "Press any key to continue..."

        $EGGSMENU

    fi
else
    echo -e '\nBye!'
    sleep 1 
    $MENU
fi
