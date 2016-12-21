SRC_URI = "git://git@gitlab.cern.ch:7999/Caribou/peary-firmware.git;protocol=ssh;"
SRCREV = "447ca4e0ec5e5844b3882541f39f1d0a622637e6"

PV = "+git${SRCPV}"

MACHINE_DEVICETREE_prepend = " \
			   git/outputs/system.dts \
			   git/outputs/skeleton.dtsi \
			   git/outputs/zynq-7000.dtsi \
			   "

DEVICETREE = "${@os.path.join( d.getVar("WORKDIR", True), 'git/outputs/system.dts' ) }"


