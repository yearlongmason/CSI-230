. (Join-Path $PSScriptRoot configurationFunctions.ps1)

clear

$Prompt = "`n"
$Prompt += "Please choose your operation:`n"
$Prompt += "1 - Show Configuration`n"
$Prompt += "2 - Change Configuration`n"
$Prompt += "3 - Exit`n"

$operation = $true

while($operation){

    
    Write-Host $Prompt | Out-String
    $choice = Read-Host 

    # Exit loop
    if($choice -eq 3){
        Write-Host "Goodbye" | Out-String
        exit
        $operation = $false 
    }

    # Show Configuration
    elseif($choice -eq 1){
        $configuration = getConfiguration

        Write-Output $configuration | Format-Table | Out-String
    }

    # Change Configuration
    elseif($choice -eq 2){
        $days = Read-Host -Prompt "Enter the number of days for which the logs will be obtained"
        $time = Read-Host -Prompt "Enter the daily execution time of the script"

        $dayRegex = "^\d+$"
        $timeRegex = "^\d+\:\d{1}\d{1} (?:AM|PM)$"

        # Check if day or time are invalid
        if(-not ($days -match $dayRegex)){
            Write-Output "ERROR: Invalid input for number of days"
            continue
        }
        if(-not ($time -match $timeRegex)){
            Write-Output "ERROR: Invalid input for time"
            continue
        }

        Set-Content -Path (Join-Path $PSScriptRoot configuration.txt) -Value $days
        Add-Content -Path (Join-Path $PSScriptRoot configuration.txt) -Value $time
    }

    # If user enters invalid option
    else{
        Write-Output "Error: Invalid choice"
    }
}