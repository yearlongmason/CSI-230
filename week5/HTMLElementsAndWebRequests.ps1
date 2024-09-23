clear

#Q1
#$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.31/ToBeScraped.html
#$scrapedPage.Links.Count

#Q2
#$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.31/ToBeScraped.html
#$scrapedPage.Links

#Q3
#$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.31/ToBeScraped.html
#$scrapedPage.Links | Select outerText, href

#Q4
#$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.31/ToBeScraped.html
#$h2s = $scrapedPage.parsedHTML.body.getElementsByTagName("h2") | Select outerText
#Write-Output $h2s

#Q4
$scrapedPage = Invoke-WebRequest -TimeoutSec 10 http://10.0.17.31/ToBeScraped.html
$divs1 = $scrapedPage.parsedHTML.body.getElementsByTagName("div") | `
Where { $_.getAttributeNode("class").Value -ilike "div-1" } | Select innerText
$divs1