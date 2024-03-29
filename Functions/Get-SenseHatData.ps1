function Get-SenseHatData {
    $Raw = python $env:HOME/code/skvalpediem/Functions/SenseHat.py

    $Obj = New-Object -TypeName psobject
    
    $Orientation = $Raw[0] | ConvertFrom-Json
    ForEach($AxisName in ($Orientation | Get-Member -MemberType NoteProperty).Name) {
        $AxisValue = ([System.Math]::Round($Orientation.$AxisName,0))
        if($AxisValue -eq 360) {
            $AxisValue = 0
        }
        $Obj | Add-Member -NotePropertyName $AxisName -NotePropertyValue $AxisValue
    }

    $CompassDegree = ([System.Math]::Round($Raw[1],0))
    $CompassDegree = $CompassDegree + 235 # correct for rotation and weird measurement
    if($CompassDegree -ge 360) {
        $CompassDegree = $CompassDegree - 360
    }
    $Obj | Add-Member -NotePropertyName "Compass" -NotePropertyValue $CompassDegree
    
    $Obj | Add-Member -NotePropertyName "Humidity" -NotePropertyValue ([System.Math]::Round($Raw[2],0))
    $Obj | Add-Member -NotePropertyName "Pressure" -NotePropertyValue ([System.Math]::Round($Raw[3],2))
    $Obj
}