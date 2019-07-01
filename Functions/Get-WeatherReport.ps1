function Get-WeatherReport {
    [CmdletBinding()]
    param (
        [string]$Latitude = '59.0000',
        [string]$Longtitude = '10.0000'
    )
    
    begin {
        [xml]$XML = Invoke-RestMethod -Uri "https://api.met.no/weatherapi/locationforecast/1.9/?lat=$Latitude&lon=$Longtitude" -DisableKeepAlive
        $RawWeather = $XML.weatherdata.product.time
    }
    
    process {
            0..23 | ForEach-Object {
            $Time = (Get-Date).AddHours($PSItem)
            $TimeAdjusted = (Get-Date $Time).AddHours(-2) # -2 because timezone and I'm lazy
            $TimeString = (Get-Date $TimeAdjusted -Format 'yyyy-MM-ddTHH')

            $TempWind = ($RawWeather | Where-Object from -Like $TimeString*)[0].Location
            $Precip = ($RawWeather | Where-Object from -Like $TimeString*)[-1].Location
            
            $Forecast = New-Object psobject
            $Forecast | Add-Member -NotePropertyName 'Tid' -NotePropertyValue (Get-Date $Time -Format 'HH:00')
            $Forecast | Add-Member -NotePropertyName 'Temp(c)' -NotePropertyValue $TempWind.temperature.value
            $Forecast | Add-Member -NotePropertyName 'Nedbør(mm)' -NotePropertyValue $Precip.precipitation.value
            $Forecast | Add-Member -NotePropertyName 'Skydekke(%)' -NotePropertyValue $TempWind.cloudiness.percent
            $Forecast | Add-Member -NotePropertyName 'Vindstyrke(m/s)' -NotePropertyValue $TempWind.windSpeed.mps
            $Forecast | Add-Member -NotePropertyName 'Vindbeskrivelse' -NotePropertyValue $TempWind.windSpeed.name
            $Forecast | Add-Member -NotePropertyName 'Vindretning' -NotePropertyValue $TempWind.windDirection.name
            $Forecast | Add-Member -NotePropertyName 'IconImgUri' -NotePropertyValue "https://api.met.no/weatherapi/weathericon/1.1/?symbol=$($Precip.symbol.number)&is_night=0&content_type=image/svg"

            Write-Output $Forecast
        }
    }
    
    end {
    }
}