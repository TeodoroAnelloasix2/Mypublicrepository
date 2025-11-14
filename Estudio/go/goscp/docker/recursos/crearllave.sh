#!/bin/bash

keyname="llavedemo1"
keynamepub="llavedemo1.pub"
comment="key for demo by elitaliano"
workdirectory="keydir"
mkdir -p $workdirectory

if [[ -f "${workdirectory}/${keyname}" && -f "${workdirectory}/${keynamepub}" ]];then
    echo "Deleting ${workdirectory}/${keyname}"
    rm -rf "${workdirectory}/${keyname}"*
    if [ $? -eq 0 ];then
        echo "Key correctly deleted !"
    fi
fi

ssh-keygen -t rsa -b 4096 -f "${workdirectory}/${keyname}"  -N "" -q -C "$comment"
if [ $? -eq 0 ];then
    echo "Key correctly created !"
fi