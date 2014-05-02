t is the config file?
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
#	for loop
i=1

## create make folder for makeflow
if [ -d Makeflow_dir ];then
	rm -fr Makeflow_dir
fi
mkdir -p Makeflow_dir

## start making the Makeflow file
echo -e ":\n" > ./Makeflow_dir/Makeflow

while [ $i -le $num_chunks ];
	do
	echo -e "$out_name$i.out: $name$i">>./Makeflow_dir/Makeflow
	echo -e "\tsh $name$i > $out_name$i.out">>./Makeflow_dir/Makeflow

	let i=$i+1
done
