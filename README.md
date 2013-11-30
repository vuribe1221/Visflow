<h5>What is the minumum the user will need to input?</h5>
	If all goes well 'sh imake'

<h5>Where is the irods configuration file stored?</h5>
	~/.irods/.irods/.irodsEnv

<h5>What is located in the .irodsEnv file?</h5>
	Everything needed for irods to connect to iplant except the password.

<h5>How to store the password so we can connect to irods from other machines.</h5>
	read -s -p "Enter irods password: " pass
	iinit -e $pass
	OR
	Use the scrambled password file ~/.irods/.irodsA

<h5>What format must the iplant folder be in?</h5>
	There should be one directory with all the files needed including script and data files.

<h5>Make sure either the irods folder has been exported to PATH and that the irods folder is found in ~/icommands.</h5>


#######################################################################
<h3>Script file details</h3>
<code>
check_irods_key.sh
	checks for irods cookie in ~/.irods/.irodsEnv
	exits with 0 for found
	exits with 1 for not found

getFolder.sh
	gets the structure (recursively) of irods folder given as argument

login.sh
	gets the pass for irods

split_option.sh
	splits local or remote files found on irods and returns them from 	

whence they came in either a /splits or /chunks directory
</code>
