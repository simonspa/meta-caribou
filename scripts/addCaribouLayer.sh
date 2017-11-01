#!/bin/bash
# The script adds meta-caribou layer with its dependencies to the poky framework.
# It assumes that meta-caribou has been cloned to the 'poky' directory.

export XILINX_VERSION="pyro"
export OPENEMBEDED_VERSION="pyro"

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_PATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $SCRIPT_PATH/../../

###########################################
#Clone repositirues of the required layers
###########################################
if [ ! -d meta-xilinx ]; then
    git clone --branch $XILINX_VERSION git://git.yoctoproject.org/meta-xilinx
else
    git -c meta-xilinx pull
    git -c meta-xilinx checkout $XILINX_VERSION
fi

if [ ! -d meta-openembedded ]; then
    #gnuplot
    git clone --branch $OPENEMBEDED_VERSION git://git.openembedded.org/meta-openembedded/
else
    git -c meta-openembedded pull
    git -c meta-openembedded checkout $OPENEMBEDED_VERSION
fi
    

#Set up bitbake
. oe-init-build-env
bitbake-layers add-layer ../meta-xilinx
bitbake-layers add-layer ../meta-caribou
bitbake-layers add-layer ..//meta-openembedded/meta-oe
sed -i 's/^MACHINE ??= ".*"/MACHINE ??= "caribou-zynq7"/' conf/local.conf

#Enable PR service, in order to always download the latest versions
#from the git repositories
echo '#PR service 
PRSERV_HOST = "localhost:0"' >> conf/local.conf
