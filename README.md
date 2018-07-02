<img src="https://i.imgur.com/SzLKWcz.png" width="500"><br>

<h3>What is Visflow?</h3>
	Visflow is a shell toolchain used to decrease the time and effort it takes to go from personal computer to
	the cloud. This program is used in conjunction with the iplant datastore and futuregrid to make using the
	cloud almost trivial.<br>
	<a href="https://prezi.com/vwknpr_-ewh2/visflow/?utm_campaign=share&utm_medium=copy">Here is a Prezi presentation for more information about this project.</a>
	
<h3>Who does it appeal to?</h3>
	 The main demographic that will benefit from this is the research and data intensive community.<br>
<h3>How is Visflow used?</h3>
	In any bash (shell) clone the git repo and run visflow.sh by using 'sh visflow.sh'.

<h3>What is irods?</h3>
	Irods is a way to use the iplant collaborative enviroment through shell commands.

<h3>Where is the irods configuration file stored?</h3>
	~/.irods/.irods/.irodsEnv

<h3>What is located in the .irodsEnv file?</h3>
	Everything needed for irods to connect to iplant except the password.

<h3>The irods password was stored, but now it will never be stored or sent.<h3>

<h3>What format must the iplant folder be in?</h3>
	There should be one directory with all the files needed including script and data files.  
	  
	For example  
	Simulation/  
	--> simulation.py
	--> sim_files/
	----> file1.txt
	----> file2.txt
	----> file3.txt


<h3>Script file details</h3>

	-split_option.sh
		splits local or remote files found on irods and returns them from 	
		whence they came in either a /splits or /chunks directory
	

## Latest update:   
	+ reduced the number of files by making functions rather than seperate .sh files.   
	+ no passwords are ever stored (you must be logged into irods on host and worker computers)   
	+ error catching   
	+ simple step-by-step instructions   
	+ Visflow.info integration   

## Future updates:   
	+ clean up after computation is done   
	+ ability to take in multiple data files   
	+ expand documentation   
	+ make tutorial video   
