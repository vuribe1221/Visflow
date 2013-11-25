#Begin------Contents of split_option.sh
#!/bin/bash
clear

let number_of_splits=10;




echo " ##########################################################################
 ###                                                                    ###
 ###            How will the files be split?                            ###
 ###                                                                    ###
 ###    OPTIONS:                                                        ###
 ###               Files on Local Machine                               ###
 ###               1: Arbitrary Split into a number of files            ###
 ###               2: Preformatted Split using \"SPLIT_HERE\" delimiter   ###
 ###                                                                    ###
 ###               Files on irods                                       ###
 ###               3: Arbitrary Split of file from irods                ###
 ###               4: Preformatted Split using \"SPLIT_HERE\" delimiter   ###
 ###                                                                    ###
 ###               5: No Splitting Necessary (presplit)                 ###
 ###                                                                    ###
 ###                                                                    ###
 ##########################################################################"
read -p "Choose your option (1/2/3/4/5): " option

# if no split necessary then exit	
if [ $option == 5 ];then
	exit 0
fi
	
#ask for file to split
echo
ls
echo
read -p "Which file should be split? " file_to_split

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#
if [ $option == 1 ];then

	read -p "How many times should it be split? " number_of_splits
	#setup chunks directory
	if [ -d ./chunks ];then
		rm -r chunks
	fi
	mkdir chunks

	# checks if file exists then splits if true
	if [ -f $file_to_split ];then
		#if exists -> split
		split -a 2 -dl$((`wc -l $file_to_split|sed 's/ .*$//'` / $number_of_splits + 1)) $file_to_split chunks/$file_to_split.
	
	else
	# if file is not found then break
	echo "$(tput setaf 3)FILE NOT FOUND!$(tput sgr0)"
	exit 1
	fi
fi

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#
if [ $option == 2 ];then
	if [ -d ./splits ];then
                rm -r splits
        fi
        mkdir splits
	if [ -f $file_to_split ];then
		awk '/SPLIT_HERE/{n++}{print>"splits/out"n".txt" }' $file_to_split
	else
		echo "$(tput setaf 3)FILE NOT FOUND!$(tput sgr0)"
		exit 1
	fi
fi

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#
if [ $option == 3 ];then

# iget the file
sh login.sh
#sh ./getFolder.sh tmp
ils
# split it

# iput the files

exit 1;
fi
