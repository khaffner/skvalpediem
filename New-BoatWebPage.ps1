. $PSScriptRoot/Get-BoatReport.ps1

$Data = Get-BoatReport

$HtmlContent = @"
<!DOCTYPE html>
<meta charset="UTF-8">
<html>
 
<head>
<title>Skvalpe Diem</title>
</head>

<style>
body {
    width: 80%;
    margin-left: auto;
    margin-right: auto
}
</style>

<body>
 
<h1>Skvalpe Diem</h1>

<iframe 
    src="https://kart.gulesider.no/?c=$($Data.GPS.Latitude),$($Data.GPS.Longtitude)&z=15&l=nautical&fs=true" 
    width="800" 
    height="600"
></iframe>
<a href="https://kart.gulesider.no/?c=$($Data.GPS.Latitude),$($Data.GPS.Longtitude)&z=15&l=nautical&fs=true">Click here for full map</a>
<p></p>

<img 
    src="datausage.png"
    width="800"
    height="600"
>
Network stats
 
</body>
</html>
"@

$HtmlContent | Out-File $env:HOME/boatdata/web/index.htm