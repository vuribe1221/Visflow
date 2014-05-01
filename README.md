<h5>What is Visflow and who does it appeal to?</h5>
	Visflow is a shell toolchain used to decrease the time and effort it takes to go from personal computer simulating to the cloud. This program is used in conjunction with the iplant datastore and futuregrid to make using the cloud almost trivial. The main demographic that will benefit from this is the research and data intensive community.

<h5>How is Visflow used?</h5>
	In any bash (shell) clone the git repo and run visflow.sh by using 'sh visflow.sh'.

<h5>What is irods?</h5>
	Irods is a way to use the iplant collaborative enviroment through shell commands.

<h5>Where is the irods configuration file stored?</h5>
	~/.irods/.irods/.irodsEnv

<h5>What is located in the .irodsEnv file?</h5>
	Everything needed for irods to connect to iplant except the password.

<h5>The irods password was stored, but now it will never be stored or sent.<h5>

<h5>What format must the iplant folder be in?</h5>
	There should be one directory with all the files needed including script and data files.  
	  
	For example  
	Simulation/  
	--> simulation.py
	--> sim_files/
	----> file1.txt
	----> file2.txt
	----> file3.txt


#######################################################################
<h5>Script file details</h5>

	-split_option.sh
		splits local or remote files found on irods and returns them from 	
		whence they came in either a /splits or /chunks directory
	

######################################################################
Latest update:
	+ reduced the number of files by making functions rather than seperate .sh files.
	+ no passwords are ever stored (you must be logged into irods on host and worker computers)
	+ error catching
	+ simple step-by-step instructions
	+ Visflow.info integration
