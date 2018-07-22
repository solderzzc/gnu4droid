#!/bin/bash

set -e

#backup
cd src
tar cvf ../backups/xf86-video-alien-`date +%Y-%m-%d_%H.%M`.tar.gz *
cd ..

rm -rf /home/twaik/xf86-video-alien/moduledir

cd build
make clean
make -j4

mkdir -p /home/twaik/xf86-video-alien/moduledir/drivers
cp /usr/lib/xorg/modules/libfb.so /home/twaik/xf86-video-alien/moduledir/
cp /usr/lib/xorg/modules/input/mouse_drv.so /home/twaik/xf86-video-alien/moduledir/
cp /home/twaik/xf86-video-alien/build/src/.libs/alien_drv.so /home/twaik/xf86-video-alien/moduledir/drivers/

Xorg :1 -configdir /home/twaik/xf86-video-alien/ -config /home/twaik/xf86-video-alien/xorg.conf -sharevts vt0 -novtswitch -modulepath /home/twaik/xf86-video-alien/moduledir
