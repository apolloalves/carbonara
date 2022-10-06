#!/bin/bash

# This program contains routine automation scripts for:

# Full kernel update;
# Complete update of the list of repositories;
# Application update via flatpak update
# Complete device driver update;
# GRUB update after kernel update;

# Automatic removal and correction of apt/dpkg packages;
# Removal and correction of traces of unused packages;
# Automatic removal of orphaned packages that only occupy spaces;

# Cleaning exchange;
# Disk usage space summary;

# In addition, we have included scripts to remove traces of unused dpkgs and apts packages that take up unnecessary space and also remove the accumulated kernel.
# For it to work effectively, we recommend installing some dependencies:

# STACER - System Optimizer and Monitor
# https://github.com/oguzhaninan/Stacer

# TRASH-CLI - REMOVAL RUBBISH BIN FILES
# https://github.com/andreafrancia/trash-cli

# ORPHANER - REMOVAL OF ORPHAN PACKAGES
# sudo apt install deborphan

# TIMESHIFT - SYSTEM RESTORATION
# https://github.com/teejee2008/timeshift

# Instructions:

# 1 - Download the file;
# 2 - Give him execution privileges (X) as root;
# 3 - Move the file to the /bin directory
# 4 - Run the command in the terminal with sudo

# ATTENTION!
# At your own risk, we are not responsible for any system failures or damages that may occur with your GNU/LINUX distribution.
# The resource developed in this project is completely open source, we do not tolerate improper distribution or for profit. Modify it 
# and distribute it for free to everyone!
# We encourage you to feel free to further improve our code. After all, that's what the GNU/LINUX universe was born for!

# Good luck! Greetings!
#********************************************************************************************************************
#Highlights commands
#********************************************************************************************************************
#Print google
#echo -e '\033[01;34;47mG\033[01;31mo\033[01;33mo\033[01;34mg\033[01;32ml \033[01;31me\033[00;37;40m'
#********************************************************************************************************************
#Print Fatal Error "RED" - "Blink"
#echo -e '\033[05;31mERRO FATAL\033[00;37m'
#********************************************************************************************************************
#Print in "white bold Ubuntu" and "Green Underscore" "Focal Fossa"
#echo -e '\033[01;37mUbuntu \033[04;32mFocal Fossa\033[00;37m!!!'
#********************************************************************************************************************

<<<<<<< HEAD

=======
>>>>>>> origin/gnu/linux
#HOSTNAMECTL
echo -e "\033[01;32mMACHINE REPORT\033[00:37m"
hostnamectl
#lsb_release -cs
echo -e '************************************************************************************************************'

echo -e "\033[01;32mKERNELS LIST!\033[01;37m"
sudo dpkg --list 'linux-image*'
echo -e '************************************************************************************************************'

<<<<<<< HEAD
#********************************************************************************************************************
#echo -e '\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n'
echo -e "\033[00;32mUPDATE PACKAGES OF SYSTEM..\033[00;33m\n"
#********************************************************************************************************************
	sudo apt update -y 
<<<<<<<< HEAD:fix__packages-5.4.sh
	sudo apt update --fix-missing
      sudo apt upgrade -y
      sudo apt full-upgrade -y
      sudo apt dist-upgrade
	sudo apt install aptitude -y
	sudo aptitude safe-upgrade -y
	sudo apt install base-files sosreport ubuntu-server
	sudo apt --fix-broken install
========
	sudo apt full-upgrade -y
        sudo apt dist-upgrade -y 
	sudo aptitude safe-upgrade -y
	sudo apt install aptitude -y
	sudo apt install base-files sosreport ubuntu-server -y 
	sudo apt update --fix-missing -y
	sudo apt --fix-broken install -y 
>>>>>>>> origin/gnu/linux:fix__packages-5.3.sh
	sudo apt install -f
	sudo apt remove $(deborphan)

#OK

echo -e "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n"
echo -e "\033[01;32mCLEANNING SYSTEM...\033[00;37m"

echo -e '************************************************************************************************************'
      sudo apt autoremove -y
	sudo apt autoclean -y
	sudo apt clean -y 
	sudo apt --purge autoremove -y
      sudo rm -rf /var/lib/apt/lists/lock
      sudo rm /var/lib/dpkg/lock-frontend
      sudo dpkg --configure -a
      sudo apt update
=======
#OK
#********************************************************************************************************************
echo -e "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n"
echo -e "\033[01;32mCLEANNING SYSTEM...\033[00;37m"

	sudo rm -rf /var/lib/apt/lists/lock
>>>>>>> origin/gnu/linux
	sudo rm /var/lib/apt/lists/* -vf
	sudo rm -f /var/lib/dpkg/lock
	sudo rm -rf ~/.cache/thumbnails/*
	sudo rm -f ~/.cache/thumbnails/normal/*
	sudo rm -f /var/cache/apt/archives/lock
	sudo rm -rf ~/.cache/tracker/ 
	sudo rm -Rf /var/log/*
<<<<<<< HEAD

      echo -e "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n"

	echo -e "\033[01;37m\nRemoving Rubbish Bin files...\033[01;33m"
     
      echo -e "\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n"

	sleep 1 
	sudo rm -rfv .local/share/Trash/*
	
=======
	echo -e "\033[01;37m\nRemoving Rubbish Bin files...\033[01;33m"
	sleep 1 
	sudo rm -rfv .local/share/Trash/*
	echo -e '\n\033[01;37m[\033[01;32m OK\033[01;37m ]\033m\n'
>>>>>>> origin/gnu/linux
	echo 'Removing open recents files...'
	sleep 1
	sudo rm -rf /home/apollo__nicolly/.local/share/recently-used.xbel
	echo -e '\n\033[01;37m[\033[01;32m OK\033[01;37m ]\033m\n'	
      
<<<<<<< HEAD
<<<<<<<< HEAD:fix__packages-5.4.sh
#OK
========
=======
>>>>>>> origin/gnu/linux
      echo "Shutting down Nautilus now..."
      sudo nautilus --quit
      echo -e "\n"
      echo -e "\033[01;05;31mCHECKING ATK__HAIRY MOUNT POINT...!!\033[00;37m"
      sleep 2
      sudo umount -l -f /dev/sdc7 /mnt/EXT__ATK/
      sudo rm -rf ~/.local/share/Trash/*i
      sleep 1
      echo -e "\n\033[01;37m[\033[00;32m OK\033[00;37m ]\033m\n"
<<<<<<< HEAD
>>>>>>>> origin/gnu/linux:fix__packages-5.3.sh

#********************************************************************************************************************
#OK
#********************************************************************************************************************
echo -e "\033[01;32mCleaning up cache entries...\033[01;37m"
sleep 2

	sudo sync; echo 1 > /proc/sys/vm/drop_caches
	sudo sync; echo 2 > /proc/sys/vm/drop_caches
	sudo sync; echo 3 > /proc/sys/vm/drop_caches
	sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs
	sudo dpkg -l 'linux-*' | sed '/^ii/!d;/'"$(uname -r | sed "s/\(.*\)-\([^0-9]\+\)/\1/")"'/d;s/^[^ ]* [^ ]* \([^ ]*\).*/\1/;/[0-9]/!d' | xargs sudo apt -y purge
	sudo dpkg -l | awk '/^rc/ {print $2}' | xargs --no-run-if-empty sudo dpkg --purge
	sudo dpkg --purge $(COLUMNS=200 dpkg -l | grep "^rc" | tr -s ' ' | cut -d ' ' -f 2)
	sudo dpkg --configure -a
      sudo dpkg install -f
=======





      #OK
#********************************************************************************************************************
#echo -e '\n\033[01;37m[\033[00;32m OK\033[01;37m ]\033m\n'
echo -e "\033[00;32mCLEARING TRACES OF PACKAGES...\033[00;33m\n"
#********************************************************************************************************************
	sudo apt update -y 
	sudo apt full-upgrade -y
      sudo apt dist-upgrade -y 
	sudo aptitude safe-upgrade -y
	sudo apt install aptitude -y
	sudo apt install base-files sosreport ubuntu-server -y 
	sudo apt update --fix-missing -y
	sudo apt --fix-broken install -y 
	sudo apt install -f
	sudo apt autoremove -y
	sudo apt autoclean -y
	sudo apt clean -y 
	sudo apt --purge autoremove -y
	sudo apt remove $(deborphan)
>>>>>>> origin/gnu/linux

#********************************************************************************************************************
echo -e "\n\033[01;32mOptimizing system performance...\033[00;37m\n"
sudo prelink -amR
sudo /etc/cron.daily/prelink
#********************************************************************************************************************
#OK
#********************************************************************************************************************
echo -e "\n\033[01;37m[\033[00;32m OK\033[00;37m ]\033m\n"
#*********************************************************************************************************************'
#OK
#********************************************************************************************************************

echo -e "\n\033[01;32mChecking for flatpak updates...\033[00;37m"
        flatpak update -y
#********************************************************************************************************************
#PRELINK

echo -e "\033[01;05;31mATTENTION GRUB IS BEING UPDATED!! DOUGLAS DO NOT INTERRUPT THE PROCESS!!\033[00;37m"

        sudo update-grub

echo -e "\n\033[01;05;32mUPDADE GRUB OK!!\033[00;37m\n"
echo '************************************************************************************************************'
echo -e "\033[01;32mSTATE RAID0 PARTITIONS\033[00;37m"
echo '************************************************************************************************************'
      df -h /dev/md0p* && lsblk | grep md0p3

echo -e '\n************************************************************************************************************'
echo -e "\033[01;32mSTATE sd5 PARTITIONS\033[00;37m"
echo '************************************************************************************************************'
            df -h /dev/sdc5 && lsblk | grep scd5
<<<<<<< HEAD
echo -e '\n************************************************************************************************************'
=======
echo '************************************************************************************************************'
>>>>>>> origin/gnu/linux
            df -h /dev/sdc6 && lsblk | grep scd6
echo -e '\n************************************************************************************************************'


echo -e "\033[01;32mCLEANING SWAP MEMORY!\033[00;37m"
echo '************************************************************************************************************'
        sudo swapoff -a && swapon -a && free -h
echo '************************************************************************************************************'

<<<<<<< HEAD
=======
#********************************************************************************************************************
#ORPHANER CONDITIONAL
#********************************************************************************************************************
# echo -n 'Want to check for orphaned packages? ( y/n ) '
# read -r orphaner

# if test "y" = "$orphaner"
#       then 
#       echo -e "\033[01;32mOPENNING DEBORPHAN...\033[01;37m"
#       sudo orphaner

# elif test 'n'
#       then 
#       echo 'skipping ...'
#       sleep 1
# fi
>>>>>>> origin/gnu/linux

#********************************************************************************************************************
#STACER/TIMESHIFT CONDITIONAL
#*******************************************************************************************************************

VALIDATE=$(test "y" || "n" != "$stacer_question" || test "y" || "n" != "$timeshift_question")


 echo -n 'Do you want to open stacer ( y/n ) ? or press any key to exit '
 read -r stacer_question


 if test "n" = "$stacer_question"
                  
            then 
            echo "Generating the list of snapshots..."
            sleep 2
            sudo timeshift --delete
            echo -e '\n************************************************************************************************************\n'
            lsb_release -a      
            echo -e '\n************************************************************************************************************\n'
            neofetch 

fi

 if test "y" = "$stacer_question"

    then

      echo "stacer is running..."
      sleep 2
      stacer &        

      until ! pgrep -x "stacer" > /dev/null
      
      do
            echo -e '\cAguardando o encerramento do stacer pelo usuário...'
            sleep 2
      done
      
      echo -e '\n'
      echo -n 'Can I create a new snapshot containing the current state of the system ( y/n ) ? or press any key to exit '
      read -r timeshift_question

fi
 
  if test "y" = "$timeshift_question"

            then

            echo "initializing timeshift..."
            sleep 2
            echo -e "\n\033[01;31mCreating snapshot...\033[00;37m\n"
            sudo timeshift --create --verbose --comments 'shell : [ fix__packages-5.4.sh ]' --tags D
            echo -e "\n\033[00;37m[\033[00;32m done!\033[00;37m ]\033m\n"
            echo -e '\n************************************************************************************************************\n'
            lsb_release -a      
            echo -e '\n************************************************************************************************************\n'
            neofetch 
      fi

      if test "n" = "$timeshift_question"

                  
            then 
            echo "Generating the list of snapshots..."
            sleep 2
            sudo timeshift --delete
            echo -e '\n************************************************************************************************************\n'
            lsb_release -a      
            echo -e '\n************************************************************************************************************\n'
            neofetch 
            

      fi


      if
            echo "${VALIDATE}"
            then
            echo -e "The operation was canceled by the user\n"   

      fi
<<<<<<< HEAD


#********************************************************************************************************************
#ORPHANER CONDITIONAL
#********************************************************************************************************************
# echo -n 'Want to check for orphaned packages? ( y/n ) '
# read -r orphaner

# if test "y" = "$orphaner"
#       then 
#       echo -e "\033[01;32mOPENNING DEBORPHAN...\033[01;37m"
#       sudo orphaner

# elif test 'n'
#       then 
#       echo 'skipping ...'
#       sleep 1
# fi

<<<<<<<< HEAD:fix__packages-5.4.sh
========
#********************************************************************************************************************
#STACER/TIMESHIFT CONDITIONAL
#*******************************************************************************************************************

VALIDATE=$(test "y" || "n" != "$stacer_question" || test "y" || "n" != "$timeshift_question")
>>>>>>>> origin/gnu/linux:fix__packages-5.3.sh



<<<<<<<< HEAD:fix__packages-5.4.sh
========

 if test "n" = "$stacer_question"
                  
            then 
            echo "Generating the list of snapshots..."
            sleep 2
            sudo timeshift --delete
            echo -e '\n************************************************************************************************************\n'
            lsb_release -a      
            echo -e '\n************************************************************************************************************\n'
            neofetch 

fi

 if test "y" = "$stacer_question"

    then

      echo "stacer is running..."
      sleep 2
      stacer &        

      until ! pgrep -x "stacer" > /dev/null
      
      do
            echo -e '\cAguardando o encerramento do stacer pelo usuário...'
            sleep 2
      done
      
      echo -e '\n'
      echo -n 'Can I create a new snapshot containing the current state of the system ( y/n ) ? or press any key to exit '
      read -r timeshift_question

fi
 
  if test "y" = "$timeshift_question"

            then

            echo "initializing timeshift..."
            sleep 2
            echo -e "\n\033[01;31mCreating snapshot...\033[00;37m\n"
            sudo timeshift --create --verbose --comments 'shell : [ fix__packages-5.2.sh ]' --tags D
            echo -e "\n\033[00;37m[\033[00;32m done!\033[00;37m ]\033m\n"
            echo -e '\n************************************************************************************************************\n'
            lsb_release -a      
            echo -e '\n************************************************************************************************************\n'
            neofetch 
      fi

      if test "n" = "$timeshift_question"

                  
            then 
            echo "Generating the list of snapshots..."
            sleep 2
            sudo timeshift --delete
            echo -e '\n************************************************************************************************************\n'
            lsb_release -a      
            echo -e '\n************************************************************************************************************\n'
            neofetch 
            

      fi


      if
            echo "${VALIDATE}"
            then
            echo -e "The operation was canceled by the user\n"   

      fi
>>>>>>>> origin/gnu/linux:fix__packages-5.3.sh
=======
>>>>>>> origin/gnu/linux
