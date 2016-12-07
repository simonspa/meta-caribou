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

 * URI: git://git.openembedded.org/bitbake  
  branch: master

 * URI: git://git.openembedded.org/openembedded-core  
  layers: meta
  branch: master

 * URI: git://git.yoctoproject.org/meta-xilinx  
  branch: master

### Preparation

* Install the latest version of yocto
  ```
  $ git clone git://git.yoctoproject.org/poky
  ```

* Install this caribou layer
  ```
  $ git clone git clone ssh://git@gitlab.cern.ch:7999/Caribou/meta-caribou.git
  ```

In order to use the caribou layer, you need to make the build system aware of
it. Moreover, you need to install and add all the dependency layers. Thus, from `meta-caribou/scripts` call the script:
  ```
  $ ./addCaribouLayer.sh
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


## Additional tools

### `prepare_sd.sh`

Copies the build output files to the correct location on the SD card and prepares the environment configuration for the U-Boot bootloader following the initial instructions found [here](https://github.com/Xilinx/meta-xilinx/blob/master/README.booting.md#preparing-sdmmc).

Before running the tool, the SD card should be prepared with two partitions:
* The first partition should be of type FAT16 (vfat) and have a size of about 1G
* The second partition should be of type ext4 and span the rest of the available space

With both partitions mounted, the tool can be executed. It asks for the absolute paths of both partitions as well as the desired MAC address of the 1GbE network interface. Enter the MAC address with capitalized letters and a colon as separator.

The tool will copy all files to the SD card and will eventually as whether to overwrite the `uEnv.sh` file. For fresh installations, always choose "yes". Skipping this step would allow the preservation of manual changes to the file such as an altered MAC address.

### `femtocom.sh`

Small tool to connect to the ZC706 board via the UART USB port. The serial interface module cp210x has to be loaded. Use `dmesg` to check where the serial interface connects to, usually this is `/dev/ttyUSB0`.

Run femtocom via

```
$ sudo ./femtocom.sh /dev/ttyUSB0 115200
```

where the latter is the baud rate suitable for the ZC706 board.
