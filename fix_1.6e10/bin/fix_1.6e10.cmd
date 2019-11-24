REM store path of this bin folder
SET "BINPATH=%~dp0"
IF "%SPLUNK_HOME%"=="" SET "SPLUNK_HOME=C:\Program Files\SplunkUniversalForwarder"

"%WINDIR%\System32\findstr.exe" /l /c:"(?:1[012345]|9)\d{8}" "%SPLUNK_HOME%\etc\datetime.xml"
IF NOT %ERRORLEVEL% EQU 0 GOTO DONE

COPY "%BINPATH%..\static\datetime.xml" "%SPLUNK_HOME%\etc\datetime.xml" /y

"%WINDIR%\System32\findstr.exe" /l /c:"(?:1[012345]|9)\d{8}" "%SPLUNK_HOME%\etc\datetime.xml"
IF %ERRORLEVEL% EQU 0 GOTO DONE
START CALL "%BINPATH%restart_splunk.cmd" "%SPLUNK_HOME%"

:DONE
EXIT