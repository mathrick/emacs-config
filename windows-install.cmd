@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@@@@ REM DO NOT MODIFY THIS LINE
@@@@ goto :_extract
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

# Powershell is insane, we need that
function any { $input | select-object -first 1 }

#################################
############ SETTINGS ###########
#################################
# Review those, make sure they are what you expect,
# then confirm by changing the value of
# $I_have_read_and_understood_the_settings
# to $true

# Your %HOME% will be set to $HOME (or the value you specify), unless
# it's already defined
$homedir = $Env:HOME, $HOME | any

# This is where things that don't have an installer (including Emacs)
# will be unpacked. By default they will just be subdirectories of
# your Download folder, which is fine place IMHO. Make sure it's the
# right path especially if you don't have an English Windows, and the
# folder is called something like "Pobrane"
$installdir = "$homedir\Downloads\"

# Change this to "yes" to signify you're fine with the values above
$I_have_read_and_understood_the_settings = $false
########## END SETTINGS ##########

if (!$I_have_read_and_understood_the_settings) 
{
        Write-Warning "You need to review and confirm the settings at the start of this script first."
        Write-Warning "Aborting."
        exit
}

$tmpdir = $Env:TMP, $Env:Temp | any

$bzrurl = "https://launchpad.net/bzr/2.6/2.6b1/+download/bzr-2.6b1-1-setup.exe"
# The current installer for git (including 1.9.0) doesn't allow us to set
# PATH in the silent install mode
$giturl = "http://msysgit.googlecode.com/files/Git-1.9.0-preview20140217.exe"
$curlurl = "http://www.confusedbycode.com/curl/curl-7.33.0-win32.msi"
$tlsurl = "ftp://ftp.gnutls.org/gcrypt/gnutls/w32/gnutls-3.2.9-w32.zip"
$lxmlurl = "ftp://ftp.zlatkovic.com/libxml/libxml2-2.7.8.win32.zip"

$web = New-Object System.Net.WebClient
$url = "http://teusje.files.wordpress.com/2011/02/giraffe-header1.png"
$file = "$pwd\myNewFilename.png"
# $web.DownloadFile($url,$file)

exit
@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
:_extract

@echo off

echo Unpacking the installer...
for /f "skip=4 delims=*" %%a in (%0) do (echo %%a >> "%~dp0__tmp__extract.ps1")
powershell -ExecutionPolicy unrestricted "%~dp0__tmp__extract.ps1"
del /f "%~dp0__tmp__extract.ps1"
goto :eof

