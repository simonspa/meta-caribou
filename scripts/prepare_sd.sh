#!/bin/bash

SD_DEVICE_DEFAULT="/dev/mmcblk0"
DEVICE_NAME_DEFAULT="pclcd-zynq"

#Colours
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
RED="\033[0;31m"
NC='\033[0m'

cd ../../

#Set up bitbake
. oe-init-build-env

#Build wic dependencies
bitbake parted-native dosfstools-native mtools-native

#Create image
IMAGE_PATH=$PWD/$( basename $( wic create sdimage-bootpart -e caribou-image 2>&1 | tee /dev/tty | grep "INFO: The new image(s) can be found here:" -A1 | sed -n '2p' ) )

#Copy image to the SD card
read -p "Please enter absolute path SD card device [$SD_DEVICE_DEFAULT]: " SD_DEVICE
SD_DEVICE=${SD_DEVICE:-$SD_DEVICE_DEFAULT}
#Get device name
read -p "Please enter the target deivce name from list: pclcd-zynq, pclcd-testbeam-zynq, pclcd-lab-zynq1 [pclcd-zynq]: " DEVICE_NAME
DEVICE_NAME=${DEVICE_NAME:-$DEVICE_NAME_DEFAULT}
if sudo dd if=${IMAGE_PATH} of=$SD_DEVICE bs=1M ; then
    #Wait till dd finishes
    printf "${ORANGE}Waiting for coping process to complete...\n"
    sudo sync

    printf "${GREEN}Done.\n"
else
    printf "${RED}Coping process failed !\n"
fi
#Assign MAC address
mkdir -p boot
sudo mount -o umask=000  ${SD_DEVICE_DEFAULT}p1 boot
case "$DEVICE_NAME" in
    "pclcd-zynq"      ) mac="00:0A:35:00:01:24";;
    "pclcd-testbeam-zynq"  ) mac="00:0A:35:00:01:23";;
    "pclcd-lab-zynq1" ) mac="00:0A:35:00:01:25";;
    *                 ) printf "${RED}Unknown device name. Can't assign the MAC address !\n";
			printf "${NC}\n";
			rm -R boot;
			rm $IMAGE_PATH;
			exit 1;;
esac
echo "ethaddr=${mac}" >> boot/uEnv.txt
sudo umount boot
rm -R boot
rm $IMAGE_PATH
printf "${NC}\n"

