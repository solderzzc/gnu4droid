TERMUX_PKG_HOMEPAGE=http://man7.org/linux/man-pages/man5/resolv.conf.5.html
TERMUX_PKG_DESCRIPTION="Resolver configuration file"
TERMUX_PKG_VERSION=1.1

termux_step_make_install () {
	_RESOLV_CONF=$TERMUX_PREFIX/etc/resolv.conf
	printf "nameserver 8.8.8.8\nnameserver 8.8.4.4" > $_RESOLV_CONF
}
