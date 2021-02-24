# for DDP Machine
cd ~/Opensource/SOURCECODES/server_module_source_code
./makeJar.sh
cd ~/Opensource/SOURCECODES/tomcat_module_source_code/WEB-INF/classes/src
./makeJar.sh
sudo killall -9 java
cd ~/Opensource/Tomcat9/bin
sudo ./shutdown.sh
sudo ./startup.sh
cd ~/Opensource/iMediX-BL
sudo ./RunServer.sh
