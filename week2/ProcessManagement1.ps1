clear

# Q1
#Get-Process | Where-Object {$_.Name -ilike "C*"}

# Q2
#$noSys32 = Get-Process | Where-Object {$_.Path -inotlike "*system32*"}
#$noSys32 | Select ProcessName, Path | Out-String

# Q3
#$stoppedServices = Get-Service | Where-Object {$_.Status -ilike "Stopped"} | Sort-Object
#$stoppedServices | Out-String
#$stoppedServices | Export-Csv -Path $PSScriptRoot"\ServiceData.csv" -NoTypeInformation

#Q4
$chromeProcess = Get-Process | Where-Object {$_.Name -ilike "chrome"}
if($chromeProcess)
{
    Stop-Process -Name chrome
}
else
{
    Start-Process -FilePath "C:\Program Files\Google\Chrome\Application\chrome.exe" -ArgumentList '--start "https://www.champlain.edu/"'
}