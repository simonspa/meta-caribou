FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://spidev.cfg \
	    file://0001-Add-support-for-I2C-PCA984x-family-switch-multiplexe.patch \
	    file://0002-Add-caribou-chip-compatibility-to-spidev-driver.patch \
	    file://0003-Add-spi-bits-per-word-binding.patch \
	    file://0004-Fix-SPI-xilinx-driver-to-respect-bits_per_word.patch \
	    file://0005-SPI-device-driver-lets-the-SPI-core-to-drive-the-SS-.patch \
	    file://ARM-zynq-Reserve-correct-amount-of-non-DMA-RAM.patch \
	   "
