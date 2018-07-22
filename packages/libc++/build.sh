TERMUX_PKG_HOMEPAGE=https://libcxx.llvm.org/
TERMUX_PKG_DESCRIPTION="C++ Standard Library"
TERMUX_PKG_VERSION=$TERMUX_NDK_VERSION
# Since every C++ package links against this by default (due
# to the libstdc++.so -> libc++_shared.so setup in
# build-package.sh) this package is considered essential,
# and other packages does not need to declare explicit
# dependency on it.
TERMUX_PKG_ESSENTIAL=yes
TERMUX_PKG_KEEP_STATIC_LIBRARIES="yes"

termux_step_post_massage () {
	mkdir lib
	cp $TERMUX_PREFIX/lib/libc++_shared.so lib/
}
