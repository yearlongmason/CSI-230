. (Join-Path $PSScriptRoot \..\week06\Event-Logs.ps1 )
. (Join-Path $PSScriptRoot configurationFunctions.ps1)
. (Join-Path $PSScriptRoot Scheduler.ps1)
. (Join-Path $PSScriptRoot Email.ps1)

clear

# Obtaining configuration
$configuration = getConfiguration

# Obtaining at risk users
$failed = getAtRiskUsers $configuration.Days

# Sending at risk users as email
sendAlertEmail ($failed | Format-Table | Out-String)

# Setting the script to be run daily
ChooseTimeToRun $configuration.ExecutionTime
