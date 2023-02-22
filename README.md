# ssh-git Git Automation Script
Bash script that helps to manage git with multiple remote accounts linked via ssh keys  

This script is designed to automate common Git tasks. The script can perform the following Git actions:

* Commit changes with a custom message
* Quick-push changes (add all files, commit with a message, and push)
* Fetch changes from a remote repository
* Pull changes from a remote repository
* Push changes to a remote repository
* Clone a remote repository
* The script takes command-line arguments to specify the Git action to perform, the Git profile to use (including the username, email, and SSH key), the commit message, and the remote repository URL.

## How to use
To use this script, run it in a terminal window and pass the appropriate command-line arguments. Here's the usage information:


>Usage: git-automation.sh [-h] [-a <action>] [-k <key>] [-p <profile>] [-m <message>] [-r <remote>]
 -h           Display this help message and exit
 -a <action>  The git action to perform (commit, quick-push, fetch, pull, push, clone)
 -p <profile> The git profile to use
 -m <message> The commit message
 -r <remote>  The remote repository URL
    
For example, to commit changes with the message "Update README.md", use the following command:

    $ ./git-automation.sh -a commit -p myprofile -m "Update README.md"
    
To quickly add all changes, commit with a message, and push to the remote repository, use the following command:

    $ ./git-automation.sh -a quick-push -p myprofile -m "Update README.md"

To clone a remote repository, use the following command:

    $ ./git-automation.sh -a clone -p myprofile -r git@github.com:myusername/myrepository.git

Note that you must specify a Git profile in the git_profiles.txt file that is located in the ~/.ssh directory. The profile should contain the username, email, and SSH key information.

License
This script is licensed under the MIT License. See the LICENSE file for more information.