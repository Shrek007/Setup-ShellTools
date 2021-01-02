# filter a string for a pattern, much like grep (use Powershell 7.0+ for syntax highlighting)
"This is a test" | select-string -pattern "is"

# Convert any object output to a single string
Get-NetTCPConnection | Out-String | Select-String 80        # get tcp connectection | convert to single string | "grep"

# Convert any object output to multiple lines of strings
Get-NetTCPConnection | Out-String -stream | Select-String 80

# Kill a process by PID
Stop-process -ID 1337 -Force


###########
# https://stackify.com/powershell-commands-every-developer-should-know/
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
#   SETTINGS
Set-Alias

#   Configure Env. to USE tools
#   PRE-REQUISITS
Set-ExecutionPolicy

#   Find script execution settings
#   VIEW STATE / GET INFO
Get-ExecutionPolicy

#   View list of services
#   VIEW STATE / GET INFO
Get-Service

#   Convert to HTML
#   OUTPUT FORMAT
ConvertTo-Html

#   Convert to CSV
#   OUTPUT FORMAT
Export-Csv

#   Filter objects
#   SORT / FILTER
Where-Object

#   Filter properties
#   SORT / FILTER
Select-Object

#   View event log(s)
#   VIEW STATE / GET INFO
Get-EventLog -Log "Application"

#   View list of currently running processes
#   VIEW STATE / GET INFO
Get-Process

#   Delete command history
#   DELETE DATA
Clear-History


# ???
Invoke-Item
Get-Event
Add-History     # use case?
Set-AuthenticodeSignature
#   Question:   Get-Process   VS.   Get-Service