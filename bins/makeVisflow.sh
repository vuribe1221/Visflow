#what is the config file?
config_file='.config'

#instantiate .config variables
exec=`head -n 1 $config_file|tail -n 1`
dir=`head -n 2 $config_file|tail -n 1`
script=`head -n 3 $config_file|tail -n 1`
single_file=`head -n 4 $config_file|tail -n 1`
file_or_dir=`head -n 5 $config_file|tail -n 1`
num_chunks=`head -n 6 $config_file|tail -n 1`
args=`head -n 7 $config_file|tail -n 1`

#more variables
out_name=vis
name=visflow.sh
usrname=`head -n 3 ~/.irods/.irodsEnv|tail -n 1|cut -d ' ' -f 2`
main=visflow.sh
output_folder=VisflowResults
#	for loop
i=1

echo $usrname
#resets the website table
echo "curl -s 'http://visflow.info/update.php?mode=reset&table=$usrname'">>this.sh;sh this.sh;rm this.sh;

#creates a new table on site
echo "curl -s 'http://visflow.info/update.php?mode=create&table=$usrname'">>this.sh;sh this.sh;rm this.sh;echo

while [ $i -le $num_chunks ];
	do
		echo "curl -s 'http://visflow.info/update.php?mode=add&table=$usrname&id=$i&status=1'">>./Makeflow_dir/$main$i
		#get files from irods
		case $single_file in
			Yes ) echo -e "iget -fKPr $dir/ .">>./Makeflow_dir/$main$i;
			echo -e "cd $dir">>./Makeflow_dir/$main$i;
			
			if [ ! -z $args ];then
				echo -e "$exec $script $args $file_or_dir > $script.out$i">>./Makeflow_dir/$main$i;
			else 
				echo -e "$exec $script $file_or_dir > $script.out$i">>./Makeflow_dir/$main$i;
			fi
			
			echo -e "imkdir -p $output_folder">>./Makeflow_dir/$main$i;
			#echo -e "cd .."
			echo -e "iput -fabkr *.out* $output_folder">>./Makeflow_dir/$main$i;;
			
			No ) echo "NOT YET IMPLEMENTED";;
		esac
		
		let i=$i+1
	done

