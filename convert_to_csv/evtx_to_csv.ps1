##IR RESPONDER 11.15.2021##
##VERSION 1.4.0          ##
##incident resp prep  log##

$evtx_path = $args[0]
$csv_path = $args[1]

$stopwatch = [System.Diagnostics.Stopwatch]::new()
$stopwatch.Start()
$start = (Get-Date).AddDays(-7)
 
Set-Variable -Name LogNames -Value @("Application", "System", "Security", "Microsoft-Windows-Windows Firewall With Advanced Security%4Firewall", 
"Microsoft-Windows-TerminalServices-LocalSessionManager%4Operational", 
"Microsoft-Windows-TerminalServices-RemoteConnectionManager%4Operational", 
"Microsoft-Windows-Bits-Client%4Operational", "Microsoft-Windows-TaskScheduler%4Operational", 
"Microsoft-Windows-PowerShell%4Operational", "Microsoft-Windows-Windows Defender%4Operational")



foreach ($log in $LogNames) {
    Get-WinEvent -Path "$evtx_path\$log.evtx" | Select-Object TimeCreated, Id, ProviderName, UserId, @{n='Message';e={$_.Message -replace '\s+', " "}} | Export-Csv -NoTypeInformation -Path "$csv_path\$log.csv" -Force
    Write-Output "Converting $log to csv"
}

Write-Output "Files have been added to $csv_path"

$Stopwatch.Elapsed