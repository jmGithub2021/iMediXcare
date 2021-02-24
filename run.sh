#!/bin/bash
CURDIR=$(pwd)
echo "Stopping all junk java processes"
echo "--------------------------------"
sudo killall -9 java
cd "$CURDIR/Tomcat9/bin"
echo "Stopping Tomcat Server"
echo "----------------------"
sudo ./shutdown.sh
echo "Starting Tomcat Server"
echo "---------------------"
sudo ./startup.sh
echo "Starting iMediX-Care Business Logic"
echo "------------------------------"
cd "$CURDIR/iMediX-BL"
sudo ./RunServer.sh
