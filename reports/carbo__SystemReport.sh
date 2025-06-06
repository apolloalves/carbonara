#!/bin/bash
# Check if the user is root
source 'carbo__verifyRoot.sh'

#####################################################################
#                                                                   #
# Script: report.sh                                                 #
# Author: Apollo Alves                                              #
# Date: 16/12/2023                                                  #
#                                                                   #
#####################################################################

########################################################################
#                                                                      #
# System Report Script                                                 #
# This script generates a comprehensive machine report with various    #
# system information. It includes details like machine name, OS name,  #
# kernel version, hardware information, memory details, partition      #
# information, last boot time, and more. Requires no user interaction. #
#                                                                      #
########################################################################

MENU='carbonara.sh'
LINE_SCRIPT='carbo__LineScript.sh'
HOSTNAME=$(hostnamectl)
KERNEL=$(uname -r)
OSNAME=$(uname)
DISTRONAME=$(cat /etc/os-release | head -n1 | cut -c -10)
PROCESSADOR=$(cat /proc/cpuinfo | grep "model name" | head -n1 | cut -c14-)
NUCLEOS=$(cat /proc/cpuinfo | grep "model name" | wc -l)
MEMTOTAL=$(cat /proc/meminfo | grep MemTotal | tr -d ' ' | cut -d: -f2)
PARTITIONS=$(df -h /dev/md127p1;echo;df -h /dev/md127p2;echo;df -h /dev/md127p3;echo;df -h /dev/sdc3;echo;df -h /dev/sdd1;echo;df -h /dev/sdd3;echo)
DATE=$(date | cut -c-25)
LASTBOOT=$(systemd-analyze)
VIDEO=$(lspci | grep -i vga | cut -c 36-)
WHO=$(who)
MOTHERBOARD=$(dmidecode -t baseboard | grep "Manufacturer")
MODEL=$(dmidecode -t baseboard | grep "Product Name")

clear
$LINE_SCRIPT
echo -e "Machine Report"
$LINE_SCRIPT
echo -e "\nMachine Name: $HOSTNAME"
echo -e "Distro Name: $DISTRONAME"
echo -e "OS Name: $OSNAME"
echo -e "Version Kernel: $KERNEL"
echo -n "Active Machine Since: " && uptime -s
echo -n "User: " && whoami
echo
$LINE_SCRIPT
echo -e "\nHardwares: \n"
echo $MOTHERBOARD
echo $MODEL
echo -e "Processador: $PROCESSADOR"
echo "Núcleos: $NUCLEOS"
echo -e "Total Memory: $MEMTOTAL"
echo "Video: $VIDEO"
echo
$LINE_SCRIPT

echo -e "\nPartitions: \n"
echo -e "$PARTITIONS\n"
$LINE_SCRIPT
echo -e "\nLast boot : $LASTBOOT\n"
echo
echo -e "Report Date: $DATE"
$LINE_SCRIPT
echo

# Esperar por uma tecla pressionada antes de limpar a tela
read -rsn1 -p "Press any key to continue..."
clear

echo
sudo carbonara.sh

