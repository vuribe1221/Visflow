#!/bin/bash
#just in case the folder is downloaded but not exported
export PATH=~/icommands/:{$PATH}

#logs into irods to enable irods functionality
read -s -p "Enter irods password: " pass
iinit -e $pass
echo

