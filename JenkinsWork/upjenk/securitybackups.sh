#!/bin/bash

backupjenkinshome(){
    src_dir=$jenkins_home
    suffix_bkp="jenkinshomebackup"
    timestamp=$(date +%F-%H%M)
    bkpfile="${suffix_bkp}_${timestamp}.tar.gz"
    backuprepo="./securitybackup"

    echo -e "\e[1;36m Starting backup process.....  \n Cheking if previous backup is present\e[0m"

    #Check if we have a previous backup 
    ls "$backuprepo/${suffix_bkp}"*.tar.gz 1>/dev/null 2>&1
    res=$?

    if [ $res -eq 0 ];then
        old_backup=$( ls  "$backuprepo/$suffix_bkp"*.tar.gz | tail -n 1 )
        echo -e "\e[1;32m deleting old backup: $old_backup  .........\e[0m"

        sleep 0.5

        rm -rf $old_backup
    else
        echo -e "\e[1;32m No previous backup is present \e[0m "
    fi

    echo -e "\e[1;32m Attempting to create a backup, this may take a while.......\e[0m "

    exec_tar "$backuprepo/$bkpfile" "$src_dir"
    
    res=$?
    if [[ $res -eq 0 ]];then
        echo -e "\e[1;32m Backup of jenkins' home successfully created: $bkpfile \e[0m"
        echo -e "Backup of jenkins' home successfully created: $bkpfile $timestamp"  >>"./logs/backup_jenkinshome.log"
    else
        echo -e "\e[1;31m Failed to create a backup of jenkins' home, please check it!\e[0m"
        echo -e " Failed to create a backup of jenkins' home, please check it! $timestamp"  >>"./logs/backup_jenkinshome.log"
    fi

}

#We can use this for others backups process! :)
exec_tar(){
    tar czf "$1" "$2"  1>/dev/null 2>&1
}