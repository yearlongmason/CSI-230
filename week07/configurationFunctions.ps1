clear

<#***********************************************
Function: getConfiguration
Input:    None
Output:   Returns table containing configuration for automated email task
***********************************************#>
function getConfiguration(){
    $days = (Get-Content -Path (Join-Path $PSScriptRoot configuration.txt))[0]
    $time = (Get-Content -Path (Join-Path $PSScriptRoot configuration.txt))[1]

    $configuration = @()
    $configuration += [pscustomobject]@{"Days" = $days;`
                                        "ExecutionTime" = $time;}

    return $configuration
}