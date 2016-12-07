#!/bin/bash
cd ../../

#Clone repositirues of the required layers
git clone git://git.yoctoproject.org/meta-xilinx

#Set up bitbake
. oe-init-build-env
bitbake-layers add-layer ../meta-xilinx
bitbake-layers add-layer ../meta-caribou
sed -i 's/^MACHINE ??= ".*"/MACHINE ??= "zc706-zynq7"/' conf/local.conf
