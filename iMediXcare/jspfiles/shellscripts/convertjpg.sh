#!/bin/bash
if [ $# <> 0 ]
then
source=$1
dest=$2
cjpeg -quality 80 $source > $dest
fi
exit 0 
