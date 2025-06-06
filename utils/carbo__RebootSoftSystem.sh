#!/bin/bash
################################################################################
# Carbonara                                                                    #
# Script: carbo__RebootSystem.sh                                               #
# Author: Apollo Alves                                                         #
# Date  : 21/11/2024                                                           #
#                                                                              #
# Description: 	Reboot System Script                                           #
# This script prompts the user if they want to restart the system  and         #
# initiates the reboot if the user chooses 'y'. It also handles invalid input  #
# and provides appropriate messages. Requires root  privileges to run.         #
################################################################################

#Check if the user is root
source 'carbo__verifyRoot.sh'

MENU="carbonara.sh"
YES="y"
NO="n"

echo
echo -n 'Do you want to restart the system now? (y/n) ? '
read -r rebootSystem

if [ "$rebootSystem" = "$YES" ]; then
     
      #reboot now
      systemctl soft-reboot


fi

if [ "$rebootSystem" = "$NO" ]; then
     echo -e "\n\033[01;37m[\033[00;32m \033[01mOK\033[00;32m\033[01;37m ]\033[00m\n"    
     sleep 2
     $MENU
    
elif [ "$rebootSystem" != "$YES" ] && [ "$rebootSystem" != "$NO" ]; then
    
    echo -e "\nInvalid input! Please enter 'y' or 'n'.\n"
    sleep 2
    $MENU

fi

