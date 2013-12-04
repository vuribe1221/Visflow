# clear workspace
rm visflow.sh*

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
	echo 'export PATH=~/icommands:${PATH}'>>$main$i
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
	
	fi">>$main$i

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

	if [ $i -lt 10 ];then
		echo "iget -VP $dir/$file_or_dir/out0$i">>$main$i
		echo "iget -VP $dir/$script">>$main$i
		echo 'sh '"$script $args >out.$i">>$main$i
		echo "imkdir $dir/output">>$main$i
		echo "iput -f out.$i $dir/output">>$main$i

	fi
	if [ $i -gt 9 ];then
		echo "iget -VP $dir/$file_or_dir/out$i">>$main$i
		echo "iget -VP $dir/$script">>$main$i
		echo 'sh '"$script $args>out.$i">>$main$i
		echo "imkdir $dir/output">>$main$i
		echo "iput -f out.$i $dir/output">>$main$i

	fi


let i=$i+1
done
