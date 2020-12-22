### Powershell

# Enable OpenSSH
Get-WindowsCapability -Online | Where Name -like "OpenSSH.client*" | Add-WindowsCapability -Online

# OpenSSH config file is typically stored at %userprofile%\.ssh\
if(!(Test-Path -Path $env:USERPROFILE\.ssh)){
    Write-Output "Path does not exist"
}
else {
    mkdir $env:USERPROFILE\.ssh
}


GIT Test

