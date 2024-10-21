<#***********************************************
Function: Get Logon Logoff Table
Input:    1)int: number of days to retrieve logs from
Output:   Table of logon logoff logs 
***********************************************#>
function getLogonoffTable($numberOfDays){
    $loginouts = Get-EventLog System -Source Microsoft-Windows-Winlogon -After (Get-Date).AddDays(-$numberOfDays)

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
    return $loginoutsTable
}


<#***********************************************
Function: Get start and shutdown Table
Input:    1)int: number of days to retrieve logs from
Output:   Table of start and shutdown logs 
***********************************************#>
function getStartShutdownTable($numberOfDays){
    $startShutdown = Get-EventLog System -Source EventLog -After (Get-Date).AddDays(-$numberOfDays) | Where-Object { $_.EventID -in @(6005, 6006)}

    $startShutdownTable = @()
    for($i=0; $i -lt $startShutdown.Count; $i++){
        
        $event = ""
        if($startShutdown[$i].EventID -eq 6005) {$event = "Start"}
        if($startShutdown[$i].EventID -eq 6006) {$event = "Shutdown"}

        $startShutdownTable += [pscustomobject]@{"Time" = $startShutdown[$i].TimeGenerated; `
                                                 "Id" = $startShutdown[$i].EventID; `
                                                 "Event" = $event; `
                                                 "User" = "System"}
    }
    return $startShutdownTable
}
