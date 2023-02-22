#!/bin/bash

execution_dir=$(pwd)

echo
echo "repository path $execution_dir"
echo

while getopts "a:p:m:r:h" opt; do
  case $opt in
    a) action="$OPTARG";;
    p) profile="$OPTARG";;
    m) message="$OPTARG";;
    r) remote="$OPTARG";;
    h) echo "Usage: $(basename "$0") [-h] [-a <action>] [-k <key>] [-p <profile>] [-m <message>] [-r <remote>]" >&2
       echo " -h           Display this help message and exit"
       echo " -a <action>  The git action to perform (commit, quick-push, fetch, pull, push, clone)"
       echo " -p <profile> The git profile to use"
       echo " -m <message> The commit message"
       echo " -r <remote>  The remote repository URL"
       exit 0
       ;;
    \?) echo "Invalid option: -$OPTARG. Try $(basename "$0") -h for help" >&2;;
  esac
done

cd ~/.ssh

# Read the parameter values from the configuration file
config_file="git_profiles.txt"

username=$(awk -F'=' "/^\[$profile\]/{f=1} f&&/^username=/{print \$2;f=0}" "$config_file")
email=$(awk -F'=' "/^\[$profile\]/{f=1} f&&/^email=/{print \$2;f=0}" "$config_file")
key=$(awk -F'=' "/^\[$profile\]/{f=1} f&&/^key=/{print \$2;f=0}" "$config_file")

cd "$execution_dir"

#start ssh agent
eval "$(ssh-agent -s)"

#if the username is passed
if [ "$username" ]; then
  git config --global user.name "$username";
  if [ "$email" ]; then
    git config --global user.email "$email";
  fi
fi

echo "git username = $(git config user.name)"
echo

#execute git commands
if [ "$action" = "commit" ]; then
  git commit -m "$message";
  echo "git commit executed"
elif [ "$action" = "quick-push" ]; then
  ssh-add ~/.ssh/"$key"
  echo
  git add -A;
  echo "git add -A executed"
  echo
  git commit -m "$message"
  echo
  echo "git commit -m $message executed"
  echo
  git push;
  echo
  echo "git push executed"
elif [ "$action" = "fetch" ]; then
  ssh-add ~/.ssh/"$key"
  echo
  echo
  git fetch;
  echo
  echo "git fetch executed"
elif [ "$action" = "pull" ]; then
  ssh-add ~/.ssh/"$key"
  echo
  git pull;
  echo
  echo "git pull executed"
elif [ "$action" = "push" ]; then
  ssh-add ~/.ssh/"$key"
  echo
  git push;
  echo
  echo "git push executed"
elif [ "$action" = "clone" ]; then
  ssh-add ~/.ssh/"$key"
  echo
  git clone "$remote";
  echo
  echo "git clone executed"
else
  echo "Please enter a valid git command. Try $(basename "$0") -h for help"
fi
