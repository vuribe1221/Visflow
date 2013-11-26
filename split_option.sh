A
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
if [ $option == 1 -o $option == 2 ];then
	ls
	else
	ils -r
fi
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
	read -p "How many times should it be split? " number_of_splits
	# iget the file
	sh check_irods_key.sh

	if [ ! $? == 0 ];then	
		sh login.sh
	fi	

	ils
	echo
	iget -fVP $file_to_split

	if [ -d ./chunks ];then
                rm -r chunks
        fi
        mkdir chunks
	
	rm path	
	echo $file_to_split >> path
	tempfolder=$file_to_split
	file_to_split=`basename $file_to_split`
	#echo $file_to_split

	# split it
	if [ -f $file_to_split ];then
                #if exists -> split
                split -a 2 -dl$((`wc -l $file_to_split|sed 's/ .*$//'` / $number_of_splits + 1)) $file_to_split chunks/$file_to_split.

	###### UPLOAD TO IRODS
	tempfolder=`sed s/$file_to_split//g path`
        #echo "file_to_split=$file_to_split"
	#echo "tempfolder=$tempfolder"
	iput -fr chunks/ $tempfolder/
	
	
        else
        # if file is not found then break
        echo "$(tput setaf 3)FILE NOT FOUND!$(tput sgr0)"
        exit 1
        fi
fi

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#

if [ $option == 4 ];then
	
	sh check_irods_key.sh

        if [ ! $? == 0 ];then
                sh login.sh
        fi

        ils
        echo
        iget -fVP $file_to_split

        if [ -d ./splits ];then
                rm -r splits
        fi
        mkdir splits

        rm path
        echo $file_to_split >> path
        tempfolder=$file_to_split
        file_to_split=`basename $file_to_split`
        #echo $file_to_split

        # split it
        if [ -f $file_to_split ];then
        #if exists -> split
		awk '/SPLIT_HERE/{n++}{print>"splits/out"n".txt" }' $file_to_split
	
        ###### UPLOAD TO IRODS
        tempfolder=`sed s/$file_to_split//g path`
        #echo "file_to_split=$file_to_split"
	#echo "tempfolder=$tempfolder"
	iput -fr splits/ $tempfolder/


        else
        # if file is not found then break
        echo "$(tput setaf 3)FILE NOT FOUND!$(tput sgr0)"
        exit 1
        fi

fi

#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#_#
