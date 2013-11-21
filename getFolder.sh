export PATH=~/icommands/:{$PATH}

#Get the folder from irods recursively
sh login.sh
iget -VPr $1

