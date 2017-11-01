#!/bin/bash
# The script adds meta-caribou layer with its dependencies to the poky framework.
# It assumes that meta-caribou has been cloned to the 'poky' directory.

SOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  DIR="$( cd -P "$( dirname "$SOURCE" )" && pwd )"
  SOURCE="$(readlink "$SOURCE")"
  [[ $SOURCE != /* ]] && SOURCE="$DIR/$SOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
SCRIPT_PATH="$( cd -P "$( dirname "$SOURCE" )" && pwd )"

cd $SCRIPT_PATH/../../

#Clone repositirues of the required layers
git clone --branch pyro git://git.yoctoproject.org/meta-xilinx
#gnuplot
git clone --branch pyro git://git.openembedded.org/meta-openembedded/

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
