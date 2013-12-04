#!/bin/bash
pass=`head -n 1 .config|tail -n 1`
dir=`head -n 2 .config|tail -n 1`
#script=`head -n 3 .config|tail -n 1`
single_file=`head -n 4 .config|tail -n 1`
file_or_dir=`head -n 5 .config|tail -n 1`
num_chunks=`head -n 6 .config|tail -n 1`
script='visflow.sh'

## create make folder for makeflow
mkdir Makeflow_dir

## start making the Makeflow file
echo -e ":\n" > ./Makeflow_dir/Makeflow

## files to transfer to each worker
if [ $single_file = yes ];then
	num_chunks=1
fi

i=0
while [ $i -lt $num_chunks ];
	do
	echo "output$i: $script$i .irodsEnv .config">>./Makeflow_dir/Makeflow
	echo -e "\tsh $script$i > output$i">>./Makeflow_dir/Makeflow
	
	let i=$i+1
done



