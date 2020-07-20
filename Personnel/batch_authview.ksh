#!/bin/bash
# read has dfferent parameters in bash, so we force bash

COMMON_PASSWORD='Password2255'
COMMON_RESTRICTION="PasswordLocked,NoLogFailIDisuser,NoPasswordExpire,-PasswordExpired"
MILL_DOMAIN=$environment # Is there another way to get the domain?


# Column in CSV file where username is found
USERNAME_COL=3

# Functions
# See: https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
function ask_yes_or_no() {
    read -p "$1 ([y]es or [N]o): "
    case $(echo $REPLY | tr '[A-Z]' '[a-z]') in
        y|yes) echo "yes" ;;
        *)     echo "no" ;;
    esac
}


# Get generic usernames and put in array
# Prompt for CSV file
read -p "CSV filename: " INPUT_CSV

# Remove the first two lines of the csv file
usernames=($(sed '1,2d' $INPUT_CSV | cut -d ',' -f$USERNAME_COL ))
echo "Number of usernames: ${#usernames[@]}"

# Null usernames are not added to array, so no need to do a null check
for username in "${usernames[@]}"
do
#if [ -n $username ];
#then
    printf "$username\n" 
#fi
done

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

# Ask for user confirmation
# See: https://stackoverflow.com/questions/1885525/how-do-i-prompt-a-user-for-confirmation-in-bash-script
if [[ "no" == $(ask_yes_or_no "Are you sure?") ]]
#    || \
#      "no" == $(ask_yes_or_no "Are you *really* sure?") ]]
then
    echo "Skipped."
    exit 0
fi

# Prompt forCCL username and password
read -p "Application Userame: " MILL_USERNAME
read -s -p "Application Password: " MILL_PASSWORD
printf "\nDomain: $MILL_DOMAIN\n"

#Execute authview in batch mode
$cer_exe/authview<<!EOF
$MILL_USERNAME
$MILL_DOMAIN
$MILL_PASSWORD
$(printf "$COMMAND_STRING")
!EOF
