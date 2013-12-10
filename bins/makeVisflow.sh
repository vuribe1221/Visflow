# clear workspace
prefix=''
if [ -f visflow.sh0 ];then
	rm visflow.sh*
fi

#set variables
pass=`head -n 1 .config|tail -n 1`
dir=`head -n 2 .config|tail -n 1`
script=`head -n 3 .config|tail -n 1`
main='visflow.sh'
single_file=`head -n 4 .config|tail -n 1`
file_or_dir=`head -n 5 .config|tail -n 1`
num_chunks=`head -n 6 .config|tail -n 1`
args=`head -n 7 .config|tail -n 1`
com_exists=`head -n 8 .config|tail -n 1`
com_file=`head -n 9 .config|tail -n 1`
com_sum=`head -n 10 .config|tail -n 1`
#name=`basename $file_or_dir`
name=`head -n 11 .config|tail -n 1`
file_or_dir=`echo $file_or_dir|sed "s/\/$name//g"`
if [ $single_file = yes ];then
	let num_chunks=1
fi
i=1
while [ $i -lt $num_chunks ];
do
	echo 'export PATH=~/icommands:${PATH}'>>./Makeflow_dir/$main$i
	echo "
	iinit -e $pass
	if [ ! -d ~/.irods ];then
		mkdir -p ~/.irods
	fi

	cp -f .irodsEnv ~/.irods/
	if [ ! -d ~/icommands ];then
		wget http://www.iplantcollaborative.org/sites/default/files/irods/icommands.x86_64.tar.bz2
		tar -xf icommands.x86_64.tar.bz2
		cp icommands ~/
	
	fi">>./Makeflow_dir/$main$i

if [ $single_file = yes ];then
	
	if [ $i -lt 10 ];then
		# iget necessary files
		echo 'export PATH=~/lastz-distrib/bin/:${PATH}'>>./Makeflow_dir/$main$i
		echo "iget -fP $dir/$file_or_dir/$name$>>iget_files">>./Makeflow_dir/$main$i
		if [ $com_exists = yes ];then
			echo -e "if [ ! -f ~/$com_file ];then\n\tiget -fVP $dir/$com_file ~/>>iget_files\nfi">>./Makeflow_dir/$main$i
		fi
		echo "cp ~/$com_file .">>./Makeflow_dir/$main$i
		echo "iget -fP $dir/$script>>iget_files">>./Makeflow_dir/$main$i
		# commands for worker
		echo "$prefix $script $com_file $file_or_dir $args >$file_or_dir.out">>./Makeflow_dir/$main$i

		# output directory
		echo "imkdir -p $dir/visflow_output">>./Makeflow_dir/$main$i
		echo "iput -f $file_or_dir.out $dir/visflow_output">>./Makeflow_dir/$main$i

	fi
else 
	if [ $i -lt 100 ];then
		# iget necessary files
		echo 'export PATH=~/lastz-distrib/bin/:${PATH}'>>./Makeflow_dir/$main$i
		echo "iget -fP $dir/input-files/$name$i>>iget_files">>./Makeflow_dir/$main$i
		if [ $com_exists = yes ];then
			echo -e "if [ ! -f ~/$com_file ];then\n\tiget -fVP $dir/$com_file ~/>>iget_files\nfi">>./Makeflow_dir/$main$i
		fi
		echo "cp ~/$com_file .">>./Makeflow_dir/$main$i
		echo "iget -fP $dir/$script>>iget_files">>./Makeflow_dir/$main$i
	
		# commands for worker
		echo "$prefix $script $com_file $name$i $args >$name$i.out">>./Makeflow_dir/$main$i

		# output directory
		echo "imkdir -p $dir/visflow_output">>./Makeflow_dir/$main$i
		echo "iput -f $name$i.out $dir/visflow_output">>./Makeflow_dir/$main$i

	fi
fi

let i=$i+1
done
