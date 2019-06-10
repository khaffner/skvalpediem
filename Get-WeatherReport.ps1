function Get-WeatherReport {
    [CmdletBinding()]
    param (
        [string]$YrLocation = 'Norge/Oslo/Oslo/Oslo'
    )
    
    begin {
        [xml]$XML =Invoke-RestMethod -Uri "https://www.yr.no/sted/$YrLocation/varsel_time_for_time.xml" -DisableKeepAlive
        $Next24H = $XML.weatherdata.forecast.tabular.time | Select-Object -First 24
    }
    
    process {
        Foreach ($Entry in $Next24H) {
            $Forecast = New-Object psobject
            $Forecast | Add-Member -NotePropertyName Tid -NotePropertyValue (Get-Date $Entry.from -Format 'HH:mm')
            $Forecast | Add-Member -NotePropertyName Status -NotePropertyValue ($Entry.symbol.name)
            $Forecast | Add-Member -NotePropertyName Temp -NotePropertyValue ($Entry.temperature.value)
            $Forecast | Add-Member -NotePropertyName Nedbør -NotePropertyValue ($Entry.precipitation.value)
            $Forecast | Add-Member -NotePropertyName Vindstyrke -NotePropertyValue ($Entry.windSpeed.mps)
            $Forecast | Add-Member -NotePropertyName Vindbeskrivelse -NotePropertyValue ($Entry.windSpeed.name)
            $Forecast | Add-Member -NotePropertyName Vindretning -NotePropertyValue ($Entry.windDirection.name)
            Write-Output $Forecast
        }
    }
    
    end {
    }
}