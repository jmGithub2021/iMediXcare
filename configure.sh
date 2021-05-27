#!/bin/bash
CURDIR=$(pwd)/
JDK=jdk11
TOMCAT=Tomcat9
JAVA_DIR=$(echo $CURDIR | sed -e 's/ /\\ /g')$JDK/
#echo $JAVA_DIR
#echo $CURDIR

# tomcat config
echo "Coniguring iMediX Web"
echo "---------------------"
sed -i -e "/JAVA_HOME/s/=.*/=$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/bin/catalina.sh"
sed -i -e "/JRE_HOME/s/=.*/=$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/bin/catalina.sh"

blip="127.0.0.1"
gblroot="$CURDIR/$TOMCAT"
gblhome="https://localhost/iMediXcare"
gbltemp="$CURDIR/$TOMCAT/webapps/iMediXcare/temp"
EmailURL=""
SMSURL=""
vidServerUrl="meet.jit.si"



sed -i -e "/blip/s/=.*/= $(echo $blip | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"
sed -i -e "/gblroot/s/=.*/= $(echo $gblroot | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"
sed -i -e "/gblhome/s/=.*/= $(echo $gblhome | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"
sed -i -e "/gbltemp/s/=.*/= $(echo $gbltemp | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"
sed -i -e "/EmailURL/s/=.*/= $(echo $EmailURL | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"
sed -i -e "/SMSURL/s/=.*/= $(echo $SMSURL | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"
sed -i -e "/vidServerUrl/s/=.*/= $(echo $vidServerUrl | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/\./\\./g')/" "$CURDIR/$TOMCAT/webapps/iMediXcare/config.info"

# BL config
echo "Coniguring iMediX Business Logic"
echo "--------------------------------"

gbldbhost="127.0.0.1"
gbldbport=3306
read -p "Database name [imedixdb4]: " gbldbname
gbldbname=${gbldbname:-imedixdb4}

read -p "Database username [imedix]: " gbldbuser
gbldbuser=${gbldbuser:-imedix}

read -p "Database password [imedix12]: " gbldbpasswd
gbldbpasswd=${gbldbpasswd:-imedix12}

sed -i -e "/gbldbusername/s/=.*/= $(echo $gbldbuser | sed -e 's/\//\\\//g ; s/\./\\./g')/" "$CURDIR/iMediX-BL/gblinfo.inf"
sed -i -e "/gbldbpasswd/s/=.*/= $(echo $gbldbpasswd | sed -e 's/\//\\\//g ; s/\./\\./g')/" "$CURDIR/iMediX-BL/gblinfo.inf"
sed -i -e "/gbldburl/s/=.*/= jdbc:mysql:\/\/$(echo $gbldbhost | sed -e 's/\//\\\//g ; s/\./\\./g'):$(echo $gbldbport | sed -e 's/\//\\\//g ; s/\./\\./g')\/$(echo $gbldbname | sed -e 's/\//\\\//g ; s/\./\\./g')/" "$CURDIR/iMediX-BL/gblinfo.inf"
sed -i -e "/tempdatadir/s/=.*/= $(echo $gblbase | sed -e 's/\//\\\//g ; s/\./\\./g')\/serverApp\/temp/" "$CURDIR/iMediX-BL/gblinfo.inf"
sed -i -e "/SystemLoggerPath/s/=.*/= $(echo $gblbase | sed -e 's/\//\\\//g ; s/\./\\./g')\/serverApp\/SystemLog/" "$CURDIR/iMediX-BL/gblinfo.inf"
sed -i -e "/GeneralSqlLogPath/s/=.*/= $(echo $gblbase | sed -e 's/\//\\\//g ; s/\./\\./g')\/serverApp\/GenSqlLog/" "$CURDIR/iMediX-BL/gblinfo.inf"
sed -i -e "s/^.*\/java/$(echo $JAVA_DIR | sed -e 's/\//\\\//g ; s/ /\\ /g')bin\/java/g" "$CURDIR/iMediX-BL/RunServer.sh"

# source config (Server module)
echo "Coniguring iMediX Source Code (Server Module)"
echo "---------------------------------------------"
sed -i -e "s/^.*\.java$/$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')bin\/javac -classpath \".:$(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')External_library\/*:\" -d \`pwd\`  *\.java/g" "$CURDIR/SOURCECODES/server_module_source_code/makeJar.sh"
sed -i -e "s/^.*\/jar/$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')bin\/jar/g" "$CURDIR/SOURCECODES/server_module_source_code/makeJar.sh"
sed -i -e "s/^.*\/rmic/$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')bin\/rmic/g" "$CURDIR/SOURCECODES/server_module_source_code/makeJar.sh"
sed -i -e "s/^.*\/lib\//cp *.jar $(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')iMediX-BL\/lib\//g" "$CURDIR/SOURCECODES/server_module_source_code/makeJar.sh"
sed -i -e "s/^.*\/iMediX-BL\/$/cp iMediXBusinessLogic.jar $(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')iMediX-BL\//g" "$CURDIR/SOURCECODES/server_module_source_code/makeJar.sh"

# source config (tomcat module)
echo "Coniguring iMediX Source Code (Tomcat Module)"
echo "---------------------------------------------"
sed -i -e "s/^.*\/imedix\b/cp -r $(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')SOURCECODES\/server_module_source_code\/imedix/g" "$CURDIR/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src/makeJar.sh"
sed -i -e "s/^.*\`pwd\`[[:space:]]\*\.java$/$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')bin\/javac -classpath \".:$(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')External_library\/*:\" -d \`pwd\` *\.java /g" "$CURDIR/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src/makeJar.sh"
sed -i -e "s/^.*\`pwd\`\/src_servlet[[:space:]]\*\.java$/$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')bin\/javac -classpath \".:$(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')External_library\/*:\" -d \`pwd\`\/src_servlet *\.java /g" "$CURDIR/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src/makeJar.sh"
sed -i -e "s/^.*\/jar/$(echo $JAVA_DIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')bin\/jar/g" "$CURDIR/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src/makeJar.sh"
sed -i -e "s/^.*\/lib/cp -r *.jar $(echo $CURDIR | sed -e 's/ /\\ /g ; s/\//\\\//g ; s/ /\\ /g')$TOMCAT\/webapps\/iMediXcare\/WEB-INF\/lib/g" "$CURDIR/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src/makeJar.sh"






