﻿clear

#Q1
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress

#Q2
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength

#Q3
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" }

#Q4
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object

#Q5
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer

#Q6
#Get-CimInstance Win32_NetworkAdapterConfiguration -Filter "DHCPEnabled=$true" | Select DHCPServer | Format-Table -HideTableHeaders

#Q7
#(Get-DnsClientServerAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).ServerAddresses

#Q8
#cd $PSScriptRoot
#
#$files = (Get-ChildItem)
#for ($i=0; $i -le $files.Count; $i++)
#{
#    if($files[$i].Name -ilike "*.ps1")
#    {
#        Write-Host $files[$i].Name
#    }
#}

#Q9
#$folderPath = "$PSScriptRoot\outFolder"
#if(Test-Path -Path $folderPath)
#{
#    Write-Host "Folder already exists!"
#}
#else
#{
#    New-Item -ItemType "directory" -Path $folderPath
#}

#Q10
cd $PSScriptRoot
$files = Get-ChildItem

$folderPath = "$PSScriptRoot\outfolder\"
$filePath =  $folderPath + "out.csv"
Write-Host $files
Write-Host $folderPath
Write-Host $filePath