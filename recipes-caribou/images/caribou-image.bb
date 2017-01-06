require recipes-extended/images/core-image-full-cmdline.bb

SUMMARY = "Image for the Caribou DAQ Framework"

PACKAGE_CLASSES ?= "package_deb"

IMAGE_FEATURES += "package-management"
EXTRA_IMAGE_FEATURES ?= "debug-tweaks dev-pkgs tools-sdk"

IMAGE_INSTALL += " cmake git subversion python python3 python-numpy nfs-utils sysstat"
