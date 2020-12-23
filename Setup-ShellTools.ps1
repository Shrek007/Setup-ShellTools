### Powershell

# Enable OpenSSH
Get-WindowsCapability -Online | Where Name -like "OpenSSH.client*" | Add-WindowsCapability -Online

# Setup OpenSSH
if(!(Test-Path -Path $env:USERPROFILE\.ssh)){       # OpenSSH config file is typically stored at %userprofile%\.ssh\
    Write-Output "Path does not exist"
}
else {
    mkdir $env:USERPROFILE\.ssh
    New-Item -ItemType file config                  # create empty ssh 'config' file
}


