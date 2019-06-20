Function Get-Timestamp {
    New-Object -TypeName psobject -Property @{
        TimeStampRaw      = (Get-Date -Format o)
        TimeStampFriendly = (Get-Date).ToString('dd.MM.yyyy HH:mm')
        TimeStampSortable = (Get-Date).ToString('yyyy.MM.dd HH.mm')
    }
}