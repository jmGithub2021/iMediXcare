#!/bin/bash
if [ $# <> 0 ]
then
rm -Rf $2/$1
fi
exit 0 