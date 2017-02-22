#!/bin/bash
cd ../../

#Clone repositirues of the required layers
git clone --branch morty git://git.yoctoproject.org/meta-xilinx

#Set up bitbake
. oe-init-build-env
bitbake-layers add-layer ../meta-xilinx
bitbake-layers add-layer ../meta-caribou
sed -i 's/^MACHINE ??= ".*"/MACHINE ??= "caribou-zynq7"/' conf/local.conf

#Enable PR service, in order to always download the latest versions
#from the git repositories
echo '#PR service 
PRSERV_HOST = "localhost:0"' >> conf/local.conf
