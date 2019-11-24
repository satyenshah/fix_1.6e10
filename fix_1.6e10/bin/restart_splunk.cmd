@echo off

SET SPLUNK_HOME=%~1

timeout /t 5
net stop SplunkForwarder
net start SplunkForwarder
exit
