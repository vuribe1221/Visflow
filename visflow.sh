##################### config ######################

clear
head -n 30 .logo
echo -e "\n\n\n"

export PATH=~/icommands/:${PATH}
export PATH=~/cctools/bin/:${PATH}

###################################################

# login to get password and enable irods on local machine
# sh ~/imake/bins/login.sh

load_config() {
	
	#tell me the settings file
	settings_file=settings
	
	#get script suffix
	script_suffix=`head -n 7 $settings_file|tail -n 1`

	#get port number
	port=`head -n 9 $settings_file|tail -n 1`

	#get public allowed y/n\n\n
	pub_allowed=`head -n 11 $settings_file|tail -n 1`
	
	#get name of program
	visname=`head -n 13 $settings_file|tail -n 1`
	
	#get public allowed y/n
	show_stats=`head -n 15 $settings_file|tail -n 1`
	
	#get password
	pass=`head -n 17 $settings_file|tail -n 1`
	
	#save the whales?
	save_whales=`head -n 19 $settings_file|tail -n 1`
	
	#number of cores to use
	num_cores=`head -n 21 $settings_file|tail -n 1`

	#email address to report to
	email=`head -n 23 $settings_file|tail -n 1`
}

irods_login () {
	#anyone else's login is overridden

	
	#ask for password
	read -s -p "Enter irods password: " password
		
	#login with password
	iinit -e $password
	
	EC=$?
	if [ ! $EC -eq 0 ]; then
		say "Password is Invalid!"
		exit 777
	fi
	
	echo -e "\n"
}

confirm (){
	echo "Is $1 correct?"
	echo $2
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) echo "Writing to file!";break;;
			No ) exit 12;;
		esac
	done
}

clean_up (){
	#remove useless or 1time files
	echo "not used yet"
}

ask (){
	# use quotation marks around question param
	read -p "$(tput setaf 3) $1 $(tput sgr0)" $2
	echo -e "\n\n"
}

say (){
	echo -e "$(tput setaf 3) $1 $(tput sgr0)\n\n"
}

get_cmd (){
	echo -e "\n$exec $script_file $arguments $data_file\n" 
}

load_config
if [ ! -f bins/.config ];then
	
	if [ -z $1 ];
	then
		irods_login
	fi

	ils
	# get irods working directory
	ask "What is the irods working directory?" cwd

	# get how to execute the script (python,sh,java)
	ask "What is needed to execute script/program? (sh,python,...)" exec

	# if more than 1 script file exists prompt which to use
	num_of_scripts=`ils $cwd|grep -c $script_suffix`

	if [ $num_of_scripts -lt 1 ];then
		say "SCRIPT FILE NOT FOUND!"
		exit 404
	else
		if [ $num_of_scripts -gt 1 ];then
			say "MULTIPLE SCRIPTS FOUND!"
			ils $cwd/|grep $script_suffix
			ask "Which file should be used? " script_file
			ask "Enter arguments needed for the script: " arguments
		else
			script_file=`ils $cwd|grep $script_suffix`
			ask "Enter arguments needed for the script: " arguments
		fi
	fi

	# get folder for data
	ils $cwd

	echo "Is the data in one file?"
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) ask "What is the data file? " data_file;yn=yes;num_chunks=1;break;;
			No ) ask "What is the directory for the data files? " data_file;num_chunks=`ils $cwd/$data_dir|wc -l`;yn=no;break;;
		esac
	done

	get_cmd

	confirm command `$getcmd`

	## make the .config
		echo $exec>.config
		echo $cwd>>.config
		echo $script_file>>.config
		echo $yn>>.config
		echo $data_file>>.config
		echo $num_chunks>>.config
		echo $arguments>>.config

	# make sure the .config file has the necessary info
	line=`wc -l .config|cut -d ' ' -f 1`
	if [ $line -gt 6 ];then
			mv .config ./bins/.config
	else
			echo "ERROR NOT ENOUGH ARGUMENTS IN .CONFIG!!!"
			exit 1
	fi
else
	head -n 10 bins/.config
	say "Would you like to load last .config file? (1/2): "
	select yn in "Yes" "No"; do
		case $yn in
			Yes ) echo "Loading last config...";break;;
			No ) rm bins/.config;say "Please restart visflow.";exit 0;break;;
		esac
	done
fi

## run external scripts
cd bins/
sh makeMakeflow.sh
sh makeVisflow.sh

cd Makeflow_dir

case $save_whales in
	Y)echo -e "\t.";echo -e "       \":\"";echo -e "     ___:____     |\"\/\"|";echo -e "   ,'        \`.    \  /";echo -e "   |  O        \___/  |";echo -e "~^~^~^~^~^~^~^~^~^~^~^~^~";;
	N)echo "WARNING: whales will not be saved!";;
esac

case $pub_allowed in
	Y)makeflow -T wq -aN $visname -p $port -m $email;;
	N)makeflow -T wq -N $visname -p $port -m $email;;
esac


