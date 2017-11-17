# Meta-Caribou

Configuration files and scripts for preparing, building and deploying the Yocto Poky distribution for the Caribou board Xilinx ZC706-ZYNQ.

A good starting point is following the [quick start guide](http://www.yoctoproject.org/docs/2.0/yocto-project-qs/yocto-project-qs.html) of the Yocto project and reading the github [documentation of the meta-xilinx package](https://github.com/Xilinx/meta-xilinx/blob/master/README.md) and links therein.

## Preparing an SD Card for the ZC706 Board

If you only want to prepare an SD card and run the tested Caribou Release on your ZC706 board, you just have to follow these instructions:

* Grab the binary files from the latest [release](https://gitlab.cern.ch/Caribou/meta-caribou/tags)
* Format your SD card:
  * The first partition should be of type FAT16 (vfat) and have a size of about 1G
  * The second partition should be of type ext4 and span the rest of the available space
* Use the `prepare_sd.sh` tool (see below) to flash all files to the appropriate destinations.
* Stick it into the SD card slot of your ZC706 board
* make sure, the jumpers J32 (big blue box) are in positions 0-0-1-1-0 (for jumper 1-2-3-4-5) in order to boot from the SD card
* Flip the power switch! Your board should boot now and attempt to get an IP address from any DHCP server using the MAC address you provided to the `prepare_sd.sh` tool.

## Building the Caribou Linux distribution for ZC706

### Dependencies

This layer depends on:

 * URI: git://git.yoctoproject.org/poky tag: pyro-17.0.2

 * URI: git://git.yoctoproject.org/meta-xilinx branch: pyro

 * URI: git://git.openembedded.org/meta-openembedded/ branch: pyro

### Preparation
In order to setup the poky environment, including meta-caribou layer with its dependencies, run the command below

  ```
  $ source <(curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/misc/remote_scripts/setup.sh)

  ```

### Build process
Initialize the build environment via

```
$ cd poky/
$ source oe-init-build-env
```

Run the build from the `build/` directory using `bitbake` and the selected target, in this case a `caribou-image`:

```
$ bitbake caribou-image
```

The output files will be located at `build/tmp/deploy/images/zc706-zynq7/` and can be copied to the appropriate locations on the SD card using the tool described below.

### Build process using Docker image
Conversely, it is possible to produce the SD card image with `meta-caribou` benefiting a ['Docker'](https://www.docker.com/) virtualization.
This way, a user avoids any dependency issues between `yocto` and his host operating system. This flow requires an installation of 'Docker' in free Community Edition.
Details can be found on Docker's webpage (e.g. [CentOS installation](https://store.docker.com/editions/community/docker-ce-server-centos)).

Having 'Docker' installed locally, user runs a command below

  ```
  $ source <(curl -s https://gitlab.cern.ch/Caribou/meta-caribou/raw/master/misc/remote_scripts/build.sh)
  ```
The process will create in the working directory three directories:
  * `downloads` : store of fetched sources used to build the `meta-caribou` image
  * `sstate-cache` : store the intermediate stages of image generation
  * `wic` : with the stored image (e.g. `sdimage-04b06ff9-mmcblk.direct`)

If the command is called again in the same working directory, the process reuses `downloads` and `sstate-cache` directories what significantly increase build time.
The image name includes a hash of a commit used to build it.
    

### MAC address
In order to set the MAC address of the Caribou board other than default (00:0A:35:00:01:23), one shold modify first line in the `uEnv.txt` file located on the `boot` partition of the SD card.

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
