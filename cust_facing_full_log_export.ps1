##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
##IR Response Script, Version 2.1.2          ##
##     Mods to skip csv export               ##
##For Production Use, 11.30.2021!            ##
##**Use for Full log export netstat changed  ##
##PROPERTY OF BARRACUDA SKOUT XDR            ##
##WRITTEN BY Ilan Finkelstein                ##
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##NOTE THIS SCRIPT MUST BE RUN AS AN ADMIN !!##


##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
$stopwatch = [System.Diagnostics.Stopwatch]::new()
$stopwatch.Start()
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
##Collection of Variables to Build Folder    ##
##with IR_NAME_Date(mm.dd..yy) format        ##
$dat_host = $env:COMPUTERNAME
$name = $env:USERNAME
$base = "IR_"
$date = Get-Date -Format "_MM.dd.yy"
$folder = $base+$name+$date
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##\
Write-Output "`r`nStarting to Create Directories"
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
##Create Folder using variables above        ##
New-Item -Path "C:\Users\$name\Desktop" -Name $folder -ItemType "directory" -Force
##Create Folder Path on desktop              ##
$rootPath = "C:\Users\$name\Desktop\$folder\"
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
##Create folder within IR for logs##
New-Item -Path "C:\Users\$name\Desktop\$folder" -Name logs_in_csv -ItemType "directory" -Force
##Create Var to folder ...for reference later##
$logFolderPath = "C:\Users\$name\Desktop\$folder\logs_in_csv\"
##Create folder within IR for other outputs  ##
New-Item -Path "C:\Users\$name\Desktop\$folder" -Name other -ItemType "directory" -Force
##Create Variable to path for reference later##
$otherFolderPath = "C:\Users\$name\Desktop\$folder\other\"
##Create Variable to .evtx collection point  ##
New-Item -Path "C:\Users\$name\Desktop\$folder" -Name logs_in_evtx -ItemType "directory" -Force
##Create Variable to path for reference later##
$evtFolderPath = "C:\Users\$name\Desktop\$folder\logs_in_evtx\"
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
Write-Output "`r`nCollecting Processes and Tasks"
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
##The Others                                 ##
##output active network connections to .txt  ##
$netstat = netstat.exe -ano 
$netstat | Out-File -FilePath "$otherFolderPath\netstat$date.txt" -Force
##output firewall rules                      ##
$fire = Get-NetFirewallRule -PolicyStore ActiveStore
$fire | Export-Csv -NoTypeInformation "$otherFolderPath\firewall$date.csv" -Force
##out open processes to file                 ##
$proc = Get-Process 
$proc | Export-Csv -NoTypeInformation "$otherFolderPath\running_proc_$date.csv" -Force
##out scheduled tasks                        ##
$task = Get-ScheduledTask -TaskName * 
$task | Export-Csv -NoTypeInformation "$otherFolderPath\sch_tasks_$date.csv" -Force
##out services running                       ##
$servRun = Get-Service | Where-Object {$_.Status -eq "Running"}
$servRun | Export-Csv -NoTypeInformation "$otherFolderPath\running_services$date.csv"
##out services stoped                        ##
$servStop = Get-Service | Where-Object {$_.Status -eq "Stopped"}
$servStop | Export-Csv "$otherFolderPath\stopped_services$date.csv"
Get-LocalUser | Select * | Export-csv "$otherFolderPath\LocalUsers$date.csv"
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
Write-Output "Copying .evtx logs"
##Copy winevt folder to event folder path    ##
Copy-Item "C:\Windows\system32\winevt\Logs\*.evtx" -Destination "$evtFolderPath\"

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
Write-Output "Zipping Folder for Export"
##zip folder created and add to desktop with same name
Compress-Archive -Path $rootPath\ -DestinationPath C:\Users\$name\Desktop\$folder.zip -Force
Write-Output "Folder has been created at C:\Users\$name\Desktop\$folder.zip"
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##

##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##
$Stopwatch.Elapsed
##!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!##