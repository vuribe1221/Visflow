#!/bin/bash
pass=`head -n 1 .config|tail -n 1`
dir=`head -n 2 .config|tail -n 1`
#script=`head -n 3 .config|tail -n 1`
script='visflow.sh'
mult_files=`head -n 4 .config|tail -n 1`
file_or_dir=`head -n 5 .config|tail -n 1`
num_chunks=`head -n 6 .config|tail -n 1`

## start making the Makeflow file
echo -e ":\n" > Makeflow

## files to transfer to each worker
if [ $mult_files = no ];then
	num=1
fi

i=0
while [ $i -lt $num_chunks ];
	do
	echo "output$i: $script$i .irodsEnv .config">>Makeflow
	echo -e "\tsh $script$i > output$i">>Makeflow
	
	let i=$i+1
done



