. $PSScriptRoot/Functions/Get-BoatReport.ps1

$DataDir = "$env:HOME/boatdata"

if(!(Test-Path $DataDir)) {
    New-Item $Datadir -ItemType Directory
}

$NetworkInterfaces = ((ifconfig | Select-String '^[a-z0-9]{2,}' -AllMatches).Matches.Value | Where-Object {$_ -ne 'lo'}) -join '+'
vnstati -vs -i $NetworkInterfaces -o "$DataDir/datausage.png"

$NewData = Get-BoatReport

[object[]]$Data = @()
$Data += (Get-Content "$DataDir/rawdata.json" -ErrorAction SilentlyContinue | ConvertFrom-Json)
$Data += $NewData
$Data | ConvertTo-Json -Depth 10 | Out-File -FilePath "$DataDir/rawdata.json" -Force | Out-Null

. $PSScriptRoot/Functions/New-Dashboard.ps1