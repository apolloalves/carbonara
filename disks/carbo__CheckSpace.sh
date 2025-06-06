#!/bin/bash
#######################################################################################################
# Carbonara                                                                                           #
# Script: carbo__CheckSpace.sh                                                                        #
# Author: Apollo Alves                                                                                #
# Date  : 21/11/2024                                                                                  #
#                                                                                                     #
# Description:                                                                                        #
# This shell script called "checkSpace.sh" performs some disk space checks. Here is a summary of what #
# it does:                                                                                            #
# 1. Displays a space check message.                                                                  #
# 2. Wait 1 second.                                                                                   #
# 3. Run the commands "df -h /", "df -h /home" and "df -h /mnt/MDSATA" to display disk space          #
# information in the root, /home and /mnt/EXT@ directories ST500LM012__CLONRAID, respectively.        #
#                                                                                                     #
# 4. Displays a message indicating that the verification completed successfully.                      #
# Basically, this script prints information about available disk space in the mentioned directories.  #
# It can be used to monitor disk space and verify that enough space is available.                     #
#######################################################################################################

MENU='/bin/carbonara.sh'

clear_screen() {
  printf "\033c"
}

clear_screen
# Function to print status
print_status() {
    if [ "$?" -eq 0 ]; then
        printf "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n"

    else
        printf "[ \033[01;31mFAILED\033[01;37m ]\n"
    fi
}

LINE_SCRIPT='carbo__LineScript.sh'
echo -e "\n\033[01;33mChecking spaces...\033[0m\n"
sleep 2
df -h /dev/md127p1;echo;df -h /dev/md127p2;echo;df -h /dev/md127p3;echo;df -h /dev/sdc3;echo;df -h /dev/sdd1;echo;df -h /dev/sdd3;echo
echo ""
$LINE_SCRIPT
echo 
read -rsn1 -p "Press any key to continue..."
$MENU



