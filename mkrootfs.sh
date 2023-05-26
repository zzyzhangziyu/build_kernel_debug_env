#!/bin/bash
#
# mkrootfs.sh - creates a root file system
#

# command-line settable variables
BUSYBOX_DIR=_install/
TARGET_DIR=./loop
FSSIZE=4000
CLEANUP=1
MKFS='mkfs.ext2 -F'

# don't-touch variables
BASE_DIR=`pwd`


# clean up from any previous work
mount | grep -q loop
[ $? -eq 0 ] && umount $TARGET_DIR
[ -d $TARGET_DIR ] && rm -rf $TARGET_DIR/
[ -f rootfs ] && rm -f rootfs
[ -f rootfs.gz ] && rm -f rootfs.gz


# prepare root file system and mount as loopback
dd if=/dev/zero of=rootfs bs=1k count=$FSSIZE
$MKFS -i 2000 rootfs
mkdir $TARGET_DIR
mount -o loop,exec rootfs $TARGET_DIR # must be root

# install busybox and components
cp -r $BUSYBOX_DIR/* $TARGET_DIR


# make files in /dev
mkdir $TARGET_DIR/dev
./mkdevs.sh $TARGET_DIR/dev

# make files in /etc
cp -a etc $TARGET_DIR
#ln -s /proc/mounts $TARGET_DIR/etc/mtab

# other miscellaneous setup
mkdir $TARGET_DIR/initrd
mkdir $TARGET_DIR/proc

#cd $TARGET_DIR
#cpio -id -I ../rootfs.cpio 
#cd $BASE_DIR

chmod 777 rootfs
# Done. Maybe do cleanup.
if [ $CLEANUP -eq 1 ]
then
	umount $TARGET_DIR
	rmdir $TARGET_DIR
	#gzip -9 rootfs
fi
