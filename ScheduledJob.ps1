Get-ChildItem "$env:HOME/code/skvalpediem/Functions" -Filter '*.ps1' | Import-Module -Force
$LogDir = "$env:HOME/boatdata"
	
$Header = @"
<style>
TABLE {border-width: 1px; border-style: solid; border-color: black; border-collapse: collapse;}
TH {border-width: 1px; padding: 3px; border-style: solid; border-color: black; background-color: #6495ED;}
TD {border-width: 1px; padding: 3px; border-style: solid; border-color: black;}
</style>
"@

$Timestamp = Get-Timestamp

$GPSData = Get-GPSData
$GPSData | Export-Csv -Delimiter ';' -Path "$LogDir/gpsdata/$($Timestamp.TimeStampSortable).csv" -Force

$ProcessReport = Get-ProcessReport 
$ProcessReport | Export-Csv -Delimiter ';' -Path "$LogDir/processreport/$($Timestamp.TimeStampSortable).csv"
$ProcessReport | ConvertTo-Html -Charset UTF8 -Head $Header | Out-File -FilePath "$LogDir/webpages/processreport.html" -Force

$NetData = Get-NetData | Select-Object @{Name = 'InternalIP'; E = {$_.InternalIP}}, ExternalIP, HasInternet
$NetData | Export-Csv -Delimiter ';' -Path "$LogDir/netdata/$($Timestamp.TimeStampSortable).csv"
$NetData | ConvertTo-Html -Charset UTF8 -Head $Header | Out-File -FilePath "$LogDir/webpages/netdata.html" -Force

$WeatherData = Get-WeatherReport -Latitude $GPSData.Latitude -Longtitude $GPSData.Longtitude
$WeatherData | Export-Csv -Delimiter ';' -Path "$LogDir/weatherdata/$($Timestamp.TimeStampSortable).csv"
$WeatherData | Select-Object -Property * -ExcludeProperty IconImgUri | ConvertTo-Html -Charset UTF8 -Head $Header | Out-File -FilePath "$LogDir/webpages/weatherreport.html" -Force

$BatteryData = Get-BatteryData -Count 3
$BatteryData | Export-Csv -Delimiter ';' -Path "$LogDir/batterydata/$($Timestamp.TimeStampSortable).csv"

$Template = Get-Content -Path "$PSScriptRoot/indextemplate.html"
$ExecutionContext.InvokeCommand.ExpandString($template) | Out-File -FilePath "$LogDir/webpages/index.html" -Force