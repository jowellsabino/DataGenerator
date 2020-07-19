#!/bin/bash
# read has dfferent parameters in bash, so we force bash

COMMON_PASSWORD='Password2255'
COMMON_RESTRICTION="PasswordLocked,NoLogFailIDisuser,NoPasswordExpire,-PasswordExpired"

# Prompt forCCL username and password
read -p "Application Userame: " MILL_USERNAME
read -s -p "Application Password: " MILL_PASSWORD

# Is there another way to get the domain?
MILL_DOMAIN=$environment

printf "\nDomain: $MILL_DOMAIN\n"

# Get usernames and put in array
usernames=('DGMD1' 'DGMD2')

# Form the string that would be passed on to authview
# see https://www.shell-tips.com/bash/arrays/
COMMAN_STRING=""
for username in "${usernames[@]}"
do
    COMMAND_STRING+=$"modify $username -directoryInd N -password $COMMON_PASSWORD -restrict $COMMON_RESTRICTION\n"
done

# COMMAND STRING
printf "\nCommands to pass to AuthView:\n"
printf "$COMMAND_STRING"
printf "\nLength = ${#COMMAND_STRING}\n"

#Execute authview in batch mode
$cer_exe/authview<<!EOF
$MILL_USERNAME
$MILL_DOMAIN
$MILL_PASSWORD
$(printf "$COMMAND_STRING")
exit
!EOF

