#!/bin/bash
#
# Duplicity script for creating backups
#
# USAGE: backup.sh [full]
# full => create full backups
# list => list backuped files
#      => create incremental backups

#
# set vars
#
if [ "$1" = 'full' ]; then
  TYPE='full'
elif [ "$1" = 'list' ]; then
  TYPE='list-current-files'
else
  TYPE=''
fi
FILELIST='/etc/backup_filelist'

# backup-host
BHOST=''
BUSER=''
FTP_PASSWORD=''
export FTP_PASSWORD
BURL="ftp://$BUSER@$BHOST/"

# log
LOGFILE='/var/log/backup.log'

# gpg-encryption
PASSPHRASE=''
export PASSPHRASE

#
# backup
#
echo "-------------------" >> $LOGFILE
date >> $LOGFILE
# remove old backups (older than 2 months)
duplicity remove-older-than 2M --force $BURL >> $LOGFILE

# do backup
if [ "$TYPE" = 'list-current-files' ]; then
  duplicity $TYPE $BURL
else
  duplicity $TYPE --full-if-older-than 1W --include-globbing-filelist $FILELIST --exclude "**/*" / $BURL >> $LOGFILE
fi
echo "-------------------" >> $LOGFILE

unset FTP_PASSWORD
unset PASSPHRASE
