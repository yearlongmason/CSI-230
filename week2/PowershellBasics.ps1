clear

#Q1
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).IPAddress

#Q2
#(Get-NetIPAddress -AddressFamily IPv4 | Where-Object { $_.InterfaceAlias -ilike "Ethernet0" }).PrefixLength

#Q3
#Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" }

#Q4
Get-WmiObject -List | Where-Object { $_.Name -ilike "Win32_Net*" } | Sort-Object
