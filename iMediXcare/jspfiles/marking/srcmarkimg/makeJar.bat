rem copy E:\ddprasad\nb-5\onlineconf3\src\*.java .
del onlineconf3.jar
"C:\Java\jdk1.6\bin\javac.exe" *.java
"C:\Java\jdk1.6\bin\jar.exe" -cmf onlineconf3.txt onlineconf3.jar *.class netscape\javascript\*.class
del *.class
pause
