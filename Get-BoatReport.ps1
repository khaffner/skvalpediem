Function Get-BoatReport {
    $GPSData = gpspipe -w -n 5 | ConvertFrom-Json | Where-Object Class -EQ "TPV" | Select-Object -Last 1
    $IpifyRequest = Invoke-WebRequest -Uri api.ipify.org

    New-Object -TypeName psobject -Property @{
        TimeStampRaw      = (Get-Date -Format o)
        TimeStampFriendly = (Get-Date).ToString('dd.MM.yyyy HH:mm')
        Network           = @{
            HasInternet   = (($IpifyRequest).StatusDescription -EQ "OK")
            ExternalIP    = $IpifyRequest.Content
            InternalIP    = ((hostname -I).Split(' ') | Select-Object -SkipLast 1)
        }
        GPS               = @{
            Latitude   = $GPSData.lat
            Longtitude = $GPSData.lon
            Speed      = $GPSData.speed
            GoogleMaps = "https://www.google.com/maps/place/$($GPSData.lat),$($GPSData.lon)"
        }
    }
}