#! /bin/sh
#
# enter this into /etc/ancron as
#@weekly     20  backup.weekly    /bin/bash   /home/jason/bin/backup_monthly.sh
rsync -avr --delete /mnt/nasdrive/backup/jason_daily /mnt/nasdrive/backup/jason_weekly > /dev/null

#/etc/fstab - make sure drives are setup
#added by jason -network drive
#//192.168.1.12/data /mnt/nasdrive/data cifs username=jason,password=passwd
#//192.168.1.12/backup /mnt/nasdrive/backup cifs username=jason,password=passwd
