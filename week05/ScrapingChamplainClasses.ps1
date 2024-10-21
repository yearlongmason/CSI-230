clear

<#***********************************************
Function: Gather Classes
Input:    None
Output:   Table of Champlain Classes
***********************************************#>
function gatherClasses(){
    $page = Invoke-WebRequest -TimeoutSec 2 http://10.0.17.31/courses.html
    
    $trs = $page.ParsedHTML.body.getElementsByTagName("tr")

    $fullTable = @()
    for($i = 1; $i -lt $trs.length; $i++){
    
        $tds = $trs[$i].getElementsByTagName("td")

        $times = $tds[5].innerText.split("-")

        $fullTable += [pscustomobject]@{"Class Code" = $tds[0].innerText; `
                                        "Title" = $tds[1].innerText; `
                                        "Days" = $tds[4].innerText; `
                                        "Time Start" = $times[0]; `
                                        "Time End" = $times[1]; `
                                        "Instructor" = $tds[6].innerText; `
                                        "Location" = $tds[9].innerText;}
    }

    return $fullTable
}

<#***********************************************
Function: Day Translator
Input:    1) Full table (Table of Champlain classes)
Output:   Table of Champlain Classes with well formatted "Days" column
***********************************************#>
function dayTranslator($fullTable){
    
    for($i = 0; $i -lt $fullTable.Length; $i++){
        $days = @()

        if($fullTable[$i].Days -match "M+"){ $days += "Monday" }
        if($fullTable[$i].Days -match "^T[^H][WTF]*"){ $days += "Tuesday" }
        elseif($fullTable[$i].Days -match "^T$"){ $days += "Tuesday" }
        if($fullTable[$i].Days -match "W+"){ $days += "Wednesday" }
        if($fullTable[$i].Days -match "TH+"){ $days += "Thursday" }
        if($fullTable[$i].Days -match "F+"){ $days += "Friday" }
        
        $fullTable[$i].Days = $days
    }

    return $fullTable
}