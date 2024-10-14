::::::::::::::::
:: CMD prompt ::
::::::::::::::::

:: Temp Admin
net user /add tempadmin P@ssw0rd
net localgroup administrators tempadmin /add

:: Hide shutdown options
REG ADD HKLM\SOFTWARE\Microsoft\PolicyManager\current\device\Start\ /v HideShutDown /t REG_DWORD /d 1

:: Clear Printer Spooler
net stop spooler
del %systemroot%\System32\spool\printers\* /Q
net start spooler

:: MSI
msiexec /i somename.msi ALLUSERS=1    # install for all users

:: AAD registration tshoot
dsregcmd /status
dsregcmd /leave   # followed by a reboot

:: Set Default Apps
assoc > assoc.txt           :: FileExtension to AppID
ftype > ftype.txt           :: AppID to Executable

:: Adobe
assoc .pdf=Acrobat.Document.DC
ftype Acrobat.Document.DC="C:\Program Files\Adobe\Acrobat DC\Acrobat\Acrobat.exe" "%1"

assoc .aaui=Acrobat.aaui
assoc .acrobatsecuritysettings=Acrobat.acrobatsecuritysettings
assoc .api=Acrobat.Plugin
assoc .bpdx=AcrobatBPDXFileType
assoc .fdf=Acrobat.FDFDoc
assoc .pdf=Acrobat.Document.DC
assoc .pdfxml=Acrobat.pdfxml
assoc .pdx=AcrobatPDXFileType
assoc .rmf=Acrobat.RMFFile
assoc .secstore=Acrobat.SecStore
assoc .sequ=Acrobat.Sequence
assoc .xdp=Acrobat.XDPDoc
assoc .xfdf=Acrobat.XFDFDoc

:: Outlook

assoc .det=Outlook.File.det.15
assoc .eml=Outlook.File.eml.15
assoc .fdm=Outlook.File.fdm.15
assoc .hol=Outlook.File.hol.15
assoc .ics=Outlook.File.ics.15
assoc .msg=Outlook.File.msg.15
assoc .nk2=Outlook.File.nk2.15
assoc .nst=Outlook.File.nst.15
assoc .ofs=Outlook.File.ofs.15
assoc .oft=Outlook.File.oft.15
assoc .ost=Outlook.File.ost.15
assoc .otm=Outlook.File.otm.15
assoc .pab=Outlook.File.pab.15
assoc .pst=Outlook.File.pst.15
assoc .vcf=Outlook.File.vcf.15
assoc .vcs=Outlook.File.vcs.15
ftype feed="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype feeds="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype mailto="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" -c IPM.Note /mailto "%1"
ftype Outlook.File.eml.15=C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE /eml "%1"
ftype Outlook.File.hol.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /hol "%1"
ftype Outlook.File.ics.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /ical "%1"
ftype Outlook.File.msg.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /f "%1"
ftype Outlook.File.oft.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /t "%1"
ftype Outlook.File.pst.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /pst "%1"
ftype Outlook.File.vcf.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /v "%1"
ftype Outlook.File.vcs.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /vcal "%1"
ftype Outlook.URL.feed.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype Outlook.URL.mailto.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" -c IPM.Note /mailto "%1"
ftype Outlook.URL.stssync.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype Outlook.URL.webcal.15="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype stssync="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype webcal="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"
ftype webcals="C:\Program Files\Microsoft Office\Root\Office16\OUTLOOK.EXE" /share "%1"

:: Chrome
ftype ChromeHTML="C:\Program Files\Google\Chrome\Application\chrome.exe" --single-argument %1
