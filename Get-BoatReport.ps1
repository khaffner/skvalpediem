Function Get-BoatReport {
    $GPSData = gpspipe -w -n 10 | ConvertFrom-Json | Where-Object Class -EQ "TPV" | Where-Object lat -ne $null
    $GPSLatitude = ($GPSData.lat | Measure-Object -Average).Average
    $GPSLongtitude = ($GPSData.lon | Measure-Object -Average).Average
    $GPSSpeed = ($GPSData.speed | Measure-Object -Average).Average

    $IpifyRequest = Invoke-WebRequest -Uri api.ipify.org
    $Processes = Get-Process
    $Uptime = Get-Uptime

    New-Object -TypeName psobject -Property @{
        TimeStampRaw      = (Get-Date -Format o)
        TimeStampFriendly = (Get-Date).ToString('dd.MM.yyyy HH:mm')
        Network           = @{
            HasInternet = (($IpifyRequest).StatusDescription -EQ "OK")
            ExternalIP  = $IpifyRequest.Content
            InternalIP  = ((hostname -I).Split(' ') | Select-Object -SkipLast 1)
        }
        GPS               = @{
            Latitude   = $GPSLatitude
            Longtitude = $GPSLongtitude
            Speed      = $GPSSpeed
            GoogleMaps = "https://www.google.com/maps/place/$GPSLatitude,$GPSLongtitude"
        }
        System            = @{
            Services = @{
                syncthing  = ($Processes.Name -contains 'syncthing')
                gpsd       = ($Processes.Name -contains 'gpsd')
                ssh        = ($Processes.Name -contains 'sshd')
                vncagent   = ($Processes.Name -contains 'vncagent')
                bluetoothd = ($Processes.Name -contains 'bluetoothd')
            }
            Uptime   = @{
                Days  = $Uptime.Days
                Hours = $Uptime.Hours
            }
        }
    }
}