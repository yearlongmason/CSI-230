clear

<#***********************************************
Function: gatherIOC
Input:    None
Output:   Table of formatted IOC from webpage 
***********************************************#>
function gatherIOC(){
    # Get page content
    $page = Invoke-WebRequest -TimeoutSec 2 10.0.17.6/IOC.html
    
    # Get tr elements
    $trs = $page.ParsedHTML.body.getElementsByTagName("tr")

    # Create table from information
    $fullTable = @()
    for($i = 1; $i -lt $trs.length; $i++){
    
        $tds = $trs[$i].getElementsByTagName("td")

        $fullTable += [pscustomobject]@{"Pattern" = $tds[0].innerText; `
                                        "Explaination" = $tds[1].innerText;}

    }

    return $fullTable
}


<#***********************************************
Function: parseLogs
Input:    None
Output:   Table of formatted logs from access.log 
***********************************************#>
function parseLogs(){
    $path = Join-Path $PSScriptRoot ./access.log

    $logsNotFormatted = Get-Content $path
    $tableRecords = @()

    for($i=0; $i -lt $logsNotFormatted.Count; $i++){
        $words = $logsNotFormatted[$i].Split(" ")

        $tableRecords += [pscustomobject]@{ "IP" = $words[0]; `
                                            "Time" = $words[3].Trim('['); `
                                            "Method" = $words[5].Trim('"');
                                            "Page" = $words[6]; `
                                            "Protocol" = $words[7]; `
                                            "Response" = $words[8]; `
                                            "Referrer" = $words[10]; `
                                            "Client" = $words[11..($words.Count - 1)];}
    }

    return $tableRecords
}


<#***********************************************
Function: filterLogs
Input:    logs, IOC
Output:   Table of formatted logs containing IOC pattern 
***********************************************#>
function filterLogs($logs, $IOC){

    # Create new array for filtered logs
    $filteredLogs = @()

    # Loop through each log
    for($i=0; $i -lt $logs.length; $i++){
        # Check each IOC pattern. If it exists in the string add it to filteredLogs
        for($j=0; $j -lt $IOC.length; $j++){
            if($logs[$i].Page -ilike "*" + $IOC[$j].Pattern + "*"){
                $filteredLogs += $logs[$i]
                break
            }
        }
    }

    return $filteredLogs
}

$logs = parseLogs
$IOC = gatherIOC
$result = filterLogs $logs $IOC 
Write-Output $result | Format-Table | Out-String