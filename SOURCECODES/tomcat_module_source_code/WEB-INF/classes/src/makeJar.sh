cp -r /home/surajit/WEBDev/SOURCECODES/server_module_source_code/imedix `pwd`

/home/surajit/WEBDev/jdk11/bin/javac -classpath ".:/home/surajit/WEBDev/External_library/*:" -d `pwd` *.java 

/home/surajit/WEBDev/jdk11/bin/javac -classpath ".:/home/surajit/WEBDev/External_library/*:" -d `pwd`/src_servlet *.java 
cp -r `pwd`/src_servlet/imedixservlets/* `pwd`/imedixservlets

/home/surajit/WEBDev/jdk11/bin/jar -cf  imedix.jar imedix/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf  telem.jar telem/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf  tuberculosis.jar tuberculosis/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf  phiv.jar phiv/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf  onlinegc.jar onlinegc/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf  logger.jar logger/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf  imedixservlets.jar imedixservlets/*.class
cp -r *.jar /home/surajit/WEBDev/iMediX-docker/Tomcat9/webapps/iMediXcare/WEB-INF/lib

echo done
