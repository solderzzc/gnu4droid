TERMUX_PKG_HOMEPAGE=https://wiki.gentoo.org/wiki/Project:Eudev
TERMUX_PKG_DESCRIPTION="A device manager for the Linux kernel"
TERMUX_PKG_VERSION=3.2.5
TERMUX_PKG_SHA256=49c2d04105cad2526302627e040fa24b1916a9a3e059539bc8bb919b973890af
TERMUX_PKG_SRCURL=https://dev.gentoo.org/~blueness/eudev/eudev-$TERMUX_PKG_VERSION.tar.gz
#TERMUX_PKG_EXTRA_CONFIGURE_ARGS="--disable-introspection --disable-programs --disable-hwdb"
TERMUX_PKG_DEPENDS="libandroid-support, libandroid-glob"

termux_step_pre_configure() {
	[ -x $TERMUX_PKG_SRCDIR/autogen.sh ] && $TERMUX_PKG_SRCDIR/autogen.sh
	CFLAGS="$CFLAGS \
	-DLINE_MAX=2048 \
	-DRLIMIT_NLIMITS=15 \
	-DIPTOS_LOWCOST=2 \
	-DSG_FLAG_LUN_INHIBIT=SG_FLAG_UNUSED_LUN_INHIBIT \
	-Dprogram_invocation_short_name=get_argv0\(\) \
	-std=gnu99 \
	-include $TERMUX_PREFIX/include/libandroid-support/extra.h"
}

termux_step_post_configure() {
	cp -f $TERMUX_PKG_BUILDER_DIR/keyboard-keys.txt $TERMUX_PKG_SRCDIR/src/udev/
}
