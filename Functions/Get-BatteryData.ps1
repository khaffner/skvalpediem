function Get-BatteryData {
    param (
        [int]$Count = 1
    )
    [Double[]]$VoltageArr = @()

    for ($i = 1; $i -le $Count; $i++) {
        $VoltageArr += python $env:HOME/code/skvalpediem/Functions/voltage.py
        if($Count -gt 1) {
            Start-Sleep -Seconds 3
        }
    }
    if ($VoltageArr.Count -eq $Count) {
        $AvgVoltage = ($VoltageArr | Measure-Object -Average).Average
        $Voltage = [Math]::Round($AvgVoltage,2)
    }
    else {
        $Voltage = 0
    }
    $obj = New-Object psobject
    $obj | Add-Member -NotePropertyName Voltage -NotePropertyValue $Voltage
    $obj
}