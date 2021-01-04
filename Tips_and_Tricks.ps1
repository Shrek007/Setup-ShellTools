# filter a string for a pattern, much like grep (use Powershell 7.0+ for syntax highlighting)
"This is a test" | select-string -pattern "is"

# Convert any object output to a single string
Get-NetTCPConnection | Out-String | Select-String 80        # get tcp connectection | convert to single string | "grep"

# Convert any object output to multiple lines of strings
Get-NetTCPConnection | Out-String -stream | Select-String 80

# Kill a process by PID
Stop-process -ID 1337 -Force

# List all properties of an instance of an object
$someObject | Select-Object *                   # Hash Table
$someObject | Format-List -Property *           # Mix of objects w/ properties

# List all members (info associated w/ objects) of a PS Object
$someObject | Get-Member

# You can pipe things into and out of powershell where-ever you can call it (including in powershell)
"ls" | powershell
powershell -help

# Save command output to a variable or file AND continue sending it down the pipeline
# Useful for testing or when you need to split the output but continue on...
# default param is to assume -FilePath
HOSTNAME.EXE | Tee-Object -FilePath C:\somelog.txt                      # overwrite logfile
HOSTNAME.EXE | Tee-Object -FilePath C:\somelog.txt -Append              # append to logfile
HOSTNAME.EXE | Tee-Object -FilePath C:\somelog.txt C:\otherLog.txt      # multiple logfiles
HOSTNAME.EXE | Tee-Object -Variable someVar                             # variable $someVar
HOSTNAME.EXE | tee -variable X | nslookup; echo $X                      # save variable for later

# Powershell cmdlets / functions can be grouped as follows
#   Powershell Version -> PS Provider -> Command -> Members (methods, properties, etc.)

###########
# https://stackify.com/powershell-commands-every-developer-should-know/
# https://www.pdq.com/powershell/
# https://www.comparitech.com/net-admin/powershell-cheat-sheet/
# https://www.tutorialspoint.com/powershell/powershell_quick_guide.htm
  
# https://docs.microsoft.com/en-us/powershell/scripting/developer/cmdlet/approved-verbs-for-windows-powershell-commands?view=powershell-7.1
##########
#   Search/Find Commands
#   LEARN
Get-Command

#   How to use Commands
#   LEARN
Get-Help

#   Get command aliases
#   VIEW STATE / GET INFO
Get-Alias

#   Configure command aliases
#   CONFIG SETTINGS
Set-Alias

#   Configure Env. to USE tools
#   PRE-REQUISITS / 
Set-ExecutionPolicy

#   Find script execution settings
#   VIEW STATE / GET INFO
Get-ExecutionPolicy

#   View list of services
#   VIEW STATE / GET INFO
Get-Service

#   Convert to HTML
#   FORMAT OUTPUT
ConvertTo-Html

#   Convert to CSV
#   FORMAT OUTPUT
Export-Csv

#   Filter objects
#   SORT / FILTER
Where-Object

#   Select properties of object(S), objects from array
#   SORT / FILTER
Select-Object

#   Grep for strings
#   SORT / FILTER
Select-String -Pattern "Sometext"

#   Grep for XML (avoids the tags)
#   SORT / FILTER
Select-Xml

#   View event log(s)
#   VIEW STATE / GET INFO
Get-EventLog -Log "Application"

#   View and list Windows event logs
#   VIEW STATE / GET INFO
Get-WinEvent -ListLog *
Get-WinEvent -LogName System

#   View list of currently running processes
#   VIEW STATE / GET INFO
Get-Process

#   Delete command history
#   DELETE DATA
Clear-History

#   Performs an operation against each item in a collection of input objects
#   Can be used to pass $_.property to cmdlets that dont accept piped inputs
#   FORMAT INPUT
ForEach-Object

#   Delete content of a file(s)
#   DELETE DATA
Clear-Content

#   Set Restore Point for computer
#   SAVE STATE
Checkpoint-Computer

#   Find out if 2 objects are equal
#   SORT / FILTER
Compare-Object

#   Convert String(s) to Hash Table Object (Name:Value pair)
#   Name=Value
#   FORMAT OUTPUT
ConvertFrom-StringData

#   Encrypts a string, 
#   if no key is provided then Secure String will only be viewable with user account on workstation it was encrypted
#   FORMAT OUTPUT
ConvertTo-SecureString

#   Decrypts a Secure String object
#   FORMAT OUTPUT
ConvertFrom-SecureString

#   Creates XML representation of PS Object
#   FORMAT OUTPUT
ConvertTo-Xml

#   Convert CLI output in pipeline to XML file
#   FORMAT OUTPUT
Export-Clixml

#   Write values to Registry
#   CONFIG SETTINGS
New-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\MyApp -Name MyKey -Value 1 -PropertyType DWord -Force
Set-ItemProperty -Path Registry::HKEY_LOCAL_MACHINE\Software\MyApp -Name MyKey -Value 1 -Type DWord

#   Creates an instance of either a .NET object OR a COM object
#   SAVE STATE
New-Object

#   Adds custom properties and methods to an instance of a PS object
#   CONFIG SETTINGS
Add-Member

#   Monitor Progress of something in powershell
#   MONITOR
Write-Progress

#   Managing processes and scripts as background jobs
#   Provides a way to use multithreading
#   ACTION
Debug-Job
Get-Job
Receive-Job
Remove-Job
Start-Job
Stop-Job
Wait-Job

#   Programatically Debug, tshoot, test, and monitor a process
#   MONITOR
Debug-Process

#   Access performanace monitor counter data
#   MONITOR
Get-Counter

#   Export performance monitor counter readings to file
#   FORMAT OUTPUT
Export-Counter

#   Check if file path exists
#   ENUMERATION
Test-Path

#   Calculate timing for scripts/commands
#   GET INFO
Measure-Command

#   Calculate numeric properties of an object
#   GET INFO
Measure-Object

#   List files and folders  -  aliases: ls, dir
#   GET INFO
Get-ChildItem

#   Move to directory       -  aliases: cd, chdir
#   ACTION
Set-Location

#   Gets content of a file  -  aliases: cat, type
#   GET INFO
Get-Content

#   Add data to file
#   WRITE DATA
Add-Content

#   Overwrite data to a file
#   WRITE DATA
Set-Content

#   Execute code with local context on a remote machine; Output relayed to local session
#   ACTION / REMOTE CODE EXECUTION?
Invoke-Command -ComputerName $PC -Credential $pass -ScriptBlock {hostname}
Invoke-Command -Session $session -ScriptBlock {hostname}

#   Check if WinRM (used for PSremoting) is running on machine
#   VIEW STATUS / GET INFO
Test-WSMan -ComputerName $PC

# ???
Invoke-Item
Get-Event
Add-History                     # use case?
Set-AuthenticodeSignature
New-AppLockerPolicy
Set-StrictMode
#   Question:   Get-Process   VS.   Get-Service