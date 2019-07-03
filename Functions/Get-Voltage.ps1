function Get-Voltage {
    param (
        [int]$Count = 1
    )
    [Double[]]$Voltage = @()

    for ($i = 1; $i -le $Count; $i++) {
        $Voltage += python $env:HOME/code/skvalpediem/Functions/voltage.py
        if($Count -gt 1) {
            Start-Sleep -Seconds 3
        }
    }
    if ($Voltage.Count -eq $Count) {
        return ($Voltage | Measure-Object -Average).Average
    }
    else {
        return 0
    }
}