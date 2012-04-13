#!/bin/bash
echo "Welcome to Simons HTC Utility for Linux."
echo "We are going to start unlocking your phone!"
#starting
adb push 'bool /data/local/btool'
adb push 'flash_image /data/local/flash_image'
adb push 'dump_image /data/local/dump_image'
adb push 'tacoroot.sh /data/local/tacoroot.sh'
adb shell 'chmod 755 /data/local/tacoroot.sh'
echo "Ignore tacoroot commands, I'm doing everything"
adb shell '/data/local/tacoroot.sh --recovery'
sleep 14
adb reboot
adb wait-for-device
echo "Not frozen waiting for device"
sleep 60
adb shell '/data/local/tacoroot.sh --setup'
sleep 90
adb shell '/data/local/tacoroot.sh --root'
adb wait-for-device
sleep 37
adb shell 'mount -o remount,rw -t yaffs2 /dev/block/mtdblock3 /system'
adb shell 'cat /data/local/btool > /system/bin/btool'
adb shell 'cat /data/local/dump_image > /system/bin/dump_image'
adb shell 'cat /data/local/flash_image > /system/bin/flash_image'
adb shell 'chmod 755 /system/bin/flash_image'
adb shell 'chmod 755 /system/bin/dump_image'
adb shell 'chmod 755 /system/bin/btool'
adb shell 'rm /data/local/misc.img'
adb shell 'dump_image misc /data/local/misc.img'
adb shell 'btool /data/local/misc.img unlock'
adb shell 'flash_image misc /data/local/misc.img'
adb shell 'rm /data/local/misc.img'
adb shell '/data/local/tacoroot.sh --undo'
adb shell 'rm /data/local/tacoroot.sh'
adb shell 'rm /data/local/dump_image'
adb shell 'rm /data/local/flash_image'
adb reboot bootloader
echo "Enjoy!"
echo -n "Want a custom recovery while were at it (y/n) ->  "
read choice
  if "$choice" == y
then
  echo "Okay, thanks for using the Utility."
  echo "Good-Bye"
sleep 3
  exit 1
fi
  if "$choice" == n
then
  echo "Lets install that recovery then!"
  echo "Please follow any instructions given!"
adb wait-for-device
adb push "recovery.zip /sdcard/PG76IMG.zip"
echo "We will now reboot into hboot. Please follow all directions."
adb "reboot oem-42"
echo "Push Vol-Up and then press power button."
adb wait-for-device
sleep 60
adb "shell rm /sdcard/PG76IMG.zip"
adb reboot recovery
echo "Your now in recovery! Enjoy."
echo "If you like this please donate. Check xda, user simonsimons34."
sleep 6
echo "Good-Bye"
sleep 3
exit 1
fi