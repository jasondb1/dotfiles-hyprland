#! /bin/sh

mount() {
sudo mount -t cifs //192.168.1.12/data /mnt/nas/data -o credentials=/home/jason/.nascreds,vers=1.0
sudo mount -t cifs //192.168.1.12/usbshare1 /mnt/nas/usbshare1 -o credentials=/home/jason/.nascreds,vers=1.0
sudo mount -t cifs //192.168.1.12/backup /mnt/nas/backup -o credentials=/home/jason/.nascreds,vers=1.0
}

unmount() {
sudo umount /mnt/nas/data
sudo umount /mnt/nas/usbshare1
sudo umount /mnt/nas/backup
}

status() {
	MTD=$(findmnt -l |grep /mnt/nas/data)
	if [[ -n $MTD ]]
	then
		echo "􀨥"
	else 
		echo "􀨤"
	fi
}

status_json() {
	MTD=$(findmnt -l |grep /mnt/nas/data)
	if [[ -n $MTD ]]
	then
		echo '{"text": "􀨤", "class": "enabled", "tooltip": "NAS Mounted"}'
	else 
		echo '{"text": "􀨤", "class": "disabled", "tooltip": "NAS Unmounted"}'
	fi
}

case "$1" in
    --mount)
		echo "Mount NAS Drives:"
        mount
        ;;
     --unmount)
		echo "Dismount NAS Drives:"
        unmount
        ;;
     --listshares)
        #smbclient -L //192.168.1.12
        smbclient -L //ds218j.local
        ;;
    --status)
        status
        ;;
    --json)
        status_json
        ;;
      *)
		echo $"Mount NAS Drive\n"
		echo $"Usage: $0 {--status | --mount | --unmount}"
		exit 1
		;;
esac
