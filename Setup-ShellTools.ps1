### Powershell

#### Package Managers
# Chocolatey 
Set-ExecutionPolicy AllSigned
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Alias
set-alias -name grep -value Select-String
set-alias -Name read -value Out-String
set-alias -Name nano -Value 'C:\Program Files\Git\usr\bin\nano.exe'

### Git ###
choco install git

### Open SSH ###
# Enable/Add OpenSSH
Get-WindowsCapability -Online | Where Name -like "OpenSSH.client*" | Add-WindowsCapability -Online

# Setup OpenSSH
if(!(Test-Path -Path $env:USERPROFILE\.ssh)){       # OpenSSH config file is typically stored at %userprofile%\.ssh\
    Write-Output "Path does not exist"
}
else {
    mkdir $env:USERPROFILE\.ssh
    New-Item -ItemType file config                  # create empty ssh 'config' file
}