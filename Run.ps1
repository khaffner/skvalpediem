. $PSScriptRoot/Get-BoatReport.ps1

$DataFile = "$env:HOME/boatdata/data.json"

$DataDir = Split-Path $DataFile -Parent
if(!(Test-Path $DataDir)) {
    New-Item $Datadir -ItemType Directory
}

vnstati -vs -i enxb827eb2b9087+wlan0 -o /home/pi/boatdata/datausage.png

$NewData = Get-BoatReport

[object[]]$Data = @()
$Data += (Get-Content $DataFile -ErrorAction SilentlyContinue | ConvertFrom-Json)
$Data += $NewData
$Data | ConvertTo-Json -Depth 10 | Out-File -FilePath $DataFile -Force | Out-Null
