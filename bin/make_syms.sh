#!/bin/bash -ex

[ -n "`ls -A tmp`" ] && rm tmp/*
size=`du -hs ~/plex-home-theater/build/plex/plexhometheater  | awk '{print $1}' | sed 's/M//g'`

#[ $size -le 100 ] && echo "PHT binary too small, must be stripped. Can't get symbols from stripped binary" && exit

cwd=`pwd`
cd ~/plex-home-theater/build
ninja plex/CMakeFiles/PlexHomeTheater_symbols
cd $cwd

cp ~/plex-home-theater/build/PlexHomeTheater-*symbols.bz2 tmp

for syms in tmp/*; do
	if [ -n "`echo $syms | grep bz2`" ];then
		bunzip2 $syms
	fi
	rawsyms=`echo $syms | sed "s/.bz2//g"`
	magic=`head -1 $rawsyms | awk '{print $4}'`
	symdir=symbols/plexhometheater/$magic

	mkdir -p $symdir
	cp $rawsyms $symdir/plexhometheater.sym
done

~/OpenELEC.tv/build.rasplex-RPi.arm-devel-release/toolchain/bin/armv6zk-openelec-linux-gnueabi-strip ~/plex-home-theater/build/plex/plexhometheater
