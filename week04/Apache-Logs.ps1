clear

function getSpecificLogs($page, $httpCode, $webBrowser){
    return Get-Childitem C:\xampp\apache\logs\*.log | Select-String $page | Select-String $httpCode | Select-String $webBrowser
}