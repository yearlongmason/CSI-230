clear

#Q1
#Get-Content C:\xampp\apache\logs\access.log

#Q2
#Get-Content C:\xampp\apache\logs\access.log -Tail 5

#Q3
#Get-Content C:\xampp\apache\logs\access.log | Select-String " 404 ", " 400 "

#Q4
#Get-Content C:\xampp\apache\logs\access.log | Select-String " 200 " -NotMatch

#Q5
#$A = Get-Childitem C:\xampp\apache\logs\*.log | Select-String "error"
#$A[-5..-1]

#Q6
$notFounds = Get-Content C:\xampp\apache\logs\access.log | Select-String " 404 "

$regex = [regex] "[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}"

$ipsUnorganized = $regex.Matches($notFounds)

$ips = @()
for($i=0; $i -lt $ipsUnorganized.Count; $i++){
    $ips += [pscustomobject]@{ "IP" = $ipsUnorganized[$i].Value}
}
#$ips | Where-Object { $_.IP -ilike "10.*" }

#Q7
$ipsOften = $ips | Where-Object { $_.IP -ilike "10.*" }
$counts = $ipsOften | Group-Object IP
$counts | Select-Object Count, Name

