Function Get-BoatReport {
    $GPSDevice = "/dev/ttyUSB0"
    if(Test-Path $GPSDevice) {
        $GPSData = gpspipe -w -n 10 | ConvertFrom-Json | Where-Object Class -EQ "TPV" | Where-Object lat -ne $null
        $GPSLatitude = ($GPSData.lat | Measure-Object -Average).Average
        $GPSLongtitude = ($GPSData.lon | Measure-Object -Average).Average
        $GPSSpeed = ($GPSData.speed | Measure-Object -Average).Average
    }
    else { # Mock some data
        $GPSLatitude = '59.0000'
        $GPSLongtitude = '10.0000'
        $GPSSpeed = '0.0'
    }
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
            Traffic     = (vnstat --json | ConvertFrom-Json -AsHashtable)
        }
        GPS               = @{
            Latitude   = $GPSLatitude
            Longtitude = $GPSLongtitude
            Speed      = $GPSSpeed
            GoogleMaps = "https://www.google.com/maps/place/$GPSLatitude,$GPSLongtitude"
            GuleSider  = "https://kart.gulesider.no/?c=$GPSLatitude,$GPSLongtitude&z=16&l=nautical&fs=true"
        }
        System            = @{
            Services = @{
                syncthing  = ($Processes.Name -contains 'syncthing')
                gpsd       = ($Processes.Name -contains 'gpsd')
                sshd       = ($Processes.Name -contains 'sshd')
                vncagent   = ($Processes.Name -contains 'vncagent')
                bluetoothd = ($Processes.Name -contains 'bluetoothd')
                vnstatd    = ($Processes.Name -contains 'vnstatd')
            }
            Uptime   = @{
                Days  = $Uptime.Days
                Hours = $Uptime.Hours
            }
        }
    }
}