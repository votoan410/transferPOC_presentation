#!/bin/bash
backup_dirs=("etc" "boot") # the directories will be zipped for backup
dest_server="/home/kali/Desktop/server_poc" #where the backup will be sent to
backup_date=$(date +%b-%d-%y) #determine the date the backup created`
echo "Starting backup of: ${backup_dirs[@]}"
for i in "${backup_dirs[@]}"
do
   sudo tar -Pczf /tmp/$i-$backup_date.tar.gz /$i
     if [ $? -eq 0 ]
     then #"$?" exit status of the last command, 0 means successful 
       echo "$i backup succeeded."
     else
       echo "$i backup failed."
     fi
     
     if [ -f /tmp/$i-$backup_date.tar.gz ] #I have trust issue so... more checking
     then 
        echo "/tmp/$i-$backup_date.tar.gz exists, start transfering..." 
        sudo mv /tmp/$i-$backup_date.tar.gz $dest_server
     else
        echo "/tmp/$i-$backup_date.tar.gz does not exist" 
     fi
 
     if [ $? -eq 0 ]
     then
       echo "$i transfer succeeded."
     else
       echo "$i transfer failed."
     fi
done
sudo rm /tmp/*.gz # cleanup (remove) backups created earlier in /tmp
echo "Backup is done."

