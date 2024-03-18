$value = Get-ItemPropertyValue -Path HKLM:\SOFTWARE\WOW6432Node\Tanium\"Tanium Client"\Status -Name "ClientAddress" 
$va = $value -creplace '512:17472:',''
$filtered = $va -replace '(.+?)_.+','$1'
$ips =(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'DHCP'}).IPaddress
if ($ips.length -lt 2){
$ip=(Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'DHCP'}).IPaddress|Select-Object -First 1



}
else
{
$ip1 = (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'DHCP'}).IPaddress|Sort-Object | Select-Object -First 1

$ip2 = (Get-NetIPAddress | Where-Object {$_.AddressFamily -eq 'IPv4' -and $_.PrefixOrigin -eq 'DHCP'}).IPaddress|Sort-Object |Select-Object -Last 1
}
#write-host $ip1
#write-host $ip2
#write-host $ips
#write-host $ip.Length
#write-host $va
#write-host $filtered
#write-host $pattern
#Write-Host $value
if ($ips.Length -lt 2){
    if ($ip -eq $filtered){
    write-host "matches"
     
    }
    else{
    Write-Host "does not match"
     
    }

    
}
else{
    if (($ip1 -eq $filtered) -or ($ip2 -eq $filtered))
    {
    write-host "matches"
    
    }
    else{
    Write-Host "does not match"
    
    }
}