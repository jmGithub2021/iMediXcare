#!/bin/bash
CURDIR=$(pwd)
echo "Building iMediX-Care Server Module"
echo "-----------------------------"
cd "$CURDIR/SOURCECODES/server_module_source_code"
./makeJar.sh
echo "Building iMediX-Care Tomcat Module"
echo "-----------------------------"
cd "$CURDIR/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src"
./makeJar.sh