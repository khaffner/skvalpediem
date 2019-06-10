. $PSScriptRoot/Get-BoatReport.ps1
$Data = Get-BoatReport

$Page_Home = New-UDPage -Name Home -Icon home -Title "Home" -Content {New-UDCard -Title "Home"}
$Page_Map = New-UDPage -Name Map -Icon map -Title "Map" -Content {New-UDHtml -Markup "<iframe src=`"$($Data.GPS.GuleSider)`", width=`"800`" height=`"600`"></iframe>"}
$Page_NetworkUsage = New-UDPage -Name NetworkUsage -Icon wifi -Title "Network usage" -Content {New-UDImage -Path $env:HOME/boatdata/datausage.png -Width 640 -Height 480}

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Home" -PageName "Home" -Icon home
    New-UDSideNavItem -Text "Map" -PageName "Map" -Icon map
    New-UDSideNavItem -Text "Network usage" -PageName "NetworkUsage" -Icon wifi
}

$Dashboard = New-UDDashboard -Title "Skvalpe Diem" -Pages @(
    $Page_Home,
    $Page_Map,
    $Page_NetworkUsage
) `
-Navigation $Navigation `
-Footer (New-UDFooter -Copyright "Last updated: $($Data.TimeStampFriendly)")

Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dashboard -Name SkvalpeDiem -Port 8080