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