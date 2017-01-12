require recipes-extended/images/core-image-full-cmdline.bb

SUMMARY = "Image for the Caribou DAQ Framework"

PACKAGE_CLASSES ?= "package_deb"

IMAGE_FEATURES += "package-management"
EXTRA_IMAGE_FEATURES ?= "debug-tweaks dev-pkgs tools-sdk"

IMAGE_INSTALL += " caribou-mod cmake git subversion python python3 python-numpy nfs-utils sysstat i2c-tools"

IMAGE_BOOT_FILES = "${KERNEL_IMAGETYPE} ${KERNEL_IMAGETYPE}-zynq-zc706.dtb ${UBOOT_BINARY} caribou-image-zc706-zynq7.cpio.gz.u-boot uEnv.txt boot.bin download.bit"
