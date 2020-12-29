### Powershell

### Functions
function Get-file_exists {
    param (
        $Path
    )
    
    if(!(Test-Path -Path $Path)){
        Write-Output "Path to does not exist for:"
        Write-Output "$Path"
        Write-Output "Returning False..."
        return $false
    }
    else {
        return $Path
    }
}

#### Package Managers
# Chocolatey 
Set-ExecutionPolicy AllSigned
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))


# Alias
$multi_line_aliases = @'
set-alias -name grep -value Select-String
set-alias -Name read -value Out-String
set-alias -Name nano -Value 'C:\Program Files\Git\usr\bin\nano.exe'
'@

### Setup Profile
if ((Get-file_exists -Path $profile) -eq $true) {
    Write-Output "Profile exists:"
    Write-Output $profile

    Set-Content -Value $multi_line_aliases -Path $profile
}

# Alias - SEE Alias section above
#set-alias -name grep -value Select-String
#set-alias -Name read -value Out-String
#set-alias -Name nano -Value 'C:\Program Files\Git\usr\bin\nano.exe'

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
    New-Item -ItemType file -Name config                  # create empty ssh 'config' file
}