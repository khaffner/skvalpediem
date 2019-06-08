. $PSScriptRoot/Get-BoatReport.ps1

$DataDir = "$env:HOME/boatdata"

if(!(Test-Path $DataDir)) {
    New-Item $Datadir -ItemType Directory
}

vnstati -vs -i enxb827eb2b9087+wlan0 -o "$DataDir/web/datausage.png"

$NewData = Get-BoatReport

[object[]]$Data = @()
$Data += (Get-Content "$DataDir/rawdata.json" -ErrorAction SilentlyContinue | ConvertFrom-Json)
$Data += $NewData
$Data | ConvertTo-Json -Depth 10 | Out-File -FilePath "$DataDir/rawdata.json" -Force | Out-Null

Get-Job -Name webserver -ErrorAction SilentlyContinue | Stop-Job
Start-Job -Name webserver -ScriptBlock {Set-Location /home/pi/boatdata/web/;python3 -m http.server 8080} | Out-Null