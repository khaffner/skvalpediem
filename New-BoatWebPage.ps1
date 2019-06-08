. ./Get-BoatReport.ps1

$Data = Get-BoatReport

$HtmlContent = @"
<!DOCTYPE html>
<meta charset="UTF-8">
<html>
 
<head>
<title>Skvalpe Diem</title>
</head>
 
<body>
 
<h1>Skvalpe Diem</h1>

<p>Map</p>
<iframe 
    src="https://kart.gulesider.no/?c=$($Data.GPS.Latitude),$($Data.GPS.Longtitude)&z=15&l=nautical&fs=true" 
    frameborder="", 
    width="800" 
    height="600"
></iframe>

<p>Network stats</p>
<img src="datausage.png" alt="">
 
</body>

</html>
"@

$HtmlContent | Out-File $env:HOME/boatdata/web/index.htm