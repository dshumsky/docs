### Prepare usb-stick
```
sudo lsblk
df -h
sudo umount /dev/sdb
sudo dd bs=4M if=ubuntu.iso of=/dev/sdb --progress
```

### Install Ubuntu to USB stick
https://ubuntuhandbook.org/index.php/2014/11/install-real-ubuntu-os-usb-drive/
```
2 sticks (Live + Real)
Select install boot-loader to the USB flash drive (/dev/sdc)
```
