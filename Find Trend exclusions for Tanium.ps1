$data = (Get-ItemPropertyValue -Path HKLM:\SOFTWARE\WOW6432Node\TrendMicro\PC-cillinNTCorp\CurrentVersion\"Real Time Scan Configuration" -Name "ExcludedFile").Replace('|',"`n")


$values = $data -split "`n"


foreach ($line in $values)
{
  #write-host $line
  
   if ($line -like "*Tanium*")
        {
        Write-Host $line
        }
}



