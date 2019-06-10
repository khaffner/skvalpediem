. $PSScriptRoot/Get-BoatReport.ps1
$Data = Get-BoatReport

$Services = @()
Foreach ($Key in $Data.System.Services.keys) {
    $service = New-Object psobject
    $service | Add-Member -NotePropertyName 'Name' -NotePropertyValue $Key
    $service | Add-Member -NotePropertyName 'Running' -NotePropertyValue $Data.System.Services[$Key]
    $Services += $service
}

$Page_Home = New-UDPage -Name Home -Icon home -Title "Home" -Content {
    New-UDCard -Title "Home"
}
$Page_Map = New-UDPage -Name Map -Icon map -Title "Map" -Content {
    New-UDHtml -Markup "<iframe src=`"$($Data.GPS.GuleSider)`", width=`"640`" height=`"480`"></iframe>"
    New-UDCard -Title "Open in seperate tab" -Content {
        New-UDLink -Text "Gule sider" -Url $Data.GPS.GuleSider -Icon external-link -OpenInNewWindow
    }
}
$Page_NetworkUsage = New-UDPage -Name NetworkUsage -Icon wifi -Title "Network usage" -Content {
    New-UDImage -Path "$env:HOME/boatdata/datausage.png" -Width 320 -Height 240
}
$Page_System = New-UDPage -Name System -Icon cogs -Title "System" -Content {
    New-UDTable -Title Services -Headers Name,Running -Endpoint {
        $Services | Out-UDTableData -Property Name,Running
    }
}

$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Home" -PageName "Home" -Icon home
    New-UDSideNavItem -Text "Map" -PageName "Map" -Icon map
    New-UDSideNavItem -Text "Network usage" -PageName "NetworkUsage" -Icon wifi
    New-UDSideNavItem -Text "System" -PageName "System" -Icon cog
}

$Dashboard = New-UDDashboard -Title "Skvalpe Diem" -Pages @(
    $Page_Home,
    $Page_Map,
    $Page_NetworkUsage
    $Page_System
) `
-Navigation $Navigation `
-Footer (New-UDFooter -Copyright "Last updated: $($Data.TimeStampFriendly)")

Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dashboard -Name SkvalpeDiem -Port 8080