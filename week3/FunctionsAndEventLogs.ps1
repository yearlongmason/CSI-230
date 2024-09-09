.(Join-Path $PSScriptRoot functions.ps1)

clear

#Q1
#Get-EventLog System -Source Microsoft-Windows-Winlogon

#Q2
#$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)
#
#$loginoutsTable = @() #Empty array
#for($i=0; $i -lt $loginouts.Count; $i++){
#    
#    $event = ""
#    if($loginouts[$i].InstanceId -eq 7001) {$event = "Logon"}
#    if($loginouts[$i].InstanceId -eq 7002) {$event = "Logoff"}
#
#    $user = $loginouts[$i].ReplacementStrings[1]
#
#    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
#                                        "Id" = $loginouts[$i].EventId; `
#                                        "Event" = $event; `
#                                        "User" = $user;
#                                        }
#}
#$loginoutsTable

#Q3
<#
$loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-14)

$loginoutsTable = @() #Empty array
for($i=0; $i -lt $loginouts.Count; $i++){
    
    $event = ""
    if($loginouts[$i].InstanceId -eq 7001) {$event = "Logon"}
    if($loginouts[$i].InstanceId -eq 7002) {$event = "Logoff"}

    $user = New-Object System.Security.Principal.SecurityIdentifier($loginouts[$i].ReplacementStrings[1])
    $user = $user.Translate([System.Security.Principal.NTAccount])

    $loginoutsTable += [pscustomobject]@{"Time" = $loginouts[$i].TimeGenerated; `
                                        "Id" = $loginouts[$i].EventId; `
                                        "Event" = $event; `
                                        "User" = $user;
                                        }
}
$loginoutsTable
#>

#Q4
#getLogonoffTable(5);

#Q5
Get-EventLog System | Where-Object { $_.InstanceId -eq 1074}#Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-5)