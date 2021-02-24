/home/surajit/Opensource/jdk11/bin/javac -classpath ".:/home/surajit/Opensource/External_library/*:" -d `pwd`  *.java
/home/surajit/Opensource/jdk11/bin/jar -cf imedix.jar imedix/*.class
/home/surajit/Opensource/jdk11/bin/jar -cf tuberculosis.jar tuberculosis/*.class
/home/surajit/Opensource/jdk11/bin/jar -cf phiv.jar phiv/*.class
/home/surajit/Opensource/jdk11/bin/jar -cf logger.jar logger/*.class
/home/surajit/Opensource/jdk11/bin/jar -cf onlinegc.jar onlinegc/*.class
/home/surajit/Opensource/jdk11/bin/jar -cf ftp.jar ftp/*.class
/home/surajit/Opensource/jdk11/bin/jar -cmf imedixserver.txt iMediXBusinessLogic.jar imedixserver/*.class

/home/surajit/Opensource/jdk11/bin/rmic imedix.dbGenOperations
/home/surajit/Opensource/jdk11/bin/rmic imedix.CentreInfo
/home/surajit/Opensource/jdk11/bin/rmic imedix.UserInfo
/home/surajit/Opensource/jdk11/bin/rmic imedix.PatqueueInfo
/home/surajit/Opensource/jdk11/bin/rmic imedix.ItemlistInfo
/home/surajit/Opensource/jdk11/bin/rmic imedix.DataEntryFrm
/home/surajit/Opensource/jdk11/bin/rmic imedix.DisplayData
/home/surajit/Opensource/jdk11/bin/rmic imedix.AdminJobs
/home/surajit/Opensource/jdk11/bin/rmic imedix.SmsApi
/home/surajit/Opensource/jdk11/bin/rmic imedix.VideoConference
/home/surajit/Opensource/jdk11/bin/rmic phiv.phivdataentry
/home/surajit/Opensource/jdk11/bin/rmic imedix.graphsinfo
/home/surajit/Opensource/jdk11/bin/rmic tuberculosis.tbOperations
/home/surajit/Opensource/jdk11/bin/rmic logger.imedixlogger

cp *.jar /home/surajit/Opensource/iMediX-BL/lib/
cp iMediXBusinessLogic.jar /home/surajit/Opensource/iMediX-BL/
