REM store path of this bin folder
set "BINPATH=%~dp0"
REM set "SPLUNK_HOME=C:\Program Files\SplunkUniversalForwarder"

Powershell -ExecutionPolicy ByPass -File "%BINPATH%fix_1.6e10.ps1" -splunkHome "%SPLUNK_HOME%"
