$ScriptText = {
    $StaticRoutes = @()
    foreach($ActiveRoute in (Get-WmiObject Win32_ActiveRoute))
    {
        $StaticRoute = New-Object System.Object
        
        #Get routes
        $ActiveRouteInterfaceIndex = $ActiveRoute.SystemElement -split ","
        $ActiveRouteInterfaceIndex = (($ActiveRouteInterfaceIndex | Where-Object {$_ -match "InterfaceIndex"}) -split "=")[-1]
        
        #Get route interface index
        $StaticRoute | Add-Member -Type NoteProperty -Name InterfaceIndex -Value $ActiveRouteInterfaceIndex
        
        #Get MAC address for the interface index
        $NetworkAdapterMACAddress = (Get-WmiObject Win32_NetworkAdapter | Where-Object `
        {$_.InterfaceIndex -eq $ActiveRouteInterfaceIndex}).MacAddress
        $StaticRoute | Add-Member -Type NoteProperty -Name MacAddress -Value $NetworkAdapterMACAddress
                                
        #Get route destination, subnet mask and next hop
        foreach($Property in ("Destination","Mask","NextHop"))
        {
            $Value = $ActiveRoute.SameElement -split "," | Where-Object {$_ -match $Property}
            $Value = ($Value -split "=")[-1] -replace '"',''
            $StaticRoute | Add-Member -Type NoteProperty -Name $Property -Value $Value
        }                        
        #Get route metric
        $Value = $ActiveRoute.SameElement -split "," | Where-Object {$_ -match "Metric"}
        $Value = ($Value -split "=")[-1]
        $StaticRoute | Add-Member -Type NoteProperty -Name Metric -Value $Value
        $StaticRoutes += $StaticRoute
    } 
    $StaticRoutes | ConvertTo-CSV -NoTypeInformation # convert to csv
}

$StaticRoutes = Invoke-VMScript -ScriptText $ScriptText -VM $VMToConvert.Name -GuestCredential $GuestCredential -ScriptType Powershell -WarningAction SilentlyContinue | ConvertFrom-Csv
