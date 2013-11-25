echo "Searching for irods cookie!"

if [ ! -f ~/.irods/.irodsEnv ];then
	echo "Irods cookie NOT found! Please run and login to irods through this terminal."
exit 1
fi

echo "DONE!"
exit 0


