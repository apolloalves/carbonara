#!/bin/bash
################################################################################
# Carbonara                                                         	       #
# Script: carbo__PerformanceWizard.sh                                          #
# Author: Apollo Alves                                                         #
# Date  : 21/11/2024                                                           #
################################################################################

# Check if the user is root
source 'carbo__verifyRoot.sh'
clear

MENU='/bin/carbonara.sh'
PERFORMANCE='/bin/carbo__PerformanceWizard.sh'

echo
LINE_SCRIPT='/bin/carbo__LineScript.sh'
echo -e "\033[1;97;100m        Carbonara          \033[0m\033[1;30;107m         Apollo Alves         \033[1;97;100m        Performance Wizard        \033[0m"
echo
echo -e "\033[01;97m Input an option from the menu: \033[0m"
$LINE_SCRIPT
echo
echo -e "\033[01;32m[\033[01;37m 01\033[01;32m ]\033[00;37m - View Swap State\033m"
echo -e "\033[01;32m[\033[01;37m 02\033[01;32m ]\033[00;37m - Cleanup Swap State\033m"
echo -e "\033[01;32m[\033[01;37m 03\033[01;32m ]\033[00;37m - Optimize Performance of System\033m"
echo -e "\033[01;32m[\033[01;37m 04\033[01;32m ]\033[00;37m - Cleanup Cache System\033m"
echo -e "\033[01;32m[\033[01;37m E\033[01;32m ]\033[00;37m  - Exit\033m"
echo
$LINE_SCRIPT

formatted_prompt=$(printf "\e[1;97mInput option :\e[0m ")
read -p "$formatted_prompt" option_choice
$LINE_SCRIPT

valid_option=true

if [ "$option_choice" != "e" ] && [ "$option_choice" != "E" ]; then

    if [ "$valid_option" = true ]; then
        echo -e "\033[05;31mThe option: $option_choice will be executed:\033[00;37m\n"

        case "$option_choice" in

        1)
           carbo__SwapState.sh
	   ;;
        2)
           carbo__CleanupSwap.sh
           ;;
        3)
           carbo__OptimizePerformance.sh
           ;;
 	4)
           carbo__PacmanCleanCache.sh
           ;;

        *)
            echo -e "\nInvalid input! Please enter the number contained in the menu!.\n"
            ;;
        esac
        read -rsn1 -p "Press any key to continue..."
	$PERFORMANCE
    fi
else

$MENU
fi
