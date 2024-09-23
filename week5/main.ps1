. (Join-Path $PSScriptRoot ScrapingChamplainClasses.ps1)

$fullTable = gatherClasses
$fullTable = dayTranslator $fullTable

$fullTable