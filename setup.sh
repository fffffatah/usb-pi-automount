#!/bin/env /bin/bash
#Author: A.F.M. NOORULLAH

#CREATE PATH CONFIG
echo "[Where do you want to your drives to be mounted?]"
echo "Enter Path: "
read MOUNT_PATH
if [[ "${MOUNT_PATH: -1}" != '/' ]]; then
	MOUNT_PATH=$MOUNT_PATH"/"
fi
if [[ -d "$MOUNT_PATH" ]]; then
	echo "Path is Valid!"
else
	echo "Path is Invalid!"
	echo "Terminating Setup!"
	exit 1
fi
cd src/config && echo $MOUNT_PATH >> path && cd .. && cd ..

#MOVE FILES TO /home/{user}/usb_pi_automount
mv src $HOME/usb_pi_automount

#ADD TO CRONTAB
CRONJOB="@reboot cd $HOME/usb_pi_automount && sudo ./script.sh"
(crontab -u $(whoami) -l; echo "$CRONJOB" ) | crontab -u $(whoami) -

#DONE
echo "DONE!"
echo "Changes will be applied on reboot"
