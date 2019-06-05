Function Get-BoatReport {
    $GPSData = gpspipe -w -n 10 | ConvertFrom-Json | Where-Object Class -EQ "TPV" | Where-Object lat -ne $null
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
            Latitude   = ($GPSData.lat | Measure-Object -Average).Average
            Longtitude = ($GPSData.lon | Measure-Object -Average).Average
            Speed      = ($GPSData.speed  | Measure-Object -Average).Average
            GoogleMaps = "https://www.google.com/maps/place/$($GPSData.lat),$($GPSData.lon)"
        }
    }
}