#!/bin/bash
DEPENDS=$NDK/ndk-depends

libs=`find $1 -name "*.so"`

process(){
	lib=$1
	read -r line
	if [ "$line" != "" ]; then
		echo Found: $line
	fi
}

for lib in $libs; do
$DEPENDS $lib 2>/dev/null | process $lib
done
