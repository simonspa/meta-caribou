FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-Enable-bit-file-download.patch \
            file://uEnv.txt \
            file://0001-Remove-CONFIG_SPL_OS_BOOT.patch \
            "

UBOOT_ENV = "uEnv"
