#! /bin/sh
#
# enter this into /etc/ancron as
#@monthly    20  backup.monthly    /bin/bash   /home/jason/bin/backup_monthly.sh
tar -cvjf /mnt/nasdrive/backup/jason_monthly/monthly_$(date +%Y%m%d).tar.bz2 /mnt/nasdrive/backup/jason_daily/ > /dev/null

#/etc/fstab - make sure drives are setup
#added by jason -network drive
#//192.168.1.12/data /mnt/nasdrive/data cifs username=jason,password=passwd
#//192.168.1.12/backup /mnt/nasdrive/backup cifs username=jason,password=passwd
