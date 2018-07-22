#!/system/bin/sh
set -e -x

fatal_error(){
	echo $@
	exit 1
}

gnuenv(){
	PATH=/gnu/usr/bin:/gnu/usr/bin/applets:/system/bin LD_LIBRARY_PATH=/gnu/usr/lib:/vendor/lib:/system/lib $@
}

packages="bash xorg-server xf86-video-alien xf86-input-mtev xf86-input-evdev"

[ `id -u` -ne 0 ] && fatal_error "Run it as root." || echo "Running as root..."
which busybox >/dev/null || fatal_error "No busybox detected. Install busybox."

busybox mount -o remount,rw /
busybox mount -o remount,rw /system

busybox wget http://192.168.0.128/bootstraps/bootstrap-arm.zip -O /bootstrap.zip

#for the case /gnu/ is not empty
rm -rf /gnu/*
busybox unzip /bootstrap.zip

printf '# The main repo for apt\ndeb [trusted=yes] http://192.168.0.128/ termux extras' > /gnu/usr/etc/apt/sources.list
/system/bin/sh /gnu/usr/bin/second_stage.sh
gnuenv apt update
gnuenv apt upgrade -y
gnuenv apt install -y $packages

printf '#!/system/bin/sh\nPATH=/gnu/usr/bin:/gnu/usr/bin/applets:/system/bin LD_LIBRARY_PATH=/vendor/lib:/system/lib:/gnu/usr/lib /gnu/usr/bin/bash $@' > /system/xbin/gnu4droid-bash
echo "Use gnu4droid-bash to enter gnu4droid environment."

gnuenv /gnu/usr/bin/bash
