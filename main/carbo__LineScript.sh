#!/bin/bash
##############################################################################################
# Carbonara                                                                                  #
# Script: line_script.sh - Enter a LINE_SCRIPT after each command                            #
# Author: Apollo Alves                                                                       #
# Date  : 21/11/2024                                                                         #
#                									     #
# Description : This bash code creates a LINE_SCRIPT containing 96 trace characters (─) and  #
# prints this LINE_SCRIPT on    							     #
# the console.                                                                               #
# Here is a step by step description of what the code does:                                  #
#                                                                                            #
# The LINE_SCRIPT variable is initialized as an empty string:                                #
# Then a loop is used to ite from 0 to 89 (90 times) and build the LINE_SCRIPT by adding the #
# character "─" (trace) 								     #
# to the LINE_SCRIPT variable with each iteration:                                           #
# Finally, the Printf command is used to print the LINE_SCRIPT on the console.               #
##############################################################################################

LINE_SCRIPT=""

for ((i=0; i<96; i++)); do
    LINE_SCRIPT+="─"
done

printf "%s\n" "$LINE_SCRIPT"