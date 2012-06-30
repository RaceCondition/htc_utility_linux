#!/bin/bash
echo "Welcome to Simons HTC Utility for Linux."
echo "We are going to start unlocking your phone!"
echo "Waiting for a device. If stuck here, your phone must be switched on, connected via USB and in USB debug mode."
# Make sure we have a device attached before starting.
adb wait-for-devices
#starting
adb push bool /data/local/btool
adb push flash_image /data/local/flash_image
adb push dump_image /data/local/dump_image
adb push tacoroot.sh /data/local/tacoroot.sh
adb shell 'chmod 755 /data/local/tacoroot.sh'
echo "Ignore tacoroot commands, just reboot your phone when prompted."
adb shell '/data/local/tacoroot.sh --recovery'
sleep 14
echo "*** Waiting for phone to reboot (you may need to do it manually at this point)..."
adb wait-for-device
sleep 15
adb shell '/data/local/tacoroot.sh --setup'
sleep 30
echo "*** Waiting for phone to reboot (you may need to do it manually at this point)..."
adb wait-for-device
adb shell '/data/local/tacoroot.sh --root'
echo "*** Waiting for device to restart..."
adb wait-for-device
sleep 5
adb shell 'chmod 755 /data/local/flash_image'
adb shell 'chmod 755 /data/local/dump_image'
adb shell 'chmod 755 /data/local/btool'
adb shell '/data/local/dump_image misc /data/local/misc.img'
adb shell '/data/local/btool /data/local/misc.img unlock'
adb shell '/data/local/flash_image misc /data/local/misc.img'
adb shell 'rm /data/local/misc.img'
adb shell '/data/local/tacoroot.sh --undo'
# Undo root causes a reboot so wait until the device is back
sleep 5
adb wait-for-device
adb shell 'rm /data/local/tacoroot.sh'
adb shell 'rm /data/local/dump_image'
adb shell 'rm /data/local/flash_image'

echo "*** Rebooting phone..."
adb reboot bootloader
echo "*** Check your phone should now say *** UNLOCKED ***"
echo "*** Enjoy!"
echo -n "Want a custom recovery while were at it (y/n) ->  "
read choice
if [ "$choice" == "n" ]
then
  echo "*** Okay, thanks for using the Utility."
  echo "*** Good-Bye"
  sleep 3
  exit 0 # Success
fi
if [ "$choice" == "y" ]
then
  echo "*** Lets install that recovery then!"
  echo "*** Please follow any instructions given!"
  adb wait-for-device
  adb push recovery.zip /sdcard/PG76IMG.zip
  echo "*** We will now reboot into hboot. Please follow all directions."
  adb reboot oem-42
  echo "*** Push Vol-Up and then press power button."
  adb wait-for-device
  sleep 60
  adb shell 'rm /sdcard/PG76IMG.zip'
  adb reboot recovery
  echo "*** Your now in recovery! Enjoy."
  echo "*** If you like this please donate. Check xda, user simonsimons34."
  sleep 6
  echo "*** Good-Bye"
  sleep 3
  exit 0 # Success
fi
