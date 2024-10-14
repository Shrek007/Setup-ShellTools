### CW Control
#!ps
#!cmd
#maxlength=50000
#timeout=990000
sfc /scannow
dism /online /cleanup-image /restorehealth
sfc /scannow

# New Local Admin
#!ps
#maxlength=50000
#timeout=990000
$Password = Read-Host -AsSecureString
$params = @{
    Name        = 'TempAdmin'
    Password    = $Password
    Description = 'Description of this account.'
}
New-LocalUser @params

### Azure Cloudshell
# Remove Empty Resource Groups
$allResourceGroups = Get-AzResourceGroup | Select-Object ResourceGroupName
$usedResourceGroups = Get-AzResource | Group-Object ResourceGroupName | Select-Object Name
$emptyResourceGroups = $allResourceGroups | Where-Object {$_.ResourceGroupName -notin $usedResourceGroups.Name}
$emptyResourceGroups | Remove-AzResourceGroup -WhatIf

### Azure AD
# AAD registration - get all pending devices, export to .csv
Get-AzureADDevice -all $true |  Where-Object{($_.DeviceTrustType -eq"ServerAd") -and ($_.ProfileType -ne"RegisteredDevice") -and (-not $_.AlternativeSecurityIds)} | select-object -Property AccountEnabled, ObjectId, DeviceId, DisplayName, DeviceOSType, DeviceOSVersion, DeviceTrustType | export-csv pendingdevicelist-summary.csv -NoTypeInformation

# Install-Module -Name Az -Scope CurrentUser -Repository PSGallery -Force       //Connect-AzAccount
# Install-Module -Name AzureAD                                                  //Revoke-AzureADUserAllRefreshToken
# Connect-AzAccount
Get-AzureADUser -SearchString aaleksejev@contoso.ca | Revoke-AzureADUserAllRefreshToken

# Org Chart excel for import into Visio
Get-AzureADUser | Select-Object -first 3 | Get-AzureADUserManager

### Exchange Online
# Add rooms to roomlist
Get-DistributionGroup | Select-Object -First 1 | Format-List | Out-String -Stream | Select-String -Pattern "Room*"
New-DistributionGroup -Name "Meeting Rooms" -RoomList                                   # Create the roomlist Distribution Group
Add-DistributionGroupMember -Identity "Meeting Rooms" -Member "room_101@contoso.ca"    # Add Room mailboxes to the roomlist Distribution Group

# Get all mailboxes a user has access permissions to
Get-Mailbox -ResultSize Unlimited | Get-MailboxPermission -user "John Doe"

# Calendar Permissions
Get-Mailbox -ResultSize Unlimited | ForEach-Object {Get-MailboxFolderPermission $_":\calendar"} | Sort-Object -Property Identity | Select-Object -Unique Identity                       #List All Calendars
Get-Mailbox -ResultSize Unlimited | ForEach-Object {Get-MailboxFolderPermission $_":\calendar"} | Where-Object {$_.User -like "Default"} | Select-Object Identity, User, AccessRights   #List All Calendar Permissions
Get-Mailbox -ResultSize Unlimited | ForEach-Object {Get-MailboxFolderPermission $_":\calendar"} | Where-Object {$_.User -like "John Doe"} | Select-Object Identity, User, AccessRights  #List Calendar Permissions a user has access rights for

# Get Access Rights for a Calendar
Get-EXOMailboxFolderPermission -Identity "john doe:\calendar"

$email = get-user -anr anthony | select -ExpandProperty WindowsEmailAddress | Out-ConsoleGridView; Get-MailboxFolderPermission -Identity $email':\calendar'

# Give user access to calandar
$email = get-user -anr anthony | select -ExpandProperty WindowsEmailAddress | Out-ConsoleGridView; Add-MailboxFolderPermission -Identity $email':\calendar' -User jdoe -AccessRights Reviewer -SendNotificationToUser:$true

Add-MailboxFolderPermission -Identity jdoe@contoso.ca:\calendar -user vchristensen@contoso.ca -AccessRights Editor

Add-MailboxFolderPermission -Identity room_101@contoso.ca:\calendar -user jdoe@contoso.ca -AccessRights Editor                      #Merit Boardroom
Add-MailboxFolderPermission -Identity room_102@contoso.ca:\calendar -user jdoe@contoso.ca -AccessRights Editor                      #Contoso Meeting Room
Add-MailboxFolderPermission -Identity room_103@contoso.com:\calendar -user jdoe@contoso.ca -AccessRights Editor                     #Training Room AB
Add-MailboxFolderPermission -Identity room_C@contoso.ca:\calendar -user jdoe@contoso.ca -AccessRights Editor                        #Training Room C
Add-MailboxFolderPermission -Identity Room_calbdrm@contoso.ca:\calendar -user jdoe@contoso.ca -AccessRights Editor                  #Calgary Boardroom
Add-MailboxFolderPermission -Identity Room_HamptonHotel_EdmStAlbert@contoso.ca:\calendar -user jdoe@contoso.ca -AccessRights Editor #Hampton Hotel - St. Albert Room



# Give user $NeedAccess access to user $Resource mailbox
$NeedAccess= "jdoe@contoso.ca"
$Resource  = "alice@contoso.ca"
Add-MailboxPermission -Identity $NeedAccess -User $Resource -AccessRights FullAccess -AutoMapping:$true -InheritanceType All    #Full Access
Add-RecipientPermission $NeedAccess -AccessRights SendAs -Trustee $Resource                                                     #Send As
Get-Mailbox $NeedAccess | Set-Mailbox -GrantSendOnBehalfTo $Resource                                                            #Send on Behalf

# Spoofing Intelligence
Get-SpoofIntelligenceInsight | Sort-Object SpoofedUser | Where-Object {$_.SendingInfrastructure -like "*constantcontact*"} | Format-Table

# Show all User Mailboxes with forwarding
Get-Mailbox -ResultSize Unlimited -RecipientTypeDetails UserMailbox | Select-Object UserPrincipalName,ForwardingSmtpAddress,ForwardingAddress,DeliverToMailboxAndForward |
Sort-Object UserPrincipalName | Where-Object {$_.DeliverToMailboxAndForward -eq 'True'} | Export-Csv -Path $HOME\Downloads\fwdmailbox.csv

# Get All M365 groups Board members are a part of
get-azureaduser -All $True | Where-Object {$_.DisplayName -like "*Board)"} | Get-AzureADUserMembership | Select-Object -Unique ObjectID,DisplayName

# List all members in Distribution Lists, and find members where the name matches
$guidlist = Get-DistributionGroup -ResultSize Unlimited | Select-Object -ExpandProperty Guid | Select-Object -ExpandProperty Guid
Foreach ($guid in $guidlist) {Get-DistributionGroupMember -Identity $guid | Where-Object {Name -like "*ignon*"}}

# Tenant Allow/Block List
New-TenantAllowBlockListItems -ListType Sender -Block -Entries "test@badattackerdomain.com","test2@anotherattackerdomain.com" -ExpirationDate 8/20/2022

# New-TenantAllowBlockListItems -ListType Sender -Allow -Entries "cjack@flintcorp.com" -NoExpirationDate  //-Allow does not work according to Microsoft

### Sharepoint
# Tenant Rename
Connect-SPOService -Url "https://contoso-admin.sharepoint.com"
Start-SPOTenantRename -DomainName "contosoca" -ScheduledDateTime "2022-04-29T22:00:00" -WhatIf  # RenameJobID : b86be11a-ae8b-45c0-9f30-b71660768ea0
Stop-SPOTenantRename

Get-SPOTenantRenameStatus

### Workstations
# Registry Keys - Create
New-Item
# Registry Values - Create
New-ItemProperty
# Registry Values - Rename Value
Rename-ItemProperty -Name theOldName -NewName theNewName
# Registry Values - Create/Update
Set-ItemProperty -Path HKCU:\Software\Techsnips -Name somename -value "the value" -Type String
# Registry Values -
Computer\HKEY_CURRENT_USER\SOFTWARE\Microsoft\Office\Outlook\Addins\MaThinOutlookAddin.Connect
Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Office\Outlook\Addins\MaThinOutlookAddin.Connect


# Disable Wifi Adapter
Disable-NetAdapter -Name "Adapter-Name" -Confirm:$false

# Time Settings
Set-TimeZone -Id "Mountain Standard Time"

# Set DNS to use DHCP settings for WiFi Adapter  //Admin Required
$wifiInterfaceId = get-netadapter | Where-Object{$_.Name -eq "Wi-fi"} | Select-Object -first 1 ifindex; Set-DnsClientServerAddress -InterfaceIndex $wifiInterfaceId.ifIndex -ResetServerAddresses

# Rebuild outlook profile
Get-ControlPanelItem *mail* | Show-ControlPanelItem

# Close all open windows
Get-Process | Where-Object {$_.MainWindowTitle -ne ""} | stop-process

# Create shortcut on desktop for all users
$SourceFilePath = "\\WT-SRV03\amjay\formmgr\formmanager.exe"
$ShortcutPath = "C:\Users\Public\Desktop\Contactless forms.lnk"
$WScriptObj = New-Object -ComObject ("WScript.Shell")
$shortcut = $WscriptObj.CreateShortcut($ShortcutPath)
$shortcut.TargetPath = $SourceFilePath
$shortcut.Save()

### User Setup
# Default App Associations - Elevated Shell
dism /online /Export-DefaultAppAssociations:"%UserProfile%\Desktop\MyDefaultAppAssociations.xml"

dism /online /Import-DefaultAppAssociations:"%UserProfile%\Desktop\MyDefaultAppAssociations.xml"
dism /Online /Remove-DefaultAppAssociations

### AD
# Sync to M365
Invoke-Command -ComputerName "SRV01" -ScriptBlock {
    echo nn | gpupdate.exe /force;
    Start-ADSyncSyncCycle -PolicyType Delta
}

#
$x = "John Doe, Alice Algo, Bob Block"
$y = $x.split(",") | Select-Object -Unique
foreach($line in $y){Get-ADUser -Filter 'Name -like $y' | Get-ADPrincipalGroupMembership | Where-Object {$_.GroupCategory -eq "Distribution"} | Select-Object Name}


# Job Titles per OU
$ou = 'OU=Contoso Staff,DC=ContosoNet,DC=local'
Get-ADUser -Filter * -Properties Department,Title,Company -SearchBase $ou| Sort-Object Name | Select-Object Name,Title,Department,Company | Format-Table

Get-ADUser -Identity $SamAccountName     # Confirmation of New User

# Template - Copy User
$template_account = Get-ADUser -Identity 'Jane Doe' -Properties Department,Title
$template_account.UserPrincipalName = $null

New-ADUser `
    -Instance $template_account `
    -Name 'James Brown' `
    -SamAccountName 'jbrown' `
    -AccountPassword (Read-Host -AsSecureString "Input User Password") `
    -Enabled $True

# Template - New User from flat file
$import_users | ForEach-Object {
    New-ADUser `
        -Name $($_.FirstName + " " + $_.LastName) `
        -GivenName $_.FirstName `
        -Surname $_.LastName `
        -Department $_.Department `
        -State $_.State `
        -EmployeeID $_.EmployeeID `
        -DisplayName $($_.FirstName + " " + $_.LastName) `
        -Office $_.Office `
        -UserPrincipalName $_.UserPrincipalName `
        -SamAccountName $_.SamAccountName `
        -AccountPassword $(ConvertTo-SecureString $_.Password -AsPlainText -Force) `
        -Enabled $True
}

### PDFs - PSWritePDF
#Install-Module PSWritePDF

# Merge PDFs
$x = ls ./source | select -ExpandProperty Versioninfo | select -ExpandProperty FileName;
Merge-PDF -InputFile $x -OutputFile C":\Users\aaleksejev\Documents\Source.pdf"

# Split PDFs
# [Param]SplitCount  //every X pages, make new PDF. Any remainder ends up in last PDF, no buffer pages
Split-PDF -FilePath .\testOutput.pdf -SplitCount 2 -OutputFolder "C:\Users\aaleksejev\code\PDFmerge\destination\"

# Rename - Remove Filler Name and Pad Left
ls -file | Rename-Item -NewName {($_.Name).Replace("OutputDocument","")}    # FillerName23.pdf -> 23.pdf
ls -file | Rename-Item -NewName {($_.Name).PadLeft(8,'0')}                  # 23.pdf -> 0023.pdf

### PDF SPLIT & MERGING - Enrollment Cards
$root = 'C:\Users\aaleksejev\Downloads\temp\2007-top\2007\'
$redtag = $root+'redtag\'
$destination = $root+'destination\'
$totalFileCount = ls $root -file | measure | select -ExpandProperty Count
$percentComplete = 1
$files = ls $root -file

ls $redtag -File | rm

Foreach ($file in $files){
    Write-Progress -Activity "Extracting PDFs" -Status "Processing PDF #: $percentComplete / $totalFileCount" -PercentComplete ($percentComplete/$totalFileCount)

    Split-PDF -FilePath $($file.VersionInfo | Select -ExpandProperty FileName) -SplitCount 1 -OutputFolder $redtag -OutputName $percentComplete"OutputFile"
    ls $redtag -file | select -last 1 | Copy-Item -Destination $destination$percentComplete".pdf"
    Remove-Item $redtag'*'
    $percentComplete++
}

### 2024 Rate Renewal Letters

$params =@{
    Path = "C:\Users\aaleksejev\Downloads\File Upload Tracking - Anthony.xlsx"
    WorksheetName = "File Uploads"
    ImportColumns = 8                                                                                   #Column Index
}

$fileList = Import-Excel @params

foreach ( $item in $fileList) {
     echo $item.'File Name'
}

### PGP Keys
# Create a key pair
New-PGPKey -FilePathPublic ./TestingPGP_public.asc -FilePathPrivate ./TestingPGP_private.asc