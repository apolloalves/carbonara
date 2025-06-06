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
BACKESSENCIAL='/bin/carbo__BackupEssencials.sh'
BACKSYSTEMFOLDER='/bin/carbo__BackupSystemFolder.sh'
BACKTESTINTEGRITY='/bin/carbo__BackupTestIntegrity.sh'
BACKCLONRAID='/bin/carbo__ClonraidBackups.sh'
BACKRESTORE='/bin/carbo__RestoreEssencials.sh'
CHECKSPACE='/bin/carbo__CheckSpace.sh'

BACKUPMENU='/bin/carbo__ArchBackupWizard.sh'

LINE_SCRIPT='carbo__LineScript.sh'
echo -e "\033[1;97;100m               Carbonara           \033[0m\033[1;30;107m        Apollo Alves        \033[1;97;44m          Backup Wizard     \033[0m"

echo
echo -e "\033[01;97m Input an option from the menu: \033[0m"
$LINE_SCRIPT
echo

echo -e "\033[1;34m[\033[01;37m 1\033[01;34m ]\033[00;37m - Create Backup Essecials\033m"
echo -e "\033[1;34m[\033[01;37m 2\033[01;34m ]\033[00;37m - Create Backup Personal\033m"
echo -e "\033[1;34m[\033[01;37m 3\033[01;34m ]\033[00;37m - Check Backup Integrity\033m"
echo -e "\033[1;34m[\033[01;37m 4\033[01;34m ]\033[00;37m - Check Clonraid Backups\033m"
echo -e "\033[1;34m[\033[01;37m 5\033[01;34m ]\033[00;37m - Restore Essential Backups\033m"
echo -e "\033[1;34m[\033[01;37m 6\033[01;34m ]\033[00;37m - Check Space Disks\033m"


echo -e "\033[1;34m[\033[01;37m E\033[01;34m ]\033[00;37m - Exit\033m"
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
            $BACKESSENCIAL
            ;;
        2)
            $ACKSYSTEMFOLDER
            ;;
        3)
            $BACKTESTINTEGRITY
            ;;
        4)
            $BACKCLONRAID
            ;;
        5)
            $EGGSINSTALL
            ;;
        6) 
            $BACKRESTORE
            ;;
        7)    
            $CHECKSPACE
            ;;
           
        *)
            echo -e "\nInvalid input! Please enter the number contained in the menu!.\n"
            ;;
        esac

        read -rsn1 -p "Press any key to continue..."

        $BACKUPMENU

    fi
else
    echo -e '\nBye!'
    sleep 1 
    $MENU
fi
