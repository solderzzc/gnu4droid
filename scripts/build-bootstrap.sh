#!/bin/bash
# build-bootstrap.sh - script to build bootstrap.zip

set -e -u -o pipefail

# Read settings from .termuxrc if existing
test -f $HOME/.termuxrc && . $HOME/.termuxrc
: ${TERMUX_TOPDIR:="$HOME/.termux-build"}
: ${TERMUX_ARCH:="aarch64"}
: ${TERMUX_DEBUG:=""}

if [[ ! "$TERMUX_ARCH" =~ ^(all|aarch64|arm|i686|x86_64)$ ]]; then
	echo "ERROR: Invalid arch '$TERMUX_ARCH'" 1>&2
	exit 1
fi

TOPDIR=`dirname $0`/../
BUILDSCRIPT=$TOPDIR/build-package.sh
SYMLINKS_TXT="$TERMUX_TOPDIR/SYMLINKS.txt"
BOOTSTRAP_ZIP=~/bootstrap-$TERMUX_ARCH.zip

export TERMUX_TOPDIR TERMUX_ARCH TERMUX_DEBUG

rm -rf $TERMUX_TOPDIR /data/data/org.sharpai/files/usr
$BUILDSCRIPT apt

cd /data/data/org.sharpai/files/usr
symlinks=`find ./ -type l`

echo "symlinks $symlinks"

echo "Symlinks file is $SYMLINKS_TXT"
rm -f $SYMLINKS_TXT
#printf "#!/system/bin/sh\nmklink(){\n   rm -f \$2\n   ln -s \$1 \$2\n}\n\n" > $SYMLINKS_TXT
#echo $symlinks
for item in $symlinks; do
target=`readlink $item`
[ "$target" == "/bin/sh" ] && target="bin/applets/sh"
echo "$target←$item" >> $SYMLINKS_TXT
rm $item
unset target
done

cd -
#chmod +x $SYMLINKS_TXT

controls=`find ~/.termux-build -name "control" | grep massage/DEBIAN/control | grep -v subpackages`

rm -f /data/data/org.sharpai/files/usr/var/lib/dpkg/status
touch /data/data/org.sharpai/files/usr/var/lib/dpkg/status

write_control_to_status() {
	grep "Architecture:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	if [ "$(grep "Depends:" $1)" != "" ]; then grep "Depends:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status; fi
	grep "Description:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	grep "Homepage:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	grep "Installed-Size:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	grep "Maintainer:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	grep "Package:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	grep "Version:" $1 >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	echo "Status: install ok installed" >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
	echo >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
}

for item in $controls; do
	write_control_to_status $item >> /data/data/org.sharpai/files/usr/var/lib/dpkg/status
done

echo "TERMUX_TOPDIR: $TERMUX_TOPDIR"

#target_dirs=`find $TERMUX_TOPDIR -name gnu | grep "/massage/gnu" | grep -v subpackages`
target_dirs=`find $TERMUX_TOPDIR |  grep "/massage/data/data/org.sharpai/files" | grep -v subpackages`
#echo "target dirs: $target_dirs"
#for item in $target_dirs; do
#	package=$(basename $(dirname $(dirname $item)))
#	files=`find $item`
#	list_file="/data/data/org.sharpai/files/usr/var/lib/dpkg/info/$package.list"
#	md5sums_file="/data/data/org.sharpai/files/usr/var/lib/dpkg/info/$package.md5sums"

#	rm -f $list_file $md5sums_file
#	touch $md5sums_file
#	for file in $files; do
#		file=${file/"$TERMUX_TOPDIR/$package/massage/gnu"/"/gnu"}
#		echo $file >> $list_file
#		[ -d "${file}" ] || md5sum $file >> $md5sums_file
#	done
#done

cp $SYMLINKS_TXT /data/data/org.sharpai/files/usr/

mkdir -p `dirname $BOOTSTRAP_ZIP`
rm -f $BOOTSTRAP_ZIP
cd /data/data/org.sharpai/files/usr/
zip -yr $BOOTSTRAP_ZIP *
cd -
echo "Finished"
