 @echo off

 SET SPLUNK_HOME=%~1

 timeout /t 5
 "%SPLUNK_HOME%\bin\splunk.exe" restart
 exit
