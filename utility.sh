#!/bin/bash
echo "welcome to the unlock utility for linux."
echo "Please wait while I try to install adb"
chmod 755 51-android.rules
chmod 755 adb
chmod 755 fastboot
sudo ln -s /etc/udev/rules.d/51-android.rules
sudo ln -s fastboot /bin/fastboot
sudo ln -s adb /bin/adb
#starting
	adb shell ls /data/local/
	adb push bool /data/local/btool
	adb push flash_image /data/local/flash_image
	adb push dump_image /data/local/dump_image
	adb push tacoroot.sh /data/local/tacoroot.sh
	adb shell chmod 755 /data/local/tacoroot.sh
	echo. Ignore tacoroot commands
	adb shell /data/local/tacoroot.sh --recovery
	sleep 14
	adb reboot
	adb wait-for-device
	echo. Not frozen waiting for device
	sleep 60
	adb shell /data/local/tacoroot.sh --setup
	sleep 90
	adb shell /data/local/tacoroot.sh --root
	adb wait-for-device
	sleep 37
	adb shell mount -o remount,rw -t yaffs2 /dev/block/mtdblock5 /system
	adb shell cat /data/local/btool > /system/bin/btool
	adb shell cat /data/local/dump_image > /system/bin/dump_image
	adb shell cat /data/local/flash_image > /system/bin/flash_image
	adb shell chmod 755 /system/bin/flash_image
	adb shell chmod 755 /system/bin/dump_image
	adb shell chmod 755 /system/bin/btool
	adb shell rm /data/local/misc.img
	adb shell dump_image misc /data/local/misc.img
	adb shell btool /data/local/misc.img unlock
	adb shell flash_image misc /data/local/misc.img
	adb shell rm /data/local/misc.img
	adb shell /data/local/tacoroot.sh --undo
	adb shell rm /data/local/tacoroot.sh
	adb shell rm /data/local/dump_image
	adb shell rm /data/local/flash_image
	adb reboot bootloader
echo "enjoy"
