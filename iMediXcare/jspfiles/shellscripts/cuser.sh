#!/bin/bash
if [ $# <> 0 ]
then
mkdir -p $2/$1
chmod 777 -R $2
fi
exit 0 
