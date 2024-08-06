#!/bin/bash
MY_SHELL="csh"
SERVER_NAME=$(hostname)
echo "Hello World ${MY_SHELL}ing ${SERVER_NAME}"

# Test for file condition
[ -f /etc/shadow ] && echo "Shadow passwords are enabled" || echo "Shadow passwords are disabled"
[ -w /etc/shadow ] && echo "You have permissions to edit /etc/shadow" || echo "You do NOT have permissions to edit /etc/shadow"
[ -e /etc/passwd ] && echo "Password file exists" || echo "Password file does not exist"
[ -d /etc/shadow ] && echo "Shadow file is a directory" || echo "Shadow file is NOT a directory"
[ -r /etc/shadow ] && echo "You have read permissions" || echo "You do NOT have read permissions"
[ -x /etc/shadow ] && echo "You have execute permissions" || echo "You do NOT have execute permissions"

# Making Decisions - The if statement
if [ "$MY_SHELL" = "bash" ]; 
then
  echo "You seem to like the bash shell"
elif [ "$MY_SHELL" = "csh" ];
then
    echo "You seem to like the csh shell"
else
    echo "You don't seem to like the bash shell"
fi

# Foor loop
for COLOR in red green blue
do
  echo "COLOR: $COLOR"
done

PICTURES=$(ls *jpg)
DATE=$(date +%F)

for PICTURE in $PICTURES
do
  echo "Renaming ${PICTURE} to ${DATE}-${PICTURE}"
  mv ${PICTURE} ${DATE}-${PICTURE}
done

# Positional Parameters
USER = $1
echo "Executing script: $0"
echo "Archiving user: $USER"

# access all the positional parameters
for USER in $@
do
  echo "Archiving user: $USER"
done

# Accpeting input
# read -p "Enter your name: " NAME
# echo "Enter your name: $NAME "

# Exit status/ Return code - 0 is success, other (1-255) is failure
ls /etc/snot
echo "Exit status of the last command: $?"

HOST="google.com"
ping -c 1 $HOST
RETURN_CODE=$?
if [ "$RETURN_CODE" -eq "0" ]
then
  echo "$HOST reachable"
else
  echo "$HOST unreachable"
fi

# && and || operators
echo "This is a test" && echo "This is a test" # the second echo will only run if the first echo is successful
echo "This is a test" || echo "This is a test" # the second echo will only run if the first echo is not successful
ping -c 1 $HOST && echo "$HOST reachable" || echo "$HOST unreachable"

# ; separator 
echo "This is a test"; echo "This is a test" # the second echo will always run, regardless of the first echo's success

# exit command
ping -c 1 $HOST
if [ "$?" -ne "0" ]
then
  echo "$HOST unreachable"
#   exit 1
fi
# exit 0 # success

# Functions
function hello() {
  echo "Hello"
  now
}

function now() {
  echo "It's $(date +%r)"
}


hello # call the function

function hello_name() {
  for NAME in $@
  do 
    echo "Hello $NAME"
  done
}

hello_name "John" "Jane" "Bob" # call the function with multiple names

# Local variables
function hello_name_local() {
  local LNAME=$1
  echo "Hello $LNAME"
}

# Return Codes in Functions

function check_file() {
  local FILE=$1
  if [ -f $FILE ]
  then
    return 0
  else
    return 1
  fi
}

check_file "/etc/passwd" # returns 0 if file exists, 1 if file does not exist
echo $? # prints the return code of the last command


# Wildcards

# * - matches zero or more characters in ls, rm cp commands
ls *.sh
rm *.sh
cp *.sh /tmp
# ? - matches exactly one character in ls, rm cp commands
ls ?.sh
rm ?.sh
cp ?.sh /tmp

#[...] - matches any one of the characters in the brackets in ls, rm cp commands
ls [aeiou]*.sh

#[^...] - matches any one character not in the brackets in ls, rm cp commands
ls [^aeiou]*.sh

#[!...] - matches any one character not in the brackets in ls, rm cp commands
ls [!aeiou]*.sh

# Named Characters Classes
# [:alnum:] - matches all alphanumeric characters
ls [[:alnum:]]*.sh

# [:alpha:] - matches all alphabetic characters
ls [[:alpha:]]*.sh

# [:blank:] - matches all blanks
ls [[:blank:]]*.sh

# [:cntrl:] - matches all control characters
ls [[:cntrl:]]*.sh

# [:digit:] - matches all digit characters
ls [[:digit:]]*.sh

# Case statement
# case sensitive 
case "$MY_SHELL" in
  "bash")
    echo "You seem to like the bash shell"
    ;;
  "csh")
    echo "You seem to like the csh shell"
    ;;
  *)
    echo "You don't seem to like the bash or csh shell"
    ;;
esac

# logging in shell scripts

logger "This is a log message"
logger -p user.info "This is a log message"
logger -t MY_SCRIPT -p local10.info "This is a log message"
logger -i -t MY_SCRIPT -p local10.info "This is a log message"