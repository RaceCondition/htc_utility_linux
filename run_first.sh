#!/bin/bash
echo "welcome to the unlock utility for linux."
echo "Please wait while I try to install adb"
#lets install adb here. Dont know if this will work.. Chmod first
chmod 755 51-android.rules
chmod 755 adb
chmod 755 fastboot
#now symbolic link so that cp doesnt fail out
sudo ln -s /etc/udev/rules.d/51-android.rules
sudo ln -s fastboot /bin/fastboot
sudo ln -s adb /bin/adb
echo "ADB should be installed, moving you to the next script"
clear
chmod 755 ./next
./next.sh
