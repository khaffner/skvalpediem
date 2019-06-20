Function Get-NetData {
    $IpifyRequest = Invoke-WebRequest -Uri api.ipify.org

    New-Object -TypeName psobject -Property @{
        HasInternet = (($IpifyRequest).StatusDescription -EQ "OK")
        ExternalIP  = $IpifyRequest.Content
        InternalIP  = ((hostname -I).Split(' ') | Select-Object -SkipLast 1)
        Traffic     = (vnstat --json | ConvertFrom-Json -AsHashtable)
    }
}