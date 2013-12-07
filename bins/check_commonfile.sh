# set variables
common_file='.logo'
md5=`md5sum $common_file|cut -d ' ' -f 1`
## check for common file
if [ -f ~/$common_file ];then	
	## check md5
	echo `head -n 8 .config|tail -n 1|cut -d ' ' -f 1`
	while [ ! `head -n 8 .config|tail -n 1|cut -d ' ' -f 1` = $md5 ];
	do
		md5=`md5sum $common_file|cut -d ' ' -f 1`
		echo $md5
		echo "Common file not complete..."
	## if not finished wait for a minute
		sleep 10
	done
	echo "Common file found and is complete."
else
	echo "File not found!"
fi



