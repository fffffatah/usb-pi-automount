# Getting Started

USB Pi Automount will automatically mount USB Drives on connect to a custom folder (as storage0, storage1 ... storageN). It can also unmount the mounted drive if the USB Drive is disconnected. The script works on any linux distribution (Tested on Ubuntu Server 21.04 for Raspberry Pi).
## Setting Up
The script will automatically format any USB Drive as 'vfat' which aren't 'vfat' already. To get started, avail the scripts by cloning the repo or downloading from release.

>First, go to the source directory.
```sh
cd <Source Directory>
```

>Then, run the 'setup.sh' and follow through.
```sh
./setup.sh
```

That's it, you are GTG!