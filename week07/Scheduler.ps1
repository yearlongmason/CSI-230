clear

<#***********************************************
Function: ChooseTimeToRun
Input:    time to run task
Output:   If task does not already exist it will create the task otherwise it will delete the task and recreate it
***********************************************#>
function ChooseTimeToRun($time){
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }

    if($scheduledTasks -ne $null){
        Write-Host "Task already exists" | Out-String
        DisableAutoRun
    }

    Write-Host "Creating new task" | Out-String

    $action = New-ScheduledTaskAction -Execute "Powershell.exe" `
             -Argument "-File `"C:\Users\champuser\Downloads\CSI-230\week07\main.ps1`""
    $trigger = New-ScheduledTaskTrigger -Daily -At $time
    $principal = New-ScheduledTaskPrincipal -UserId "champuser" -RunLevel Highest
    $settings = New-ScheduledTaskSettingsSet -RunOnlyIfNetworkAvailable -WakeToRun
    $task = New-ScheduledTask -Action $action -Trigger $trigger -Principal $principal -Settings $settings

    Register-ScheduledTask 'myTask' -InputObject $task

    Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }
}

<#***********************************************
Function: DisableAutoRun
Input:    None
Output:   Disables task
***********************************************#>
function DisableAutoRun(){
    $scheduledTasks = Get-ScheduledTask | Where-Object { $_.TaskName -ilike "myTask" }

    if($scheduledTasks -ne $null){
        Write-Host "Unregistering the task" | Out-String
        Unregister-ScheduledTask -TaskName 'myTask' -Confirm:$false
    }
    else{
        Write-Host "The task is not registered" | OutString
    }
}

#ChooseTimeToRun "5:00 PM"
#DisableAutoRun