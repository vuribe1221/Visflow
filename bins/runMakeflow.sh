export PATH=~/cctools/bin/:${PATH}
if [ -f Makeflow.makeflowlog];then
	rm Makeflow.*
fi
makeflow -T wq -aN vuribe -p 55500
