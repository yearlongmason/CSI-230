. (Join-Path $PSScriptRoot Apache-Logs.ps1)
. (Join-Path $PSScriptRoot GetApacheLogsTable.ps1)
clear

#getSpecificLogs "index.html" "200" "Chrome"

ApacheLogs1 | Format-Table -AutoSize -Wrap