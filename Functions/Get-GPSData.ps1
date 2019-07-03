Function Get-GPSData {
    $GPSDevice = "/dev/ttyUSB0"
    if (Test-Path $GPSDevice) {
        $GPSData = gpspipe -w -n 10 | ConvertFrom-Json | Where-Object lat -ne $null
        if ($GPSData) {
            $GPSLatitude = ($GPSData.lat | Measure-Object -Average).Average
            $GPSLongtitude = ($GPSData.lon | Measure-Object -Average).Average
            $GPSSpeed = ($GPSData.speed | Measure-Object -Average).Average
        }
        else {
            # Mock some data
            $GPSLatitude = '0.0000'
            $GPSLongtitude = '0.0000'
            $GPSSpeed = '0.0'
        }
    }
    else {
        # Mock some data
        $GPSLatitude = '0.0000'
        $GPSLongtitude = '0.0000'
        $GPSSpeed = '0.0'
    }
    New-Object -TypeName psobject -Property @{
        Latitude   = $GPSLatitude
        Longtitude = $GPSLongtitude
        Speed      = $GPSSpeed
        GoogleMaps = "https://www.google.com/maps/place/$GPSLatitude,$GPSLongtitude"
        GuleSider  = "https://kart.gulesider.no/?c=$GPSLatitude,$GPSLongtitude&z=16&l=nautical&fs=true&som=ex"
    }
}