#!/bin/bash
################################################################################
# Carbonara                                                                    #
# Script: carbonara.sh                                                         #
# Author: Apollo Alves                                                         #
# Date  : 06/06/2025                                                           #
#									       #
# Description: Multifunctional tool designed to simplify and automate          #
# administration tasks on Linux.                                               #
################################################################################

source ~/.bashrc

# Check if the user is root
source 'carbo__verifyRoot.sh'
clear

#Imports
source '/bin/carbo__MenuItem.sh'
source '/bin/carbo__LineScript.sh'

MENU='/bin/carbonara.sh'
read -p $'\033[01;33m Input option : \033[0m' option_choice

$LINE
valid_option=true

if [ "$option_choice" != "e" ] && [ "$option_choice" != "E" ]; then

    if [ "$valid_option" = true ]; then
        echo -e "\n\033[01;33mThe option: $option_choice will be executed:\033[0m\n"

        case "$option_choice" in

        1)
            carbo__ArchCheckup.sh
            ;;
        2)
            carbo__ArchDeepClean.sh
            ;;
        3)
            carbo__ArchBackupWizard.sh
            ;;
	
	4)  carbo__EggsWizard.sh
	    ;;
	
	5)  carbo__ServicesWizard.sh
	    ;;
	
	6) carbo__ReportSystem.sh
	   ;;
	   
	7) carbo__RebootSoftSystem.sh
	   ;;
	      
        *)
            echo -e "\033[01;05;37m'$option_choice' command not found!\033[00m\n"
            sleep 2
           $MENU
            ;;
        esac

    else
        echo -e "\nops!\n"
        echo -e "\033[01;05;37m'$option_choice' command not found!\033[00m\n"
        echo -e "Invalid input! Please enter 'y' or 'n'.\n"
    fi
else
    echo
    echo "Exiting the program..."
    echo "Bye!"
    sleep 2
    clear
fi
