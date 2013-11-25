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
 ###               2: Preformatted Split using \":split\" delimiter       ###
 ###                                                                    ###
 ###               Files on irods                                       ###
 ###               3: Arbitrary Split of file from irods                ###
 ###               4: Preformatted Split using \":split\" delimiter       ###
 ###                                                                    ###
 ###               5: No Splitting Necessary (presplit)                 ###
 ###                                                                    ###
 ###                                                                    ###
 ##########################################################################"
read -p "Choose your option (1/2/3): " option

if [ $option == 1 ];then
	#ask for file to split
	echo
	ls
	echo
	read -p "Which file should be split? " file_to_split
	read -p "How many times should it be split? " number_of_splits

	#setup chunks directory
	if [ -d ./chunks ];then
		rm -r chunks
	fi
	mkdir chunks



	if [ -f $file_to_split ];then
		#if exists -> split
		split -a 2 -dl$((`wc -l $file_to_split|sed 's/ .*$//'` / $number_of_splits + 1)) $file_to_split chunks/$file_to_split.
	else echo "File not found!"
	fi

fi

if [ $option == 2 ];then
	
fi

exit 1
