. $PSScriptRoot/Get-BoatReport.ps1

$DataFile = "$env:HOME/boatdata/data.json"

$DataDir = Split-Path $DataFile -Parent
if(!(Test-Path $DataDir)) {
    New-Item $Datadir -ItemType Directory
}

$NewData = Get-BoatReport

[object[]]$Data = @()
$Data += (Get-Content $DataFile -ErrorAction SilentlyContinue | ConvertFrom-Json)
$Data += $NewData
$Data | ConvertTo-Json -Depth 5 | Out-File -FilePath $DataFile -Force | Out-Null
