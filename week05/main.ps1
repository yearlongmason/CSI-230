. (Join-Path $PSScriptRoot ScrapingChamplainClasses.ps1)

$fullTable = gatherClasses
$fullTable = dayTranslator $fullTable

#Q1
#$fullTable | Select "Class Code", Instructor, Location, Days, "Time Start", "Time End" `
#           | Where { $_."Instructor" -ilike "Furkan Paligu" }

#Q2
#$fullTable | Where-Object { ($_.Location -ilike "JOYC 310") -and ($_.Days -contains "Monday") } | `
#             Sort-Object "Time Start" | `
#             Select "Time Start", "Time End", "Class Code"

#Q3
$ITSInstructors = $fullTable | Where-Object { ($_."Class Code" -ilike "CSI*") -or `
                                              ($_."Class Code" -ilike "DAT*") -or `
                                              ($_."Class Code" -ilike "SYS*") -or `
                                              ($_."Class Code" -ilike "NET*") -or `
                                              ($_."Class Code" -ilike "SEC*") -or `
                                              ($_."Class Code" -ilike "FOR*") } `
                             | Sort-Object "Instructor" `
                             | Select "Instructor" -Unique
#$ITSInstructors


#Q4
$fullTable | Where { $_.Instructor -in $ITSInstructors.Instructor } `
           | Group-Object "Instructor" | Select Count,Name | Sort-Object Count -Descending
