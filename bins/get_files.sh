#!/bin/bash

cd ~
# install irods
wget http://www.iplantcollaborative.org/sites/default/files/irods/icommands.x86_64.tar.bz2
tar -xf icommands.x86_64.tar.bz2
export PATH=~/icommands/:${PATH}

cp .irodsA ~/.irods/
cp .irodsEnv ~/.irods/

# downloads folder of files and scripts (variable)

# run stuff
sh *.sh

# upload stuff

