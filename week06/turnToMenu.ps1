. (Join-Path $PSScriptRoot \..\week02\ProcessManagement1.ps1 )
. (Join-Path $PSScriptRoot \..\week04\GetApacheLogsTable.ps1 )
. (Join-Path $PSScriptRoot Event-Logs.ps1 )

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Display last 10 apache logs`n"
$Prompt += "2 - Display last 10 failed logins for all users`n"
$Prompt += "3 - Display at risk users`n"
$Prompt += "4 - Start Chrome web browser and navigate it to champlain.edu (or stop process if already running)`n"
$Prompt += "5 - Exit`n"

$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # Exit loop
    if($choice -eq 5){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # Get last 10 apache logs
    elseif($choice -eq 1){
        $apacheLogs = ApacheLogs1
        Write-Output ($apacheLogs | Select -Last 10 | Format-Table | Out-String)
    }

    # Get last 10 failed logins
    elseif($choice -eq 2){
        $days = Read-Host -Prompt "Please enter the number of days"

        $failedLogins = getFailedLogins $days
        Write-Output ($failedLogins | Select -Last 10 | Format-Table | Out-String)
    }

    # Get at risk users
    elseif($choice -eq 3){
        $days = Read-Host -Prompt "Please enter the number of days"

        $atRiskUsers = getAtRiskUsers $days
        Write-Output ($atRiskUsers | Format-Table | Out-String)
    }

    # Start chrome process (or end if exists)
    elseif($choice -eq 4){
        startChromeProcess
    }

    # If user enters invalid option
    else{
        Write-Output "Error: Invalid choice"
    }
}