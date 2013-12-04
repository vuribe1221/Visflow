##################### config ######################
# use .sh for bash .py for python files
script_suffix=.sh
clear
head -n 30 .logo
echo -e "\n\n\n"
export PATH=~/icommands/:${PATH}



###################################################

# login to get password and enable irods on local machine
sh ~/imake/bins/login.sh
ils -r 
# get irods working directory
read -p "$(tput setaf 3)What is the irods working directory?$(tput sgr0) " cwd
echo $cwd>>.config

# if more than 1 script file exists prompt which to use
dir=`head -n 2 .config|tail -n 1`
num_of_scripts=`ils $dir|grep -c $script_suffix`
#echo $num_of_scripts

if [ $num_of_scripts -lt 1  ];then
	echo "SCRIPT FILE NOT FOUND!"
	exit 1
else
	if [ $num_of_scripts -gt 1 ];then
		echo "$(tput setaf 2)MULTIPLE SCRIPTS FOUND!$(tput sgr0)"
		ils $dir/|grep $script_suffix
		read -p "$(tput setaf 3)Which file should be used?$(tput sgr0) " script_file
		echo $script_file >>.config
		read -p "$(tput setaf 3)Enter arguments needed for the script:$(tput sgr0) " arguments
	else
		script_file=`ils $dir/*$script_suffix`
	fi
fi



# get folder for data
ils $dir/

echo "Is the data in one file?"
select yn in "Yes" "No"; do
    case $yn in
        Yes ) read -p "$(tput setaf 3)What is the data file?$(tput sgr0) " data_file;echo "yes">>.config;echo $data_file >> .config;break;;
        No ) read -p "$(tput setaf 3)What is the directory for the data files?$(tput sgr0)  " data_dir;echo "no">>.config;echo $data_dir >> .config;break;;
    esac
done

#get number of chunks/splits
num_chunks=`ils $dir/$data_dir|wc -l`
echo $num_chunks-1|bc>>.config
echo $arguments>>.config
mv .config ./bins/.config
