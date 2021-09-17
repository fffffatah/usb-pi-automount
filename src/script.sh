#!/bin/env /bin/bash
#Author: A.F.M. NOORULLAH

while true; do
	MYDEV='/dev/'
	SCRIPT_HOME=$HOME/usb_pi_automount
	MOUNT_PATH=$(cd $SCRIPT_HOME/config && cat <path)
	CONNECTED_DEVICES=$(lsblk | grep '^sd' | cut -d' ' -f1)
	MOUNTED_DEVICES=$(cd $SCRIPT_HOME/devices && ls | sed 's/,.*//' | grep '^sd')
	LAST_MOUNTED_DEVICE_NUM=$(cd $SCRIPT_HOME/devices && ls | sed 's:.*,::' | grep '^storage' | grep -o '[[:digit:]]*' | sort -n | tail -1)
	NEXT_AVAILABLE_DEVICE_NUM='0'

	#GET NEXT STORAGE NUMBER
	#if [[ $LAST_MOUNTED_DEVICE_NUM != '' ]]; then
        #	NEXT_AVAILABLE_DEVICE_NUM=$((LAST_MOUNTED_DEVICE_NUM+1))
	#fi

	#MOUNT AND FORMAT DEVICES
	if [[ $CONNECTED_DEVICES ]]; then
  		while read -r usb
  		do
    			echo "USB: $usb"
    			if grep -qs $MYDEV$usb /proc/mounts; then
     				echo "It's mounted."
    			else
     				echo "It's not mounted."
				#GET NEXT STORAGE NUMBER
				if [[ $LAST_MOUNTED_DEVICE_NUM != '' ]]; then
        				NEXT_AVAILABLE_DEVICE_NUM=$((LAST_MOUNTED_DEVICE_NUM+1))
					LAST_MOUNTED_DEVICE_NUM=$NEXT_AVAILABLE_DEVICE_NUM
				fi
     				NEW_MOUNT_DEVICE='storage'$NEXT_AVAILABLE_DEVICE_NUM
     				cd $MOUNT_PATH && sudo mkdir $NEW_MOUNT_DEVICE
     				if [ "$(sudo blkid $MYDEV$usb -s TYPE -o value)" != 'vfat' ]; then
      					sudo mkfs.vfat -I  $MYDEV$usb
     				fi
     				sudo mount $MYDEV$usb $MOUNT_PATH$NEW_MOUNT_DEVICE
     				cd $SCRIPT_HOME/devices && sudo touch $usb','$NEW_MOUNT_DEVICE
    			fi
  		done < <(lsblk | grep '^sd' | cut -d' ' -f1)
	fi
	sleep 5
done
