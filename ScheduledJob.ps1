param(
    [string]$Schedule
)

Get-ChildItem $env:HOME\code\skvalpediem\Functions | Import-Module -Force
$Timestamp = Get-Timestamp

$LogDir = "$env:HOME/boatdata"

if($Schedule -eq '15m') {
    Get-GPSData | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/gpsdata/$($Timestamp.TimeStampSortable).csv"
}
if($Schedule -eq '1h') {
    Get-ProcessReport | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/processreport/$($Timestamp.TimeStampSortable).csv"
    Get-NetData | Select-Object {$_.InternalIP},ExternalIP,HasInternet | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/network/$($Timestamp.TimeStampSortable).csv"
    Get-WeatherReport | ConvertTo-Csv -Delimiter ';' | Out-File -FilePath "$LogDir/weatherreport/$($Timestamp.TimeStampSortable).csv"
}
if($Schedule -eq '1d') {
}