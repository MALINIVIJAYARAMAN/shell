#!/bin/bash

echo Welcome to DevOps training
echo DevOps Training Timings - 6AM
echo DevOps Trainer - Raghu

COURSE_NAME=DevOps

echo Welcome to $COURSE_NAME training
echo $COURSE_NAME Training Timings - 6AM
echo $COURSE_NAME Trainer - Raghu

# Declare a variable , VARNAME=DATA
# TO access variable , $VARNAME

# What characters you can use in variable names
# a-z, A-Z, 0-9, _(underscore)
# variable name should not start with a number
    # 1var is wrong
    # var1 is right

# STYLE in Variable NAMES
# Unix/Linux -> VARNAME (All in capital characters)
# Java - varName (CamelCase)


DATE=2020-12-06
echo "Good Morning, Today date is $DATE"

# To declare variable content dynamically then we should be using
  # 1. Command Substitution      VAR=$(command)
  # 2. Arithmetic Substitution   VAR=$((expression))

DATE=$(date +%F)
echo "Good Morning, Today date is $DATE"

ADD=$((2+3))
echo ADD = $ADD


# Data Types
a=10      # Integer
b=xyz     # String
c=true    # Boolean
d=9.99    # Float

echo  a = $a, b = $b, c = $c, d = $d

# In shell by default there are not data types, You should deal with the data of its type

