TERMUX_PKG_HOMEPAGE=https://www.x.org
TERMUX_PKG_VERSION=1.3.5
TERMUX_PKG_SRCURL=https://www.x.org/archive//individual/lib/xtrans-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=adbd3b36932ce4c062cd10f57d78a156ba98d618bdb6f50664da327502bc8301
TERMUX_PKG_NO_DEVELSPLIT=true
TERMUX_PKG_BUILD_DEPENDS="x11-proto"
termux_step_post_make_install () {
	mkdir -p $TERMUX_PREFIX/lib/pkgconfig
	mv $TERMUX_PREFIX/share/pkgconfig/xtrans.pc $TERMUX_PREFIX/lib/pkgconfig
}
