#!/bin/bash
#############################################################################################
# Carbonara                                                                                 #
# Script: carbo__MenuItem.sh                                                                #
# Author: Apollo Alves                                                                      #
# Date  : 06/06/2025                                                      		    #
# 											    #
# Description:                                                                              #
# This bash script provides a menu with various system-related options for easy management. #
# Each option corresponds to a specific task, such as updating system packages,             #
# optimizing performance, checking system boot time, disabling native services, and more.   #   #                                                                                           #
#############################################################################################

LINE='/bin/carbo__LineScript.sh'
echo -e "\n\033[1;97;100m              Carbonara           \033[0m\033[1;30;107m        Apollo Alves        \033[1;97;100m         Arch Linux           \033[0m"

echo
neofetch
$LINE
echo -e "\033[01;97m Enter a menu option: \033[0m"
$LINE
echo
echo -e "\033[1;36m[\033[0m 1\033[1;36m ]\033[0m Arch Linux Audit Checkup"
echo -e "\033[1;36m[\033[0m 2\033[1;36m ]\033[0m Deep Clean Arch Linux"
echo -e "\033[1;36m[\033[0m 3\033[1;36m ]\033[0m Backup Wizard"
echo -e "\033[1;36m[\033[0m 4\033[1;36m ]\033[0m Penguin's Eggs Wizard"
echo -e "\033[1;36m[\033[0m 5\033[1;36m ]\033[0m Services Wizard"

#echo -e "\033[1;36m[\033[0m 06\033[1;36m ]\033[0m Boot messages wizard ( journalctl -b )"
#echo -e "\033[1;36m[\033[0m 03\033[1;36m ]\033[0m Search for updated packages by date"
#echo -e "\033[1;36m[\033[0m 08\033[1;36m ]\033[0m Report"
#echo -e "\033[1;36m[\033[0m 10\033[1;36m ]\033[0m Soft Reboot System"
echo -e "\033[1;36m[\033[0m E\033[1;36m ]\033[0m EXIT\n"




