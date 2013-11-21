What is the minumum the user will need to input?
If all goes well 'sh imake <*iplant folder> **'

*the iplant folder will need to have a script or app to run as well as all the data
**the irods password will be asked later after excecuting imake.sh

Where is the irods configuration file stored?
~/.irods/.irods/.irodsEnv

What is located in the .irodsEnv file?
Everything needed for irods to connect to iplant except the password.

How to store the password so we can connect to irods from other machines.
read -s -p "Enter irods password: " pass
iinit -e $pass

What format must the iplant folder be in?
Starting from the home folder navigate starting with the folder you wish to navigate as usual in bash.
	example sh imake tmp/tempFolder/

Make sure either the irods folder has been exported to PATH or that the irods folder is found in ~/icommands.
