# clear workspace
if [ -f visflow.sh0 ];then
	rm visflow.sh*
fi

#set variables
pass=`head -n 1 .config|tail -n 1`
dir=`head -n 2 .config|tail -n 1`
script=`head -n 3 .config|tail -n 1`
main='visflow.sh'
mult_files=`head -n 4 .config|tail -n 1`
file_or_dir=`head -n 5 .config|tail -n 1`
num_chunks=`head -n 6 .config|tail -n 1`
args=`head -n 7 .config|tail -n 1`


i=0
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

<<COMMENT
echo "
	$pass
	$dir
	$script
	$mult_files
	$file_or_dir
	$num_chunks
"
COMMENT
if [ $mult_files = yes ];then
	if [ $i -lt 10 ];then
		echo "iget -fVP $dir/$file_or_dir">>./Makeflow_dir/$main$i
		echo "iget -fVP $dir/$script">>./Makeflow_dir/$main$i
		echo 'sh '"$script $args >out.$i">>./Makeflow_dir/$main$i
		echo "imkdir $dir/output">>./Makeflow_dir/$main$i
		echo "iput -f out.$i $dir/output">>./Makeflow_dir/$main$i

	fi
	if [ $i -gt 9 ];then
		echo "iget -fVP $dir/$file_or_dir">>./Makeflow_dir/$main$i
		echo "iget -fVP $dir/$script">>./Makeflow_dir/$main$i
		echo 'sh '"$script $args>out.$i">>./Makeflow_dir/$main$i
		echo "imkdir $dir/output">>./Makeflow_dir/$main$i
		echo "iput -f out.$i $dir/output">>./Makeflow_dir/$main$i

	fi

fi

if [ $mult_files = no ];then
	if [ $i -lt 10 ];then
		echo "iget -fVP $dir/$file_or_dir/out0$i">>./Makeflow_dir/$main$i
		echo "iget -fVP $dir/$script">>./Makeflow_dir/$main$i
		echo 'sh '"$script $args >out.$i">>./Makeflow_dir/$main$i
		echo "imkdir $dir/output">>./Makeflow_dir/$main$i
		echo "iput -f out.$i $dir/output">>./Makeflow_dir/$main$i

	fi
	if [ $i -gt 9 ];then
		echo "iget -fVP $dir/$file_or_dir/out0$i">>./Makeflow_dir/$main$i
		echo "iget -fVP $dir/$script">>./Makeflow_dir/$main$i
		echo 'sh '"$script $args>out.$i">>./Makeflow_dir/$main$i
		echo "imkdir $dir/output">>./Makeflow_dir/$main$i
		echo "iput -f out.$i $dir/output">>./Makeflow_dir/$main$i
	fi
fi


let i=$i+1
done
