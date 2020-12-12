#!/bin/bash

# We can print a message on screen using two commands in linux
# 1. echo   -> Preferred one , because of less syntax
# 2. printf  -> Have more syntax

echo Hello World
echo Good Morning!!

## Escape sequences
# \n - new line
# \t - new tab
# \e - new color

echo -e "Hello,\n\n\tWelcome to todays session.\n\nRegards,\nRaghu K."

#Hello,
#
#   Welcome to todays session
#
#Regards,
#Raghu K.


## Colors         Foreground    Background
# Red                 31            41
# Green               32            42
# Yellow              33            43
# Blue                34            44
# Magenta             35            45
# Cyan                36            46

# syntax for color print
# echo -e "\e[COLmMESSAGE"

echo -e "\e[31mRED TEXT"
echo -e "\e[32mGREEEN TEXT"
echo -e "\e[33mYELLOW TEXT"
echo -e "\e[34mBLUE TEXT"
echo -e "\e[35mMAGENTA TEXT"
echo -e "\e[36mCYAN TEXT"

echo -e "\e[41;33mYELLOW on RED"

## Color we enable will not be disabled by default, means the color will move to next
# lines as well

echo -e "\e[41;33mYELLOW on RED\e[0m"

# Some style codes
# Underline character - 4
# Bold character - 1

echo -e "\e[33mYellow Normal , \e[1;33mBold Yellow\e[0m"

echo -e "\e[4mHello World\e[0m"

# https://misc.flogisoft.com/bash/tip_colors_and_formatting
