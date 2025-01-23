#! /bin/sh
#
# enter this into /etc/ancron as
#@daily     10  backup.daily    /bin/bash   /home/jason/bin/backup_daily.sh
#rsync -avr --exclude-from=/home/jason/bin/exclude.list /home/jason /mnt/nasdrive/backup/jason_daily > /dev/null
rsync -avr --progress --exclude='.cache/' --exclude='VirtualBox VMs/' --exclude='dos/' --exclude='.wine/' --exclude='.thumbnails/' --exclude='*cache*' --exclude='NFS Carbon/' /home/jason /mnt/nasdrive/backup/jason_daily > /dev/null

#/etc/fstab - make sure drives are setup
#added by jason -network drive
#//192.168.1.12/data /mnt/nasdrive/data cifs username=jason,password=passwd
#//192.168.1.12/backup /mnt/nasdrive/backup cifs username=jason,password=passwd
