$ver = [System.Environment]::OSVersion.Version

if ($ver -like "10.*" -or $ver -like "11.*" -or $ver -like "8.*"){
    
   

# Get the adapter names and whether IPv6 is enabled
$name = Get-NetAdapterBinding -ComponentID ms_tcpip6 | Select-Object Name, Enabled

# Get only the IPv6 addresses
$ip = Get-NetIPAddress | Where-Object { $_.AddressFamily -eq "IPv6" } | Select-Object InterfaceAlias, IPAddress

# Loop through each adapter and find matching IPv6 addresses
foreach ($adapter in $name) {
    # Find matching IP addresses for this adapter
    $adapterIPs = $ip | Where-Object { $_.InterfaceAlias -eq $adapter.Name }

    # If the adapter has IPv6 enabled and an IPv6 address, print them
    if ($adapter.Enabled -and $adapterIPs) {
        foreach ($addr in $adapterIPs) {
            Write-Host "$($adapter.Name) | IPv6 Enabled: $($adapter.Enabled) | IPv6 Address: $($addr.IPAddress)"
        }
    } elseif ($adapter.Enabled) {
        Write-Host "$($adapter.Name) | IPv6 Enabled: $($adapter.Enabled) | IPv6 Address: None"
    }
}
 }

 else{
   Get-WmiObject -Class Win32_NetworkAdapterConfiguration | Where-Object { $_.IPAddress -match ":" } | ForEach-Object {
    $adapterName = $_.Description
    $ipv6Address = $_.IPAddress -match ":" | Out-String
    if ($ipv6Address -ne $null) {
    Write-Output "Adapter Name: $adapterName Adapter| IPV6 Enabled: True| IPv6 Address: $ipv6Address"
    }
    else{
        Write-Output "Adapter Name: $adapterName Adapter| IPV6 Enabled: False| IPv6 Address: $ipv6Address"
    }
}
 }
