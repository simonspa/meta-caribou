#!/bin/bash
cd ../../

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
