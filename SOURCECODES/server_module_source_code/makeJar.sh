/home/surajit/WEBDev/jdk11/bin/javac -classpath ".:/home/surajit/WEBDev/External_library/*:" -d `pwd`  *.java
/home/surajit/WEBDev/jdk11/bin/jar -cf imedix.jar imedix/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf tuberculosis.jar tuberculosis/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf phiv.jar phiv/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf logger.jar logger/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf onlinegc.jar onlinegc/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cf ftp.jar ftp/*.class
/home/surajit/WEBDev/jdk11/bin/jar -cmf imedixserver.txt iMediXBusinessLogic.jar imedixserver/*.class

/home/surajit/WEBDev/jdk11/bin/rmic imedix.dbGenOperations
/home/surajit/WEBDev/jdk11/bin/rmic imedix.CentreInfo
/home/surajit/WEBDev/jdk11/bin/rmic imedix.UserInfo
/home/surajit/WEBDev/jdk11/bin/rmic imedix.PatqueueInfo
/home/surajit/WEBDev/jdk11/bin/rmic imedix.ItemlistInfo
/home/surajit/WEBDev/jdk11/bin/rmic imedix.DataEntryFrm
/home/surajit/WEBDev/jdk11/bin/rmic imedix.DisplayData
/home/surajit/WEBDev/jdk11/bin/rmic imedix.AdminJobs
/home/surajit/WEBDev/jdk11/bin/rmic imedix.SmsApi
/home/surajit/WEBDev/jdk11/bin/rmic imedix.VideoConference
/home/surajit/WEBDev/jdk11/bin/rmic phiv.phivdataentry
/home/surajit/WEBDev/jdk11/bin/rmic imedix.graphsinfo
/home/surajit/WEBDev/jdk11/bin/rmic tuberculosis.tbOperations
/home/surajit/WEBDev/jdk11/bin/rmic logger.imedixlogger

cp *.jar /home/surajit/WEBDev/iMediX-docker/iMediX-BL/lib/
cp iMediXBusinessLogic.jar /home/surajit/WEBDev/iMediX-docker/iMediX-BL
