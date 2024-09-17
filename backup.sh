#!/bin/sh
#Purpose = Backup of Important Data
#Created on Jan2018
#Author = WisnuAriSetiadi
#Version 1.1

#Check Directory
#DO NOT GIVE / IN END
DESDIRETC=/usr/local/home/backup/etc
DESDIRDATA=/home/site
DESDIRDATA2=/data
EXCLUDE=--exclude-from='exclude.txt'
HOST_RSYNC=192.168.22.255

if [ ! -d "$DESDIRETC" ]; then
  mkdir -p $DESDIRETC
fi
#END Check Directory

# #BACKUP /ETC
TIME=`date +%b-%d-%y`
FILENAME=etc-$TIME.tar.gz
SRCDIRETC=/etc
tar -cpPzf "$DESDIRETC/$FILENAME" "$SRCDIRETC"
#END /ETC

#RSYNC TO BACKUP-SERVER
# find /usr/local/home/ -mtime +14 -exec rm -f {} \;
rsync -aP --rsync-path="mkdir -p /usr/home/`hostname`/ && rsync" -aP --dry-run "$EXCLUDE" "$DESDIRDATA" -e ssh "$HOST_RSYNC":/usr/home/`hostname`/ &&
rsync -aP --rsync-path="mkdir -p /usr/home/`hostname`/ && rsync" -aP --dry-run "$EXCLUDE" "$DESDIRDATA2" -e ssh "$HOST_RSYNC":/usr/home/`hostname`/ &&
rsync -aP --rsync-path="mkdir -p /usr/home/`hostname`/ && rsync" -aP --dry-run "$EXCLUDE" "$DESDIRETC" -e ssh "$HOST_RSYNC":/usr/home/`hostname`/
#END RSYNC TO BACKUP-SERVER
