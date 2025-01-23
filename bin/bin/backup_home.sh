#!/bin/sh

#backup /home/jason to synology Ds218j
#ensure ~.ssh/id_rsa.pub is copied to server jason@192.168.1.12:~/.ssh/authorized_keys

# enter this into /etc/ancrontab as
#@daily     10  backup.daily    /bin/bash   /home/jason/bin/backup_home.sh

#on synology server setup weekly and monthly tasks

#weekly (on synology nas)
#rsync -ahH --delete /volume1/homes/jason/backup/jason-ThinkPad-T460/daily/  /volume1/homes/jason/backup/jason-ThinkPad-T460/weekly/ >/dev/null

#monthly (on synology nas)
#tar -cvjf /volume1/homes/jason/backup/jason-ThinkPad-T460/monthly/monthly_$(date +%Y%m%d).tar.bz2  /volume1/homes/jason/backup/jason-ThinkPad-T460/daily/


rsync -rtDHh --links -p --info=progress2 --rsh="ssh -p 22 -c aes192-ctr -o IdentityFile=/home/jason/.ssh/id_rsa"  --max-size=500M --delete --delete-excluded  -i --out-format="BACKUP: %i %n%L" --chmod=Du+wx  --include="/home/jason/" --include="/home/" --exclude=".gvfs" --exclude=".cache/*" --exclude=".thumbnails*" --exclude="[Tt]rash*" --exclude="*.backup*" --exclude="*~" --exclude=".dropbox*" --exclude="/proc/*" --exclude="/sys/*" --exclude="/dev/*" --exclude="/run/*" --exclude="/etc/mtab" --exclude="/var/cache/apt/archives/*.deb" --exclude="lost+found/*" --exclude="/tmp/*" --exclude="/var/tmp/*" --exclude="/var/backups/*" --exclude=".steam" --exclude=".Private" --exclude="/home/jason/.dbus" --exclude="/home/jason/VirtualBox VMs" --exclude=".aptitude" --include="/home/jason/**" --exclude="*" / 'jason@192.168.1.12:"backup/jason-ThinkPad-T460/daily/"'
