param(
  [string]$splunkHome  = $env:SPLUNK_HOME
)

if ( -not ($splunkHome) ) {
  $splunkHome = "$env:ProgramFiles\SplunkUniversalForwarder"
}

if ( -not ($PSScriptRoot) ) {
  # for Powershell 2 compatibility
  $PSScriptRoot = Split-Path $MyInvocation.MyCommand.Path -Parent
}

[string]$DATETIMEXML = "$splunkHome\etc\datetime.xml"
[string]$EPOCHMATCHOLD = [regex]::escape(':1[012345]|9)\d{8}')
[string]$EPOCHMATCHNEW = ':1[0123456]|9)\d{8}'
[bool]$REBOOTFLAG = $false

# check datetime.xml
if (Select-String -Pattern $EPOCHMATCHOLD -CaseSensitive -Path "$DATETIMEXML" -quiet) {

 # replace string
 ((Get-Content "$DATETIMEXML") -replace $EPOCHMATCHOLD,$EPOCHMATCHNEW ) | Set-Content "$DATETIMEXML"

 # verify
 if (-Not (Select-String -Pattern $EPOCHMATCHOLD -CaseSensitive -Path "$DATETIMEXML" -quiet)) {
  $REBOOTFLAG = $true
 }
}

# restart splunk if necessary
if ( $REBOOTFLAG ) {
 echo "restarting splunk"
 Invoke-WmiMethod -Class Win32_Process -Name Create -ArgumentList ("$PSScriptRoot\restart_splunk.cmd " + """$splunkHome""")
}