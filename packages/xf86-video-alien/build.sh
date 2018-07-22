TERMUX_PKG_VERSION=0.0.1
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_DEPENDS="xorg-server"

termux_step_extract_package() {
	mkdir -p $TERMUX_PKG_SRCDIR
	cp -r $TERMUX_PKG_BUILDER_DIR/src/* $TERMUX_PKG_SRCDIR/
}

#termux_step_post_extract_package() {
#	exit 1
#}

termux_step_pre_configure () {
	autoreconf -if
}
