#$WeatherHeaders = 'Tid', 'Status', 'Temp', 'Nedbør', 'Vindstyrke', 'Vindbeskrivelse', 'Vindretning'
$LogDir = "$env:HOME/boatdata/"

### Get Data ###
$GPSData = Get-ChildItem "$LogDir/gpsdata" | Select-Object -Last 1 | Import-Csv -Delimiter ';'

### Dashboard ###
$Navigation = New-UDSideNav -Content {
    New-UDSideNavItem -Text "Home" -PageName "home" -Icon home
    New-UDSideNavItem -Text "Map" -PageName "map" -Icon map
}

$Dashboard = New-UDDashboard -Title "Skvalpe Diem" -Pages @(
    New-UDPage -Name Home -Icon home -Title "Home" -Content {
        New-UDCard -Title "Home"
    }
    New-UDPage -Name Map -Icon map -Title "Map" -Content {
        New-UDHtml -Markup "<iframe src=`"$($GPSData.GuleSider)`", width=`"640`" height=`"480`"></iframe>"
        New-UDCard -Title "Open in seperate tab" -Content {
            New-UDLink -Text "Gule sider" -Url $GPSData.GuleSider -Icon external-link -OpenInNewWindow
        }
    }
) -Navigation $Navigation
Get-UDDashboard | Stop-UDDashboard
Start-UDDashboard -Dashboard $Dashboard -Name SkvalpeDiem -Port 8080