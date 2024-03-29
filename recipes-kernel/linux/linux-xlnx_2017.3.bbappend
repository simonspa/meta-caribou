FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://spidev.cfg \
	    file://0001-i2c-Add-support-for-NXP-PCA984x-family.patch \
	    file://0001-i2c-add-i2c_get_device_id-to-get-the-standard-i2c-de.patch \
	    file://0002-i2c-mux-pca954x-verify-the-device-id-of-the-pca984x-.patch \
	    file://0002-Add-caribou-chip-compatibility-to-spidev-driver.patch \
	    file://0003-Add-spi-bits-per-word-binding.patch \
	    file://0004-Fix-SPI-xilinx-driver-to-respect-bits_per_word.patch \
	    file://0005-SPI-device-driver-lets-the-SPI-core-to-drive-the-SS-.patch \
	    file://0001-Fix-power-managment-in-spi-xilinx.c.patch \
	   "
