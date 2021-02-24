#!/bin/bash
if [ $# <> 0 ]
then
usr=$1
home=$3
pass=$5 
echo -n "import crypt; print crypt.crypt(\"$pass\",\"salt\")" > cr.txt
temp=`python cr.txt` 
echo -n $4:$usr: > $2/ps.txt
useradd -p $temp -d $home $usr
chmod 777 -R $3/$usr/

fi
exit 0 
