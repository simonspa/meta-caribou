#!/bin/bash

SD_DEVICE_DEFAULT="/dev/mmcblk0"
DEVICE_NAME_DEFAULT="pclcd-zynq0"
IMAGE_NAME=caribou-image

#Colours
ORANGE='\033[0;33m'
GREEN='\033[0;32m'
RED="\033[0;31m"
NC='\033[0m'

cd ../../

#Set up bitbake
. oe-init-build-env ""

#Build wic dependencies
bitbake wic-tools

#Create image
IMAGE_PATH=$PWD/$( basename $( wic create sdimage-bootpart -e ${IMAGE_NAME} 2>&1 | tee /dev/tty | grep "INFO: The new image(s) can be found here:" -A1 | sed -n '2p' ) )

#Copy image to the SD card
read -p "Please enter absolute path SD card device [$SD_DEVICE_DEFAULT]: " SD_DEVICE
SD_DEVICE=${SD_DEVICE:-$SD_DEVICE_DEFAULT}
#Get device name
read -p "Please enter the target deivce name from list: pclcd-lab-zynq, pclcd-testbeam-zynq, pclcd-zynqX [$DEVICE_NAME_DEFAULT]: " DEVICE_NAME
DEVICE_NAME=${DEVICE_NAME:-$DEVICE_NAME_DEFAULT}
if sudo dd if=${IMAGE_PATH} of=$SD_DEVICE bs=1M ; then
    #Wait till dd finishes
    printf "${ORANGE}Waiting for copying process to complete...\n"
    sudo sync

    printf "${GREEN}Done.\n"
else
    printf "${RED}Copying process failed !\n"
fi
#Assign MAC address
mkdir -p boot
sudo mount -o umask=000  ${SD_DEVICE_DEFAULT}p1 boot
case "$DEVICE_NAME" in
    "pclcd-lab-zynq"       ) mac="00:0A:35:00:02:00";;
    "pclcd-testbeam-zynq"  ) mac="00:0A:35:00:02:01";;
    "pclcd-zynq0"          ) mac="00:0A:35:00:03:00";;
    "pclcd-zynq1"          ) mac="00:0A:35:00:03:01";;
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

