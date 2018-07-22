TERMUX_PKG_VERSION=1.19.6
TERMUX_PKG_SRCURL=https://www.x.org/archive/individual/xserver/xorg-server-$TERMUX_PKG_VERSION.tar.bz2
TERMUX_PKG_SHA256=a732502f1db000cf36a376cd0c010ffdbf32ecdd7f1fa08ba7f5bdf9601cc197
TERMUX_PKG_BUILD_IN_SRC=yes
TERMUX_PKG_EXTRA_CONFIGURE_ARGS="
--disable-static
--disable-libdrm
--disable-glx
--disable-mitshm
--enable-composite
--enable-xres
--enable-record
--disable-xvmc
--disable-screensaver
--enable-present
--disable-xinerama
--disable-xace
--disable-dbe
--disable-dpms
--disable-xfree86-utils
--disable-vgahw
--disable-vbe
--disable-int10-module
--disable-dri
--disable-dri2
--disable-dri3
--disable-input-thread
--disable-glamor
--disable-xf86vidmode
--disable-xf86bigfont
--disable-clientids
--disable-linux-acpi
--disable-linux-apm
--disable-strict-compilation
--enable-listen-tcp
--disable-listen-unix
--enable-listen-linux
--disable-visibility
--disable-xnest
--disable-xquartz
--disable-xwin
--disable-xwayland
--disable-standalone-xpbproxy
--disable-kdrive
--disable-kdrive-evdev
--disable-kdrive-kbd
--disable-xephyr
--disable-xfake
--disable-xfbdev
--disable-local-transport
--disable-secure-rpc
--disable-dmx
--disable-libunwind
--disable-xvfb
--enable-pciaccess
--enable-xv
--enable-xorg
--enable-input-thread
--enable-xtrans-send-fds
--enable-ipv6
--enable-tcp-transport
--enable-unix-transport
--with-sha1=libcrypto
--with-fontrootdir=$TERMUX_PREFIX/share/fonts
--with-xkb-path=$TERMUX_PREFIX/share/X11/xkb
LIBS=-landroid-shmem"
TERMUX_PKG_DEPENDS="libandroid-shmem, libx11, libxfont2, libxkbfile, libxau, libpixman, openssl, xorg-xkbcomp, libxshmfence, libxdmcp, libpciaccess, xkeyboard-config"
# --disable-xorg

TERMUX_PKG_USES_UDEV="no"

if [ "$TERMUX_PKG_USES_UDEV" == "yes" ]; then
	TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-config-udev"
	TERMUX_PKG_DEPENDS="eudev, $TERMUX_PKG_DEPENDS"
fi

termux_step_pre_configure () {
	cp -f $TERMUX_PKG_BUILDER_DIR/stub_platform.c $TERMUX_PKG_SRCDIR/hw/xfree86/os-support/stub/
	
	CFLAGS=`echo $CFLAGS | sed 's/-fno-integrated-as//'`
	CFLAGS="$CFLAGS -DFNDELAY=O_NDELAY"
	if [ -n "$TERMUX_DEBUG" ]; then
		TERMUX_PKG_EXTRA_CONFIGURE_ARGS+=" --enable-debug"
	fi
	autoreconf
#    CPPFLAGS+=" -I$TERMUX_PKG_SRCDIR/include"
    }

termux_step_post_make_install () {
	rm -f "${TERMUX_PREFIX}/usr/share/X11/xkb/compiled"
}

if [ "$#" -eq 1 ] && [ "$1" == "xorg_server_flags" ]; then
        echo $TERMUX_PKG_EXTRA_CONFIGURE_ARGS
        return 
fi
