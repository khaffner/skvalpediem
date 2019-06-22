Function Get-ProcessReport {
    $Processes = Get-Process
    'syncthing', 'gpsd', 'sshd', 'bluetoothd' | ForEach-Object {
        $Obj = New-Object -TypeName psobject
        $Obj | Add-Member -NotePropertyName ProcessName -NotePropertyValue $PSItem
        $Obj | Add-Member -NotePropertyName Running -NotePropertyValue ($Processes -contains $PSItem)
        $Obj
    }
}