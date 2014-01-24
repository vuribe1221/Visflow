<h5>What will the user need to input?</h5>
	Well, 'sh imake' in any linux enviroment to start the setup.

<h5>What is irods?</h5>
	Irods is a way to use the iplant collaborative enviroment through shell commands.

<h5>Where is the irods configuration file stored?</h5>
	~/.irods/.irods/.irodsEnv

<h5>What is located in the .irodsEnv file?</h5>
	Everything needed for irods to connect to iplant except the password.

<h5>How to store the password so we can connect to irods from other machines.</h5>
	read -s -p "Enter irods password: " pass
	iinit -e $pass  
	(this way is not secure and will be removed once iticket is implemented.)
	OR  
	Use the scrambled password file ~/.irods/.irodsA  

<h5>What format must the iplant folder be in?</h5>
	There should be one directory with all the files needed including script and data files.  
	  
	For example  
	Simulation/  
	--> simulation.py
	--> profile.config  
	--> sim_files/
	----> file1.txt
	----> file2.txt
	----> file3.txt

<h5>The irods folder and cctools directory (cctools/bin) must be exported to PATH locally.</h5>
	If the irods/cctools folder is not found on the worker machines it will be automatically downloaded and exported to path.


#######################################################################
<h5>Script file details</h5>
-check_irods_key.sh
	checks for irods cookie in ~/.irods/.irodsEnv
	exits with 0 for found
	exits with 1 for not found

-getFolder.sh
	gets the structure (recursively) of irods folder given as argument

-login.sh
	gets the pass for irods

-split_option.sh
	splits local or remote files found on irods and returns them from 	
	whence they came in either a /splits or /chunks directory
	
	
######################################################################
<h5>Updates</h5>  
	
	Currently  
	1. No error catching  
	2. Constant read/write .config file  
	3. Can not add defaults  
	4. Can not add profiles/select profile  
	5. Code not optimized or easy to follow  
	6. Code does not “clean up” when done  
	7. Sends iplant password in plain text  
	8. Very static/not many options  
	  
	  
	Fixes to come  
	1. ___ Profile option  
		a. ___ option to load a profile so the .config will not need to be redone every time but can be edited  
		b. ___ prompt to save .config as a profile  
		c. ___ prompt to manage profiles  
	2. ___ add error catching when opening file and check for necessary files  
	3. ___ add an options menu/save options  
	4. ___ remove temporary files/dirs  
	5. ___ use iticket to iget/iput (increase security)  
	6. ___ encrypt futuregrid files/workers with password  
	  
