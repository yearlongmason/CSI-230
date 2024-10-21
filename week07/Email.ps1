clear

<#***********************************************
Function: sendAlertEmail
Input:    Body of the email
Output:   Sends an email to me
***********************************************#>
function sendAlertEmail($body){
    $from = "mason.lee@mymail.champlain.edu"
    $to = "mason.lee@mymail.champlain.edu"
    $subject = "Suspicious Activity"

    $password = "byya cxju fzfl dgys" | ConvertTo-SecureString -AsPlainText -Force
    $credential = New-Object -TypeName System.Management.Automation.PSCredential -ArgumentList $from, $password

    Send-MailMessage -From $from -To $to -Subject $subject -Body $body -SmtpServer "smtp.gmail.com" `
    -Port 587 -UseSsl -Credential $credential

}

#sendAlertEmail "Body of email"