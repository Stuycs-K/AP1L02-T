#!/bin/bash
# HEADERS ###########################################################
err=0
chmod +x .badge.sh
./.badge.sh
trap 'rm -f *.class' EXIT
GREEN="\033[0;32m"
RED="\033[0;31m"
RESET="\033[0m"


#################FILES THAT NEED COMPILE - TRY TO COMPILE #############
# Array of required compileable files
required_files=("Driver.java" "StringMethods.java")

# Check if all files are found and compile
for file in "${required_files[@]}"; do
  if [ -f "$file" ]; then
    echo -e "${GREEN}✅$file found"
    if javac "$file"; then
      echo -e "${GREEN}✅$file compiled"
    else
      echo -e "${RED}❌Failed to compile $file"
      err=1
    fi
  else
    echo -e "${RED}❌$file does not exist."
    err=1
  fi
done


################# RUN A CLASS AND PRINT OUTPUT - DO NOT VALIDATE #############
CLASSNAME=Driver
EXPECTED_OUTPUT=""
if [ -f "$CLASSNAME.class" ]; then
  echo -e "${RESET}Attempting to run $CLASSNAME.java:"
  output=$(timeout 1 java "$CLASSNAME")
  status=$?
  if [ $status -ne 0 ]; then
    echo -e "${RED}❌Command 'java $CLASSNAME' failed"
    err=1
  else
    echo -e "${RESET}❓It ran with output: '$output'"
  fi  
else
   echo -e "${RED}❌Cannot run $CLASSNAME.java, no class file found."
   err=1
fi



################# Count Commits in Past 1 Hour #############
commit_count=$(git rev-list --count --since="1 hour ago" main)
REQUIRED_COUNT=3

# Check if commit count is a valid number
if [[ ! "$commit_count" =~ ^[0-9]+$ ]]; then
  echo -e "${RED}❌ Could not determine commit count in the past hour. Are you in a git repo with a 'main' branch?${RESET}"
  err=1
elif [ "$commit_count" -lt "$REQUIRED_COUNT" ]; then
  echo -e "${RED}❌ Less than $REQUIRED_COUNT commits in the past hour.${RESET}"
  echo -e "${RESET}You probably need to work on it more OR commit smaller chunks of code."
  err=1
else
  echo -e "${GREEN}✅ $commit_count commits made in the past hour.${RESET}"
fi
