# Meta-Caribou

[![build status](https://gitlab.cern.ch/Caribou/meta-caribou/badges/master/build.svg)](https://gitlab.cern.ch/Caribou/meta-caribou/commits/master)

Configuration files and scripts for preparing, building and deploying the Yocto Poky distribution for the Caribou board Xilinx ZC706-ZYNQ.
A good starting point is following the [quick start guide](http://www.yoctoproject.org/docs/2.0/yocto-project-qs/yocto-project-qs.html) of the Yocto project and reading the github [documentation of the meta-xilinx package](https://github.com/Xilinx/meta-xilinx/blob/master/README.md) and links therein.

# Getting started immadeitely

The most straight forward way to use the Caribou Linux distribution relies on the already built `meta-caribou` image.
 * Grab the latest [built](http://project-meta-caribou.web.cern.ch/project-meta-caribou/sdimage-latest-mmcblk.zip) --- it is based on latest commit from the _master_ branch.<br />
 You can also download the other recent commits from the [webpage](http://project-meta-caribou.web.cern.ch/project-meta-caribou/).
 * Unzip the image

 ```
  unzip sdimage-latest-mmcblk.zip
 ```
 
 * Burn the image on your SD card. On Linux host, you can use _dd_ command.<br />
 Replace `IMAGE_NAME` with a name of name of the unzipped file (e.g. sdimage-ac3c091e-mmcblk.direct) and `SD_DEVICE_PATH` with the device path of your SD card (e.g. /dev/mmcblk0).
 
 ```
 sudo dd if=IMAGE_NAME of=SD_DEVICE_PATH bs=1M && sync
 ```
 * Stick it into the SD card slot of your ZC706 board
 * make sure, the jumpers J32 (big blue box) are in positions 0-0-1-1-0 (for jumper 1-2-3-4-5) in order to boot from the SD card
 * Flip the power switch! Your board should boot now and attempt to get an IP address from any DHCP server using the default MAC address (00:0A:35:00:01:23).

# Building the Caribou Linux distribution yourself
You can also build `meta-caribou` image yourself from scratch on your local machine. You can choose between two flows:
* based in the provided _Docker_ container
* build in your host's environment

### Dependencies

This layer depends on:

 * URI: git://git.yoctoproject.org/poky branch: rocko

 * URI: git://git.yoctoproject.org/meta-xilinx branch: master

 * URI: git://git.openembedded.org/meta-openembedded/ branch: rocko

### Build process using a Docker container
It is possible to produce the SD card image with `meta-caribou` benefiting a [_Docker_](https://www.docker.com/) virtualization.
This way, you avoid any dependency issues between `yocto` and your host's operating system. This flow requires an installation of _Docker_ in free Community Edition.
Details can be found on _Docker's_ webpage (e.g. [CentOS installation](https://store.docker.com/editions/community/docker-ce-server-centos)).

Having _Docker_ installed on your host, run the command below

  ```
  $ source <(curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/misc/remote_scripts/build.sh)
  ```
The process will create in the working directory three directories:
  * _downloads_ : store of fetched sources used to build the `meta-caribou` image
  * _sstate-cache_ : store the intermediate stages of image generation
  * _wic_ : with the stored image (e.g. _sdimage-04b06ff9-mmcblk.direct_)

If the command is called again in the same working directory, the process reuses _downloads_ and _sstate-cache_ directories what significantly increase build time.
The image name includes a hash of a commit used to build it.

### Build process in your host's environment

In order to setup the poky environment, including meta-caribou layer with its dependencies, run the command below

```
$ source <(curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/misc/remote_scripts/setup.sh)

```
Afterwards, initialize the built environment via

```
$ cd poky/
$ source oe-init-build-env
```

Run the build from the `build/` directory using `bitbake` and the selected target, in this case `caribou-image`:

```
$ bitbake caribou-image
```

The output files will be located at `build/tmp/deploy/images/zc706-zynq7/` and can be copied to the appropriate locations on the SD card using the tool described below.


### MAC address
In order to set the MAC address of the Caribou board other than the default (00:0A:35:00:01:23), one should modify the first line in the `uEnv.txt` file located on the `boot` partition of the SD card.

## Additional tools

### `prepare_sd.sh`

The tool prepares SD card. Make sure that all partitions are unmounted before calling the script.

The tool asks for a root block device of the SD card reader (i.e. /dev/mmcblk0), not device associated with a partition (i.e. /dev/mmcbk0p1).

The prepared SD card contains two [partitions](https://github.com/Xilinx/meta-xilinx/blob/master/README.booting.md#preparing-sdmmc): `boot` and `root`.

### `femtocom.sh`

Small tool to connect to the ZC706 board via the UART USB port. The serial interface module cp210x has to be loaded. Use `dmesg` to check where the serial interface connects to, usually this is `/dev/ttyUSB0`.

Run femtocom via

```
$ sudo ./femtocom.sh /dev/ttyUSB0 115200
```

where the latter is the baud rate suitable for the ZC706 board.
