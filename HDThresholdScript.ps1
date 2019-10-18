$comp = Read-Host 'Please Enter Server Name'
Write-Host 'Testing Server Connection' -ForegroundColor Green
if (test-connection $comp -ErrorAction SilentlyContinue){
    Write-Host 'Collecting Drive Data' -ForegroundColor Green
    Get-WmiObject -Class win32_logicaldisk -ComputerName $comp -Filter "DriveType='3'" | select DeviceID, @{n='Freespace (GB)'; e={"{0:n1}" -f ($_.freespace / 1GB)}}, @{n='Size (GB)'; e={"{0:n1}" -f ($_.size / 1GB)}}, @{n='Threshold (%)'; e={"{0:n1}" -f ($_.freespace / $_.size)}} | Format-Table -AutoSize
}# End If
Else {
    Write-Host "Network Connetivity to the server $comp failed" -ForegroundColor red
}# End Else
$end = Read-Host 'Press any key to quite'