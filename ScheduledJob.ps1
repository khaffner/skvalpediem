Get-ChildItem "$env:HOME/code/skvalpediem/Functions" | Import-Module -Force
$LogDir = "$env:HOME/boatdata"

$Timestamp = Get-Timestamp

$GPSData = Get-GPSData
$GPSData | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/gpsdata/$($Timestamp.TimeStampSortable).csv"

$ProcessReport = Get-ProcessReport 
$ProcessReport | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/processreport/$($Timestamp.TimeStampSortable).csv"

$NetData = Get-NetData | Select-Object { $_.InternalIP }, ExternalIP, HasInternet 
$NetData | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/netdata/$($Timestamp.TimeStampSortable).csv"

$WeatherData = Get-WeatherReport -Latitude $GPSData.Latitude -Longtitude $GPSData.Longtitude
$WeatherData | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/weatherdata/$($Timestamp.TimeStampSortable).csv"

