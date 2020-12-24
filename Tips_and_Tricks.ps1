# filter a string for a pattern, much like grep (use Powershell 7.0+ for syntax highlighting)
"This is a test" | select-string -pattern "is"

# Convert any object output to a single string
Get-NetTCPConnection | Out-String | Select-String 80        # get tcp connectection | convert to single string | "grep"

# Convert any object output to multiple lines of strings
Get-NetTCPConnection | Out-String -stream | Select-String 80

# Kill a process by PID
Stop-process -ID 1337 -Force