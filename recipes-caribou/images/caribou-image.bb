require recipes-extended/images/core-image-full-cmdline.bb

IMAGE_INSTALL += " cmake git subversion python python3 python-numpy nfs-utils sysstat"

IMAGE_BOOT_FILES = "${KERNEL_IMAGETYPE} ${KERNEL_IMAGETYPE}-zynq-zc706.dtb ${UBOOT_BINARY} caribou-image-zc706-zynq7.cpio.gz.u-boot uEnv.txt boot.bin download.bit"
